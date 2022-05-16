---
layout: posts
title: IPC with polymorphic objects and System.Text.Json Serialization
tags: .NET
---

# Inter Process Communication with Anonymous Pipes, polymorphic objects and System.Text.Json Serialization (C#, .NET 6)



## The task
I have two processes. Process `A` creates graphical objects, process `B` displays these objects on the screen. To do this, the objects must be transferred from `A` to `B`. The tools for this are quickly found: The objects can be serialized to a string with `System.Text.Json` in process `A` and deserialized in process `B`. Anonymous pipes can be used to transfer the strings from `A` to `B`. The difficulties lie in the details...

## Polymorphic serialization and deserialization
The classes to be transferred are polymorphic. `System.Text.Json` doesn't handle that very well. In addition, the base class contains further subclasses, which are also polymorphic. That makes it a little bit more difficult. In simplified terms, there are the following classes: The `ScreenObject` class is the base class with basic properties that every object to be drawn has. Derived from this are two classes `ScreenLine` (a line) and `ScreenFigure` (e.g. a polygon). `ScreenFigure` contains a `ShapeBase` property. `ShapeBase` is a base class with two derived classes, `PolygonShape` and `ImageShape`.
```csharp
public class ScreenObject
{
    public int ID { get; set; }
}

public class ScreenLine : ScreenObject
{
    public Vec2D Point1 { get; set; }
    public Vec2D Point2 { get; set; }
}

public class ScreenFigure : ScreenObject
{
    public Vec2D Position { get; set; }
    public double Heading { get; set; }
    public ShapeBase Shape { get; set; }
}

public abstract class ShapeBase
{
    public string Name { get; set; }
}

public class PolygonShape : ShapeBase
{
    public List Polygon { get; set; }
}

public class ImageShape : ShapeBase
{
    public string Path { get; set; }
}
```
ScreenObjects arrive at a central point in Process `A` and must be serialized in order to send them to Process `B` via the pipe. The following example creates a `ScreenFigure` class and passes it to the `SendToOtherProcess` method:
```csharp
public void TestWithFigure()
{
    var figure1 = new ScreenFigure()
    {
        ID = 1,
        Heading = 90,
        Position = (1, 2),
        Shape = new PolygonShape()
        {
            Name = "Arrow",
            Polygon = new() { (-10, 0), (10, 0), (0, 10) }
        }
    };
    SendToOtherProcess(figure1);
}

private void SendToOtherProcess(ScreenObject screenObject)
{ 
    // ...
    string serialization = JsonSerializer.Serialize(screenObject, options);
}
```
If the object is serialized as above, an incorrect serialization will be produced:
```json
{"ID":1}
```
This is because `System.Text.Json` only serializes the properties of the base class (`ScreenObject`) here. The Microsoft documentation  [[1][1]] describes how this can be adjusted via the implementation of a JsonConverter. Based on an answer of "ahsonkhan" on  Stackflow [[2][2]] and an article of Ben Gribaudo [[3][3]] my solution looks like this: The two polymorphic classes `ScreenObject` and `ShapeBase` take care of the correct de/serialization of their derived classes via these methods:
* `JsonTypeDiscrimintorAsInt`: Checks which derived class the object is and returns an appropriate `int` value. This is written to the json serialization as a "TypeValue" property during serialization.
* `JsonWrite`: Casts the object to the correct derived class and calls the Serialize method on that class.
* `JsonRead`: Detects which derived class it is based on the value `typeDiscriminatorAsInt` and calls a deserialization matching the type of the derived class.

For example, the methods of the `ScreenObject` class look like this:
```csharp
public class ScreenObject
{
    internal enum JsonTypeDiscriminator
    {
        ScreenObject = 0,
        ScreenLine = 1,
        ScreenFigure = 2
    }

    internal static ScreenObject JsonRead(ref Utf8JsonReader reader, int typeDiscriminatorAsInt, JsonSerializerOptions options)
    {
        return (JsonTypeDiscriminator)typeDiscriminatorAsInt switch
        {
            JsonTypeDiscriminator.ScreenObject => (ScreenObject)JsonSerializer.Deserialize(ref reader, typeof(ScreenObject), options),
            JsonTypeDiscriminator.ScreenLine => (ScreenObject)JsonSerializer.Deserialize(ref reader, typeof(ScreenLine), options),
            JsonTypeDiscriminator.ScreenFigure => (ScreenObject)JsonSerializer.Deserialize(ref reader, typeof(ScreenFigure), options),
            _ => throw new NotSupportedException(),
        };
    }

    internal static int JsonTypeDiscriminatorAsInt(ScreenObject obj)
    {
        if (obj is ScreenLine) return (int)JsonTypeDiscriminator.ScreenLine;
        else if (obj is ScreenFigure) return (int)JsonTypeDiscriminator.ScreenFigure;
        else if (obj is ScreenObject) return (int)JsonTypeDiscriminator.ScreenObject;
        else throw new NotSupportedException();
    }

    internal static void JsonWrite(Utf8JsonWriter writer, ScreenObject obj, JsonSerializerOptions options)
    {
        if (obj is ScreenLine line) JsonSerializer.Serialize(writer, line, options);
        else if (obj is ScreenFigure figure) JsonSerializer.Serialize(writer, figure, options);
        else if (obj is ScreenObject screenObject) JsonSerializer.Serialize(writer, screenObject, options);
        else throw new NotSupportedException();
    }
}

```

The methods are implemented analogously for the `ShapeBase` class.

For the serialization and deserialization, two JsonConverters suitable for these base classes are created, which receive the above methods as constructor parameters. These two converters are used in the JsonSerializerOptions. With these changes, serialization and deserialization work correctly:

```csharp
        var shapeBaseConverter = new MyJsonConverter<ShapeBase>(ShapeBase.JsonTypeDiscriminatorAsInt, ShapeBase.JsonWrite, ShapeBase.JsonRead);
        var screenObjectConverter = new MyJsonConverter<ScreenObject>(ScreenObject.JsonTypeDiscriminatorAsInt, ScreenObject.JsonWrite, ScreenObject.JsonRead);

        var options = new JsonSerializerOptions
        {
            Converters = { shapeBaseConverter, screenObjectConverter },
		WriteIndented = false
        };

        string serialization = JsonSerializer.Serialize(screenObject, options);

        // Test:
        var deserializedObject = JsonSerializer.Deserialize<ScreenObject>(serialization, options);
```
The deserialized object is  a `ScreenFigure` with all properties.

The code above uses a `MyJsonConverter<T>`. This class takes care of the correct conversion. Its implementation looks like this:

```csharp
    public class MyJsonConverter<T> : JsonConverter<T>
    {
        public delegate int TypeAsIntDelegate(T obj);
        public delegate T ReaderDelegate(ref Utf8JsonReader reader, int typeDiscriminatorAsIn, JsonSerializerOptions options);
        public delegate void WriterDelegate(Utf8JsonWriter writer, T value, JsonSerializerOptions options);


        private readonly TypeAsIntDelegate _typeAsIntDelegate;
        private readonly WriterDelegate _writerDelegate;
        private readonly ReaderDelegate _readerDelegate;

        private static readonly string s_typeDiscriminator = "TypeDiscriminator";
        private static readonly string s_typeValue = "TypeValue";


        public MyJsonConverter(TypeAsIntDelegate typeAsInt, WriterDelegate writer, ReaderDelegate reader)
        {
            _typeAsIntDelegate = typeAsInt;
            _writerDelegate = writer;
            _readerDelegate = reader;
        }

        /// <inheritdoc/>
        public override bool CanConvert(Type type)
        {
            return typeof(T).IsAssignableFrom(type);
        }

        /// <inheritdoc/>
        public override T Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
        {
            var typeDiscriminatorAsInt = ReadToStartOfNextTypeValue(ref reader);
            var newOptions = CreateOptionsWithoutThisConverter(options);
            var result = _readerDelegate(ref reader, typeDiscriminatorAsInt, newOptions);
            ReadEndOfTypeValue(ref reader);
            return result;
        }

        /// <inheritdoc/>
        public override void Write(Utf8JsonWriter writer, T value, JsonSerializerOptions options)
        {
            writer.WriteStartObject();

            var typeAsInt = _typeAsIntDelegate(value);

            writer.WriteNumber(s_typeDiscriminator, typeAsInt);
            writer.WritePropertyName(s_typeValue);

            var newOptions = CreateOptionsWithoutThisConverter(options);

            _writerDelegate(writer, value, newOptions);

            writer.WriteEndObject();
        }

        private static int ReadToStartOfNextTypeValue(ref Utf8JsonReader reader)
        {
            if (reader.TokenType != JsonTokenType.StartObject)
            {
                throw new JsonException();
            }

            if (!reader.Read()
                    || reader.TokenType != JsonTokenType.PropertyName
                    || reader.GetString() != s_typeDiscriminator)
            {
                throw new JsonException();
            }

            if (!reader.Read() || reader.TokenType != JsonTokenType.Number)
            {
                throw new JsonException();
            }

            var typeDiscriminatorAsInt = reader.GetInt32();

            if (!reader.Read() || reader.GetString() != s_typeValue)
            {
                throw new JsonException();
            }
            if (!reader.Read() || reader.TokenType != JsonTokenType.StartObject)
            {
                throw new JsonException();
            }

            return typeDiscriminatorAsInt;
        }
        private static void ReadEndOfTypeValue(ref Utf8JsonReader reader)
        {
            if (!reader.Read() || reader.TokenType != JsonTokenType.EndObject)
            {
                throw new JsonException();
            }
        }

        private JsonSerializerOptions CreateOptionsWithoutThisConverter(JsonSerializerOptions options)
        {
            var newOptions = new JsonSerializerOptions(options);
            foreach (var converter in newOptions.Converters)
            {
                if (converter.GetType() == typeof(MyJsonConverter<T>))
                {
                    newOptions.Converters.Remove(converter);
                    break;
                }
            }

            return newOptions;
        }

    }
```
Essentially, the `MyJsonConverter<T>` code is a generalization of the code from the Microsoft documentation. There is one more special feature: Because we are not dealing with just one but several polymorphic classes (`ShapeObject` and `ShapeBase`), the JsonOptions have to be passed on recursively. However, in order to avoid an endless conversion, the converter currently being used must be removed from the options. The `CreateOptionsWithoutThisConverter` method is used for this.

## Transfer of the serialization with anonymous pipes
Anonymous pipes are used to send the serialized objects from process `A` to process `B`. There is a full example of this in the Microsoft Documentation [[4][4]]. There you can read how to create a `StreamWriter` in process A and a `StreamReader` in process B. In our case, it should be noted that we want to transfer several independent objects successively. On the sender side we transfer the objects like this:

```csharp
string serialization = JsonSerializer.Serialize(screenObject, options);
                _streamWriter.WriteLine(serialization);
                _streamWriter.Flush();
                _serverStream.WaitForPipeDrain();
```

It is important that we separate the objects with a new line and that we flush the stream so that the objects reach the recipient immediately.

The code in the receiver then looks like this:

```csharp
var serialization = await _streamReader.ReadLineAsync();
var screenObject = JsonSerializer.Deserialize<ScreenObject>(serialization, _options);
```

## Conclusion
Overall, the transfer of the objects is implemented with relatively little code. Nevertheless, it would be desirable if `System.Text.Json` offered out-of-the-box options for dealing more easily with polymorphic classes. Maybe in .NET 7?

In this example, the objects had to be transferred between processes. In case the objects should be passed between threads, `System.Threading.Channels` shoud be used (see [[5][5]]). The objects can thus be transferred directly without de/serialization.

## Links

[1]: https://docs.microsoft.com/en-us/dotnet/standard/serialization/system-text-json-converters-how-to "How to write custom converters for JSON serialization - Microsoft Docs"
[2]: https://stackoverflow.com/questions/58074304/is-polymorphic-deserialization-possible-in-system-text-json "c# - Is polymorphic deserialization possible in System.Text.Json?  - Stack Overflow"
[3]: https://bengribaudo.com/blog/2022/02/22/6569/recursive-polymorphic-deserialization-with-system-text-json "Recursive Polymorphic Deserialization with System.Text.Json | Ben Gribaudo"
[4]: https://docs.microsoft.com/en-us/dotnet/standard/io/how-to-use-anonymous-pipes-for-local-interprocess-communication "How to: Use Anonymous Pipes for Local Interprocess Communication - Microsoft Docs"
[5]:  https://devblogs.microsoft.com/dotnet/an-introduction-to-system-threading-channels/ "An Introduction to System.Threading.Channels - .NET Blog"


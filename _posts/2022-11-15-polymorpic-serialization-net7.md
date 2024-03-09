---
layout: posts
title: Serialization and deserialization of polymorphic objects with System.Text.Json and .NET 7
tags: .NET
excerpt_separator: <!--more-->
---

Six months ago, I described how to serialize and deserialize polymorphic objects using System.Text.Json in .NET 6. This was a bit complicated in .NET 6. In **.NET 7** it has improved significantly and is now quite simple.

<!--more-->


## Example

As an example, I use the same classes as in the post I wrote for .NET 6. See [here]({% post_url 2022-05-10-blog-post-inter-process-communication %}) for details.

## Serialization and Deserialization with .NET 7
In .NET 7, the whole thing has become much, much easier. Details can be found in the [Microsoft documentation](https://learn.microsoft.com/en-us/dotnet/standard/serialization/system-text-json/polymorphism?pivots=dotnet-7-0).

It is sufficient to provide the classes with the appropriate `JsonDerivedTypeAttributes`:
```csharp
using System.Text.Json;
using System.Text.Json.Serialization;
using Woopec.Core; // class Vec2D comes from here

[JsonDerivedType(typeof(ScreenObject), typeDiscriminator: "ScreenObject")]
[JsonDerivedType(typeof(ScreenLine), typeDiscriminator: "ScreenLine")]
[JsonDerivedType(typeof(ScreenFigure), typeDiscriminator: "ScreenFigure")]
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

[JsonDerivedType(typeof(PolygonShape), typeDiscriminator: "PolygonShape")]
[JsonDerivedType(typeof(ImageShape), typeDiscriminator: "ImageShape")]
public abstract class ShapeBase
{
    public string Name { get; set; }
}

public class PolygonShape : ShapeBase
{
    public List<Vec2D> Polygon { get; set; }
}

public class ImageShape : ShapeBase
{
    public string Path { get; set; }
}
```
Because we want to deserialize the classes as well as serialize them, we also had to specify a `typeDiscriminator`. If the base class is not abstract, the `typeDiscriminator` must also be specified for the base class (see class `ScreenObject`).  If the class is abstract, you must not specify an `JsonDerivedType` attribute (see class `ShapeBase`).

More you do not have to do!

This test will work: 

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
    
    PerformRoundTrip(figure1);
}

private void PerformRoundTrip(ScreenObject screenObject)
{ 
    string serialization = JsonSerializer.Serialize(screenObject);
    // serialization contains all attributes of figure1
    
    ScreenObject result = JsonSerializer.Deserialize<ScreenObject>(serialization);
    // result is an object of type ScreenFigure and contains all attributes of figure1
}
```
## Conclusion
The improvements in .NET 7 make the technical code you had to write in .NET 6 obsolete (about 100 lines for the example above). It's super simple now.

[PostNet6]: {% post_url 2022-05-10-blog-post-inter-process-communication %} "IPC with polymorphic objects and System.Text.Json Serialization"

### Comment on this post ❤️

I am very interested in what readers think of this post and what ideas or questions they have. The easiest way to do this is to respond to my [anonymous survey](https://forms.office.com/r/S4LLdNSRHu).

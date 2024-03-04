---
layout: posts
title: To be defined
tags: LearnToCode C# HexaFour
image: /assets/images/hexafour/RhombusesWithColors.png
excerpt_separator: <!--more-->
typora-root-url: ..
---

<img src="/assets/images/hexafour/RhombusesWithColors.png" alt="A game board with 5 rows containing several rhombuses. Each rhombus has a different color." style="zoom:78%;" />

Programs can quickly become complicated. The first remedy for complexity is to divide the program into methods. The most important things we need at the beginning are: Definition of methods, parameters, return values, and one rule: avoid changing the values of input parameters. C# records help us to comply with this rule.

<!--more-->

### The beginning of Spaghetti Code

Let's start with program code from the [last HexaFour post][hexafour-08]. I left out the actual program lines and only wrote down how many lines a section consists of:

```csharp
public static void WoopecMain()
{
    var radiusOfToken = 20.0;           // size of the token

    // Draw the edges of a rhombus and register it as a Shape
    // 15 lines of code ...

    // Create elements of the board
    // 30 lines of code ...
    
	// Give each board element a different color
    // 7 lines of code ...
}
```

The program contains more than 50 lines. Because the program was already difficult to understand, comments were added to describe what the following lines do, for example: "Create elements of the board". If we were to continue programming in this way, we would very soon have [Spaghetti code](https://en.wikipedia.org/wiki/Spaghetti_code) that would be difficult to understand.

We can significantly improve the readability of the program if we start breaking the program down into methods.

### Definition of the first simple method

Methods are used to divide the program into smaller chunks. We have already used methods in previous posts, for example `Rotate` and `Move` are methods of the Woopec library. And we have already written code in a method, because `WoopecMain` is also a method. Now we are **defining a new method** for the first time:

```csharp
public static void WoopecMain()
{
    var radiusOfToken = 20.0;           // size of the token
    
    // Draw the edges of a rhombus and register it as a Shape
    RegisterRhombusShape();

    // Create elements of the board
    // 30 lines of code ...
    
	// Give each board element a different color
    // 7 lines of code ...
}

public static void RegisterRhombusShape()
{
    var radius = 20.0;           // size of the token
    var edgeLength = 2 * radius; // length of an edge of the rhombus

    var pen = new Pen();
    pen.Move(edgeLength / 2);
    pen.BeginPoly();
    pen.Rotate(120);
    // and so on (see previous post hexafour post)
    var polygon = pen.EndPoly();
    Shapes.Add("rhombus", polygon);
}
```

In the code above the method `RegisterRhombusShape` is defined. This method consists of several parts:

* The method starts with `private static void`. We won't worry about that for now. For the time being, we start every method like this.
* This is followed by the name of the method. A common convention is that the method name always begins with a capital letter. The method name can consist of several terms and must not contain any spaces. To make it easier to recognize the terms in the method name, each term begins with a capital letter. So in our example: `RegisterRhombusShape`.
* This is followed by two round brackets. These brackets can also contain parameters, we will deal with this later.
* The program code to be executed by the method is placed between the curly brackets. 

The new method is called by`WoopecMain()`. This call executes the program code in `RegisterRhombusShape`. After executing the code in the method, the program returns to `WoopecMain()` and executes the next program lines.

### Method parameters

The above code has a problem: In `WoopecMain` the variable `radiusOfToken` was set to the value 20. This value is also required by `RegisterRhombusShape`. But a method cannot simply access the variables of another method. That is why a separate variable `radius` was defined in `RegisterRhombusShape`.

This can be improved by using method parameters:

```csharp
public static void WoopecMain()
{
    var radiusOfToken = 20.0;           // size of the token
    
    // Draw the edges of a rhombus and register it as a Shape
    RegisterRhombusShape(radiusOfToken);

    // Same code as above
}

public static void RegisterRhombusShape(double radius)
{
    var edgeLength = 2 * radius; // length of an edge of the rhombus
	// Same code as above
}
```

The method name is now followed by a **method parameter** inside the brackets. If there are several, they are separated by a comma. Here we only have the parameter with the name `radius`.  A common convention is that parameter names always start with a lower case letter (like variables). The parameter name is preceded by the **parameter type**. The radius can be a decimal number (for example 20.5), which is why the type `double` is used here.

### Debugging methods

It is best to try out the changed code directly in Visual Studio and use the debugger to see what happens. How to do this is described in the second part of this [post][hexafour-04b]. Try it out right away.

### A method can change the value of parameters

Next, we also want to define methods for "Create elements of the board" and "Give each board element a different color". We could do it something like this:

```csharp
public static void WoopecMain()
{
    var radiusOfToken = 20.0;           // size of the token
    
    // Draw the edges of a rhombus and register it as a Shape
    RegisterRhombusShape(radiusOfToken);

    var boardElements = new List<Figure>();
    
    // Create elements of the board and add them to the list:
    CreateGameBoard(radiusOfToken, boardElements);
    
	// Give each board element a different color
    SetColorOfBoardElements(boardElements);
}

public static void RegisterRhombusShape(double radius)
{
    // Code see above
}

public static void CreateGameBoard(double radius, List<Figure> boardElements)
{
	// Omitted code that sets a few variables (see previous post hexafour post)
    for (var row = 0; row <= maxRow; row++)
    {
        // Omitted code that sets a few variables (see previous post hexafour post)
        for (var column = firstColumn; column <= lastColumn; column += 2)
        {
            var boardElement = new Figure() { Shape = Shapes.Get("rhombus") };
            boardElement.Position = (
                boardLowerLeftX + column * rhombusWidth,
                boardLowerLeftY + row * rhombusHeight
            );
            boardElements.Add(boardElement);
            boardElement.IsVisible = true;
        }
    }
}
    
public static void SetColorOfBoardElements(List<Figure> boardElements)
{
    var hue = 0.0;
    var hueSkip = 360.0 / boardElements.Count;
    foreach (var be in boardElements)
    {
        be.Color = Color.FromHSV(hue, 1, 1);
        hue = hue + hueSkip;
    }
}                                                                 
```

An empty List of the type Figure is created in WoopecMain. This should contain all elements of the board. This empty list is passed as a parameter to the method CreateGameBoard. CreateGameBoard creates new board elements and inserts them into the list. After CreateGameBoard has finished, the list is then passed to SetColorOfBoardElements and all board elements are given the desired color.

It is best to use the debugger again to see what happens here. This is described in the second part of this [post][hexafour-04b]. Try it out right away.

The important point here is that the variable boardElements created in WoopecMain is a so-called **reference type**. If you pass such a variable  as a parameter to a method (in our example CreateGameBoard), and this parameter is changed within the method, then this has a direct effect on the variable and it is changed. This is why the variable boardElements in WoopecMain contains all the elements of the board after calling CreateGameBoard.

But...

### A method should not change the value of its parameters

Take a look at the code from WoopecMain. How can you recognize when elements are entered or changed in the boardElemets list? You can't recognize that at all. This is bad because it makes WoopecMain difficult to understand.

It is therefore better if you get used to the following rule right from the start:

> Write methods in such a way that they do not change the values of their parameters.

Of course, there are always exceptions, but in the vast majority of cases you can manage this. 

### Return values of methods

We can easily change CreateGameBoard to follow the new rule. Because a method can return results to the caller. This works like this:

```csharp
public static List<Figure> CreateGameBoard(double radius)
{
    var boardElements = new List<Figure>();
	// Same code as before
    return boardElements;
}
```

Here, the list of board elements is created within the CreateGameBoard method. The elements are then created and inserted into the list. And at the end, the list is returned to the caller via the **`return` command**. The data type returned by the method must now be specified before the name of the method. This is why the name of the method is no longer preceded by `void` but by `List<Figure>`.

The code in WoopecMain can now be changed to:

```csharp
public static void WoopecMain()
{
    var radiusOfToken = 20.0;           // size of the token

    // Draw the edges of a rhombus and register it as a Shape
    RegisterRhombusShape(radiusOfToken);

    // Create elements of the board and add them to the list:
    List<Figure> boardElements = CreateGameBoard(radiusOfToken);

    // Give each board element a different color
    SetColorOfBoardElements(boardElements);
}
```

Now we can see much better what CreateGameBoard does.

But wait. What does the SetColorOfBoardElements method do with the boardElements? It changes their color. This contradicts our new rule that a method should not change the value of its parameters. 

### Let the compiler prevent you from changing values of method parameters

Can we prevent the value of boardElements from being changed when `SetColorOfBoardElements(boardElements)` is called? **C# records** can be used for such cases. I will explain records in more detail later. For now, it is sufficient to note that a record is normally immutable. For our example, we define a simple record:

```csharp
public record BoardElement(string Shape, Color FillColor, double Row, double Column);
```

With this we have defined something like a simple class that contains all the properties we currently need: a shape name, a color and the row and column where the board element is to be displayed.

The code no longer works with a list of Figures, but with a list of BoardElements. To do this, we need to change the code a little:

```csharp
public static void WoopecMain()
{
    var radiusOfToken = 20.0;           // size of the token
    
    // Draw the edges of a rhombus and register it as a Shape
    RegisterRhombusShape(radiusOfToken);

    // Create elements of the board and add them to the list:
    List<BoardElement> boardElements = CreateGameBoard();
    
    // Give each board element a different color
    SetColorOfBoardElements(boardElements);
}

public static List<BoardElement> CreateGameBoard()
{
    var boardElements = new List<BoardElement>();
    var maxRow = 4;
    var maxColumn = 10;
    for (var row = 0; row <= maxRow; row++)
    {
        var firstColumn = 0;
        var lastColumn = maxColumn;
        if (row % 2 == 1)
        {
            firstColumn = 1;
            lastColumn = maxColumn - 1;
        }

        for (var column = firstColumn; column <= lastColumn; column += 2)
        {
            var boardElement = new BoardElement("rhombus", Colors.Black, row, column);
            boardElements.Add(boardElement);
        }
    }
    return boardElements;
}

public static void SetColorOfBoardElements(List<BoardElement> boardElements)
{
    var hue = 0.0;
    var hueSkip = 360.0 / boardElements.Count;
    foreach (var be in boardElements)
    {
        be.FillColor = Color.FromHSV(hue, 1, 1);
        hue = hue + hueSkip;
    }
}

```

The CreateGameBoard method has become somewhat simpler. It no longer creates Figure objects that are immediately displayed on the screen. Instead, it creates BoardElement objects that specify in their properties what is to be displayed on the screen later.

Method SetColorOfBoardElements has hardly changed. But when you compile the program, there is a compiler error: 

```csharp
	error CS8852: Init-only property or indexer 'BoardElement.FillColor' ...
```

We have achieved what we wanted: The compiler no longer allows method SetColorOfBoardElements to change the value of board elements.

We now change the method so that it no longer changes the parameter boardElements and instead returns a *new list* containing the changed elements:

```csharp
public static List<BoardElement> SetColorOfBoardElements(List<BoardElement> boardElements)
{
    var result = new List<BoardElement>();
    // ...
    foreach (var be in boardElements)
    {
        var changedElement = be with { FillColor = Color.FromHSV(hue, 1, 1) };
        result.Add( changedElement );
        // ...
    }
    return result;
}
```

Using the **with expression** (for more information see [Microsoft Learn](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/operators/with-expression)), the code creates a copy of the BoardElement `be` and changes one of the properties. The result is the `changedElement`. The list of all changed BoardElements is returned by the method as the result.

### Now we're done

Finally, we need a method that actually displays the BoardElements on the screen:

```csharp
public static void DrawBoardElements(List<BoardElement> boardElements, double radius)
{
    foreach (var boardElement in boardElements)
    {
        var figure = new Figure()
        {
            Shape = Shapes.Get(boardElement.Shape),
            Color = boardElement.FillColor,
            Heading = 90
        };

        var boardLowerLeftX = -300;
        var boardLowerLeftY = -100;
        var rhombusWidth = 2 * radius;
        var rhombusHeight = Math.Sqrt(3) * 2 * radius;

        figure.Position = (
                    boardLowerLeftX + boardElement.Column * rhombusWidth,
                    boardLowerLeftY + boardElement.Row * rhombusHeight
                );

        figure.IsVisible = true;
    }
}
```

The main method now looks like this:

```csharp
public static void WoopecMain()
{
    var radiusOfToken = 20.0;
    RegisterRhombusShape(radiusOfToken);
    List<BoardElement> boardElements = CreateGameBoard();
    List<BoardElement> coloredBoardElements = SetColorOfBoardElements(boardElements);
    DrawBoardElements(coloredBoardElements, radiusOfToken);
}
```

The code is now so simple and self-explanatory that it no longer requires any comments. We have turned a main method that was over 50 lines long and hard to understand into a method that can be understood immediately. There is no longer a spaghetti code.

### The bottom line

...

If you still don't find the main method beautiful enough, you can take a look at how to define [extension methods](https://learn.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/extension-methods) in C#. This allows you to make the main method look like this:

```csharp
public static void WoopecMain()
{
    var radiusOfToken = 20.0;
    RegisterRhombusShape(radiusOfToken);
    CreateGameBoard().SetColorOfBoardElements().DrawBoardElements(radiusOfToken);
}
```




### TL;DR


### Comment on this post ❤️

I am very interested in what readers think of this post and what ideas or questions they have. The easiest way to do this is to respond to my [anonymous survey](https://forms.office.com/r/1QnnmuUJHU).

[hexafour-overview]: {% post_url 2023-07-01-hexafour-01-overview %}#overview-of-the-posts-in-this-series
[hexafour-01]: {% post_url 2023-07-01-hexafour-01-overview %}
[hexafour-02]: {% post_url 2023-07-02-hexafour-02-first-program %}
[hexafour-03]: {% post_url 2023-07-14-hexafour-03-draw-a-hexagon %}
[hexafour-04a]: {% post_url 2023-07-23-hexafour-04a-compiler-errors%}
[hexafour-04b]: {% post_url 2023-07-24-hexafour-04b-debugging%}
[hexafour-05]: {% post_url 2023-08-13-hexafour-05-variables-loops-dry %}
[hexafour-06]: {% post_url 2023-09-03-hexafour-06-types-conditions %}
[hexafour-07]: {% post_url 2023-10-29-hexafour-07-board-concept %}
[hexafour-08]: {% post_url 2023-11-19-hexafour-08-using-classes %}



[WoopecDocsMainClasses]: https://frank.woopec.net/woopec_docs/MainClasses.html


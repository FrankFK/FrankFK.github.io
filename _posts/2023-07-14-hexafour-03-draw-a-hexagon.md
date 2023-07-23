---
layout: posts
title: Draw a filled hexagon using simple C# commands (h4-03)
tags: LearnToCode C# HexaFour
excerpt_separator: <!--more-->
typora-root-url: ..
---

The previous post showed how to write your first C# program. Now we will extend the program to draw a filled hexagon. We use the Woopec library to do this. Visual Studio IntelliSense helps us understand the available commands.

<!--more-->

(This post is part of a series. You can find the previous post [here]({% post_url 2023-07-02-hexafour-02-first-program %}) and an overview [here]({% post_url 2023-07-01-hexafour-01-overview %}#overview-of-the-posts-in-this-series).)

### Draw a hexagon

In the last post we drew some lines using Woopec Turtle graphics. Now we want to draw a hexagon. Later we will do it differently, but the easiest way for now is like this:
```csharp
using Woopec.Core;

internal class Program
{
    public static void TurtleMain()
    {
        var seymour = Turtle.Seymour();

        seymour.Left(60);
        seymour.Forward(100);
        seymour.Left(60);
        seymour.Forward(100);
        seymour.Left(60);
        seymour.Forward(100);
        seymour.Left(60);
        seymour.Forward(100);
        seymour.Left(60);
        seymour.Forward(100);
        seymour.Left(60);
        seymour.Forward(100);
    }
}
```

For a hexagon six edges have to be painted, the edges are drawn using the `Forward` method. The parameter `100` specifies that the edge should be 100 pixels long. For each new edge, the turtle first turns right using the `Right` method. The parameter `60` specifies by how many degrees the turtle should rotate. With a value of `360` degrees it would make a complete turn. Because the turtle has to draw six edges, it must rotate by `360 / 6` each time, i.e. by 60 degrees.

### Change the Color

For our planned [HexaFour game]({% post_url 2023-07-01-hexafour-01-overview %}#game-idea) we need to draw filled hexagons. For this we have to extend our program a little bit and learn more Turtle commands.

First we add a statement to the second line of our `TurtleMain` method that changes the **Color**:

```csharp
public static void TurtleMain()
{
    var seymour = Turtle.Seymour();
    seymour.Color = Colors.Red;
```

The statement `seymour.Color = Colors.Red;` changes the color of the turtle to red and all the lines that this turtle draws also become red. The Woopec library contains many such predefined colors. But you can also define your own colors using so-called RGB values. Transparent colors are also possible. And if you prefer to specify colors using the so-called HSV color model, that is also possible. In the following example, the outer circle shows all "rainbow-colors" and the square in the middle shows different variants of the color red:

![Woopec colors. An outer circle shows all "rainbow-colors". A square inside of the circle shows variants of the color red with different values for saturation and color value.](/assets/images/WoopecHSVColorSample.png)

For more information on using colors, see the [Woopec documentation][woopec-doc-helper-classes].

### Visual Studio IntelliSense helps us understand the available commands

What other colors are there? Visual Studio tells us:

![Visual Studio IntelliSense displays a list of all colors in which the word "red" appears.](/assets/images/hexafour/VSShowsColors.png)

As soon as we have typed the dot behind `Colors`, all possibilities are displayed. If we continue typing and type `Red`, all colors in which the text `Red` occurs will be displayed. We can choose any of them. 

This display of available values is one of the many features of Visual Studio **IntelliSense**.  With the help of IntelliSense we can also display more information about a method. For example, if you move the mouse to the method `Left`, a small description of the method and a small example will be displayed:

![IntelliSense displays the comment for the Turtle method "Left ](/assets/images/hexafour/VSIntelliSenseMethodComment.png)

For more information about IntelliSense see [Microsoft Learn](https://learn.microsoft.com/en-us/visualstudio/ide/using-intellisense?view=vs-2022).

### More useful Turtle commands

We can not only change the color of the turtle, we can also hide the turtle so that we only see the lines. To do this, we write this statement:

```csharp
    seymour.HideTurtle();
```

With `seymour.ShowTurtle();` the turtle can be shown again at any place in the program code.

If we only want to see the Turtle and no lines at all, that works too::

```csharp
    seymour.PenUp();
```

The Turtle can also move faster. Just as there are different colors, there are also different speeds:

```csharp
    seymour.Speed = Speeds.Fast;
```

There are five speeds to choose from: `Slowest, Slow, Normal, Fast` and `Fastest`. 

### Turtle commands for drawing a filled polygon

Finally, we create a filled hexagon. For this we need two methods: `BeginFill` before we start drawing and `EndFill` when all parts of the rectangle are painted::

```csharp
public static void WoopecMain()
{
    var seymour = Turtle.Seymour();
    seymour.Speed = Speeds.Fast;
    seymour.Color = Colors.CornflowerBlue;

    seymour.BeginFill();

    seymour.Left(60);
    seymour.Forward(100);
    // ...
    seymour.Left(60);
    seymour.Forward(100);

    seymour.EndFill();
    
    seymour.Color = Colors.DarkOrange;
    seymour.PenUp();
    seymour.Left(30);
    seymour.Forward(50);
}    
```

In this program we used a few other of the Turtle commands discussed. This is the result:

![A blue hexagon with an orange turtle](/assets/images/hexafour/TurtleWithFilledHexagon.png)

Further documentation on Turtle's methods and properties can be found in the [Woopec turtle class documentation][Woopec-doc-turtle-class].

### C# class properties

Maybe you haven't noticed, but in the code examples above we used not only methods (`Left, Forward, BeginFill` etc.), but also something new, which is called a **class property**. A class can have several properties, for example `Color` and `Speed`. You change a property by assigning a different value to it with the `=` character. For example, `seymour.Color = Colors.Red;` 


### Summary

* The Turtle class has more methods: *`ShowTurtle, HideTurtle, PenUp, PenDown, BeginFill, EndFill`*.
* A C# class can also have *properties*. With the '=' character you can change the value of a property.
* The Turtle properties *`Color`*  and *`Speed`* can be used to change the color and speed of the turtle. See the [Woopec helper classes documentation][Woopec-doc-helper-classes] for more information.
* For information about Turtle methods and properties see the [Woopec turtle class documentation][Woopec-doc-turtle-class] or use Visual Studio *IntelliSense*.

### How to go on

In the [next post][hexafour-04] I will explain how to fix compiler errors and howrun the program step by step in the debugger. Until then, you may want to program your own image with Turtle commands.





[Woopec-doc-turtle-class]: https://frank.woopec.net/woopec_docs/Turtle.html

[Woopec-doc-helper-classes]: https://frank.woopec.net/woopec_docs/HelperClasses.html

[hexafour-04]: {% post_url 2023-07-23-hexafour-04-debugging %}

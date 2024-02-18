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

Let's start with the program code from the [last HexaFour post][hexafour-08]. I left out the actual program lines and only wrote down the number of these lines:

```csharp
public static void WoopecMain()
{
    var radiusOfToken = 20.0;           // size of the token

    // Draw the edges of a rhombus and register it as a Shape
    // 15 lines of code ...

    // Create the first game board
    // 30 lines of code ...
    
	// Give each rhombus a different color
    // 7 lines of code ...
}
```

The program contains more than 50 lines. Because the program was already difficult to understand, comments were added to describe what the following lines do, for example: "Create first game board". If we were to continue programming in this way, we would very soon have [Spaghetti code](https://en.wikipedia.org/wiki/Spaghetti_code) that would be difficult to understand.

We can significantly improve the readability of the program if we use methods.

### Definition of the first simple method

We use methods to divide the program into smaller chunks. We have already *used* methods, for example `Rotate` and `Move` are methods of the Woopec library. And we have already written code in a method, because `WoopecMain` is also a method. Now we are **defining a method** for the first time:

```csharp
public static void WoopecMain()
{
    var radiusOfToken = 20.0;           // size of the token
    
    // Draw the edges of a rhombus and register it as a Shape
    RegisterRhombusShape();

    // Create the first game board
    // 30 lines of code ...
    
	// Give each rhombus a different color
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
    // etc.
    var polygon = pen.EndPoly();
    Shapes.Add("rhombus", polygon);
}
```

We have defined a method called `RegisterRhombusShape` here. This method consists of several parts:

* The method starts with `private static void`. We won't worry about that for now. For the time being, we start every method like this.
* This is followed by the name of the method. A common convention is that the method name always begins with a capital letter. The method name can consist of several terms and must not contain any spaces. To make it easier to recognize the terms in the method name, each term begins with a capital letter. So in our example: `RegisterRhombusShape`.
* This is followed by two round brackets. These brackets can also contain parameters, we will deal with this later.
* The program code to be executed by the method is placed between the curly brackets. 

The new method is called in `WoopecMain()`. This call executes the program code in `RegisterRhombusShape`. After executing the code in the method, the program returns to `WoopecMain()` and executes the next program lines.

### Method parameters

The above code has a problem: In `WoopecMain` the variable `radiusOfToken` was set to the value 20. This value is also required by `RegisterRhombusShape`. But a method cannot simply access the variables of another method. That is why a separate variable `radiusOfToken` was defined in `RegisterRhombusShape`.

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

It is best to try out the changed code directly in Visual Studio and use the debugger to see what happens.




### The bottom line


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


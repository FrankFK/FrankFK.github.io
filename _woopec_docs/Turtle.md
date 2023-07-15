---
layout: page
title: Woopec - Turtle-Class
date: 2022-05-02
last_modified_at: 2022-07-23 8:30:00 +0000
typora-root-url: ..
---


## Introduction

The structure of the Woopec Turtle commands was largely taken over from  [pyhton-Turtle-Graphics](https://docs.python.org/3/library/turtle.html#module-turtle). Some things have been adapted to C# (upper/lower case, properties). The range of functions does not come close to that of the great python library. But it's a first step.

## Examples

Let's start with a simple example:
```csharp
    var turtle = Turtle.Seymour();

    turtle.Right(45);
    turtle.Forward(50);
    turtle.Left(90);
    turtle.Forward(100);
    turtle.Right(45);
    turtle.Forward(20);
```
This code produces the following result:

![Woopec C# turtle graphics, result of simple example](/assets/images/FirstSample.png)

The previous example used a predefined turtle `Turtle.Seymour()`. It is also possible to create several turtles. The following example creates two turtles, cynthia and wally. In this example at first cynthia will turn left and move forward, and then wally will turn right and move forward:

```csharp
    var cynthia = new Turtle();
    cynthia.Speed = Speeds.Slowest;
    cynthia.Left(90);
    cynthia.Forward(200);

    var wally = new Turtle();
    wally.Speed = Speeds.Slowest;
    wally.Right(90);
    wally.Forward(200);
```
More information on handling multiple Turtles can be found [here](MultipleTurtles.html).

## How to write your own program?

You only have to install Visual Studio and download the Woopec package. [Getting started](GettingStarted.html) describes this in more detail.

Then you can write your first turtle program. [Getting started](GettingStarted.html) describes this in more detail.


Your program must have a main-method named `TurtleMain()`, this method is started automatically:

```csharp
    public static void TurtleMain()
    {
        var turtle = Turtle.Seymour();
        turtle.Forward(50);
    }
```

Because Woopec (currently) uses WPF, the code must run on a Windows Computer.

## Overview of Methods

The following table gives a short overview of all methods. The methods are described in more detail by code comments.
The IntelliSense-Feature of Visual Studio shows these comments when you move the mouse over the name of the method:

![IntelliSense](/assets/images/IntelliSense.png)

### Turtle class

| Method                                           | Description                                                  |
| ------------------------------------------------ | ------------------------------------------------------------ |
| **Move, Draw and Position State:**               |                                                              |
| Forward(double distance)                         | Move forward                                                 |
| Backward(double distance)                        | Move backward                                                |
| Left(double angle)                               | Rotate left                                                  |
| Right(double angle)                              | Rotate right                                                 |
| SetPosition(Vec2D position) GoTo(Vec2D position) | Change position.                                             |
| Position [Type is Vec2D]                         | Get or change position                                       |
| SetHeading(double angle)                         | Change heading (rotate to this heading)                      |
| Heading [Type is double]                         | Get or change heading                                        |
| Speed [Type is Speed]                            | Get or change speed                                          |
| **Drawing state:**                               |                                                              |
| PenUp()                                          | Pull the pen down, drawing when moving                       |
| PenDown()                                        | Pull the pen up, no drawing when moving                      |
| IsDown [Type is bool]                            | Get or change state of pen                                   |
| **Color control:**                               |                                                              |
| PenColor [Type is Color]                         | Pencolor                                                     |
| FillColor [Type is Color]                        | Fillcolor                                                    |
| Color [Type is Color]                            | Change pencolor and fillcolor                                |
| **Visibility and appearance:**                   |                                                              |
| HideTurtle()                                     | Make the turtle invisible                                    |
| ShowTurtle()                                     | Make the turtle visible                                      |
| IsVisible (Type is bool)                         | True if turtle is shown, false if is hidden                  |
| Shape (Type is a Shape)                          | Get or change shape of the turtle                            |
| **Filling:**                                     |                                                              |
| BeginFill()                                      | Start the filling                                            |
| EndFill()                                        | Fill the shape drawn after the last call of BeginFill()      |
| Filling (Type is bool)                           | Return fillstate (true if filling, false else)               |
| **Other**                                        |                                                              |
| Screen (Type is Screen)                          | The screen on which this turtle is drawn                     |
| WaitForCompletedMovementOf(Turtle otherTurtle)   | Wait with next movement for completed movement of the otherTurtle |

### Screen class

| Method                                                  | Description                                                  |
| ------------------------------------------------------- | ------------------------------------------------------------ |
| TextInput(string title, string prompt) [Type is string] | Pop up a dialog window for input of a string. Returns the user-input |
| NumInput(string title, string prompt) [Type is int]     | Pop up a dialog window for input of an integer number. Returns the user-input |
| DoubleInput(string title, string prompt) [Type is double] | Pop up a dialog window for input of a double number. Returns the user-input |
| Bye()                                                   | Shut the window |

### Shapes  class

| Method                                  | Description                                                  |
| --------------------------------------- | ------------------------------------------------------------ |
| Add(string name, `List<Vec2D>` polygon) | Add a polygon to the shapelist                               |
| Add(string name, Shape shape)           | Add a compound shape to the sapelist. A compound shape contains several polygons |
| Get(string name) [Type is Shape]        | Get the shape of the given name                              |
| GetNames() [Type is `List<string>`]     | Get a list of all currently available turtle shape-names     |



### Links

* [Getting started](GettingStarted.html) describes the installation steps.
* [Working with multiple turtles](MultipleTurtles.html) contains information on handling multiple turtles.

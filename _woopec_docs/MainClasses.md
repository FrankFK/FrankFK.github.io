---
layout: page
title: Woopec - Main Classes
date: 2022-05-03
last_modified_at: 2023-07-30 8:30:00 +0000
typora-root-url: ..
---


### Introduction

The [`Turtle` class](Turtle.htlm) is suitable for a very simple start.  For somewhat advanced requirements, the classes listed here can be used.

### Pen class

An instance of this class is a pen, which can draw lines on the screen.

| Method                                                       | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| **Move, Draw and Position State:**                           |                                                              |
| Move(double distance)                                        | Move the pen by the specified distance, in the direction the pen is headed. |
| Rotate(double angle)                                         | Change the heading (drawing direction)                       |
| SetPosition(Vec2D position) or SetPosition(double x, double y) | Change position.                                             |
| Position [Type is Vec2D]                                     | Get or change position                                       |
| Heading [Type is double]                                     | Get or change heading                                        |
| Speed [Type is Speed]                                        | Get or change speed                                          |
| **Drawing state:**                                           |                                                              |
| IsDown [Type is bool]                                        | Get or change state of pen                                   |
| **Color control:**                                           |                                                              |
| Color [Type is Color]                                        | Get or change color                                          |
| **Filling:**                                                 |                                                              |
| BeginFill()                                                  | Start the filling                                            |
| EndFill()                                                    | Fill the shape drawn after the last call of BeginFill()      |
| Filling (Type is bool)                                       | Return fillstate (true if filling, false else)               |
| BeginPoly()                                                  | Start recording the vertices of a polygon.                   |
| EndPoly()                                                    | Stop recording the vertices of a polygon and returns it as a List of Vec2D |
| **Other**                                                    |                                                              |
| Screen (Type is Screen)                                      | The screen on which this pen is drawing                      |
|                                                              |                                                              |

### Figure class

An instance of this class is a figure (for instance the image of a turtle or a bird), which can be moved on the screen.

| Method                                                       | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| **Move, Draw and Position State:**                           |                                                              |
| Move(double distance)                                        | Move the pen by the specified distance, in the direction the pen is headed. |
| Rotate(double angle)                                         | Change the heading (drawing direction)                       |
| SetPosition(Vec2D position) or SetPosition(double x, double y) | Change position.                                             |
| Position [Type is Vec2D]                                     | Get or change position                                       |
| Heading [Type is double]                                     | Get or change heading                                        |
| Speed [Type is Speed]                                        | Get or change speed                                          |
| **Visibility and appearance:**                               |                                                              |
| IsVisible (Type is bool)                                     | True if figure is shown, false if is hidden                  |
| Shape (Type is a Shape)                                      | Get or change the shape of the turtle                        |
| **Color control:**                                           |                                                              |
| OutlineColor [Type is Color]                                 | Get or change the outline color                              |
| FillColor [Type is Color]                                    | Get or change the fill color                                 |
| Color [Type is Color]                                        | Change outline color and fill color                          |
| **Other**                                                    |                                                              |
| Screen (Type is Screen)                                      | The screen on which this turtle is drawn                     |
| WaitForCompletedMovementOf(Turtle otherTurtle)               | Wait with next movement for completed movement of the otherTurtle |

### Screen class

An instance of this class represents the screen to which screen objects (lines, shapes, ...) are drawn.

| Method                                                  | Description                                                  |
| ------------------------------------------------------- | ------------------------------------------------------------ |
| TextInput(string title, string prompt) [Type is string] | Pop up a dialog window for input of a string. Returns the user-input |
| NumInput(string title, string prompt) [Type is int]     | Pop up a dialog window for input of an integer number. Returns the user-input |
| DoubleInput(string title, string prompt) [Type is double] | Pop up a dialog window for input of a double number. Returns the user-input |
| WriteText(string text, Vec2D pos, ...)  | Write a text to a give position, additional parameters for style etc. |
| Bye()                                                   | Shut the window |
| SwitchToUnitTestDefaultScreen()         | For unit tests                                               |
| SwitchToNormalDefaultScreen()           | For unit tests                                               |

### Shapes  class

A list with all usable shapes.

| Method                                  | Description                                                  |
| --------------------------------------- | ------------------------------------------------------------ |
| Add(string name, `List<Vec2D>` polygon) | Add a polygon to the shapelist                               |
| Add(string name, Shape shape)           | Add a compound shape to the sapelist. A compound shape contains several polygons |
| Get(string name) [Type is Shape]        | Get the shape of the given name                              |
| GetNames() [Type is `List<string>`]     | Get a list of all currently available turtle shape-names     |

To access the predefined default shapes, you can use the `Get` method or use predefined Shapes:
```csharp
Shapes.Arrow, Shapes.Circle, Shapes.Square, Shapes.Triangle, Shapes.Classic, Shapes.Turtle, Shapes.Bird
```



### Links

* [Helper classes](HelperClasses.html) describes the value objects `Color`, `Speed` and `Vec2D` which can be used for some properties.
* [Working with multiple objects](MultipleTurtles.html) contains information on handling multiple `Figure` or `Turtle` objects.
* [Turtle class](Turtle.html) describes the turtle class (which is a combination of a pen and a figure).
* [Getting started](GettingStarted.html) describes the installation steps.


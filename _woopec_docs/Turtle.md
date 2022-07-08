---
layout: page
name: Turtle Class
position: Developer
title: Woopec - Turtle-Class
date: 2022-05-02
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

![Woopec C# turtle graphics, esult of simple example](./FirstSample.png)

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

But what can you do if you want him and her to move at the same time? In this case, *both* turtles must be created *before* the first move is performed. In this example cynthia and wally will move at the same time:
```csharp
    var cynthia = new Turtle();
    cynthia.Speed = Speeds.Slowest;

    var wally = new Turtle();
    wally.Speed = Speeds.Slowest;

    cynthia.Left(90);
    cynthia.Forward(200);

    wally.Right(90);
    wally.Forward(200);
```

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

![IntelliSense](./IntelliSense.png)

### Turtle class

| Method                                           | Description                                             |
| ------------------------------------------------ | ------------------------------------------------------- |
| **Move, Draw and Position State:**               |                                                         |
| Forward(double distance)                         | Move forward                                            |
| Backward(double distance)                        | Move backward                                           |
| Left(double angle)                               | Rotate left                                             |
| Right(double angle)                              | Rotate right                                            |
| SetPosition(Vec2D position) GoTo(Vec2D position) | Change position.                                        |
| Position [Type is Vec2D]                         | Get or change position                                  |
| SetHeading(double angle)                         | Change heading (rotate to this heading)                 |
| Heading [Type is double]                         | Get or change heading                                   |
| Speed [Type is Speed]                            | Get or change speed                                     |
| **Drawing state:**                               |                                                         |
| PenUp()                                          | Pull the pen down, drawing when moving                  |
| PenDown()                                        | Pull the pen up, no drawing when moving                 |
| IsDown [Type is bool]                            | Get or change state of pen                              |
| **Color control:**                               |                                                         |
| PenColor [Type is Color]                         | Pencolor                                                |
| FillColor [Type is Color]                        | Fillcolor                                               |
| Color [Type is Color]                            | Change pencolor and fillcolor                           |
| **Visibility and appearance:**                   |                                                         |
| HideTurtle()                                     | Make the turtle invisible                               |
| ShowTurtle()                                     | Make the turtle visible                                 |
| IsVisible (Type is bool)                         | True if turtle is shown, false if is hidden             |
| Shape (Type is a Shape)                          | Get or change shape of the turtle                       |
| **Filling:**                                     |                                                         |
| BeginFill()                                      | Start the filling                                       |
| EndFill()                                        | Fill the shape drawn after the last call of BeginFill() |
| Filling (Type is bool)                           | Return fillstate (true if filling, false else)          |
| **Other**                                        |                                                         |
| Screen (Type is Screen)                          | The screen on which this turtle is drawn                |

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

### A little test (for future use)

Badgen
![Code: Variables, for and while Loops](https://badgen.net/badge/Code/Variables,%20for%20and%20while%20Loops?labelColor=blue&color=grey) ![Practices: Variable-Debugging](https://badgen.net/badge/Practices/Variable-Debugging?labelColor=green&color=grey)  ![Principles: Coding Conventions, DRY](https://badgen.net/badge/Principles/Codinge%20Conventions,%20DRY-Principle?labelColor=yellow&color=grey)

Shield io dynamic
![Code: Variables, for and while Loops](https://img.shields.io/static/v1?labelColor=blue&color=lightgrey&label=Code&message=Variables,%20for%20and%20while%20Loops) ![Practices: Variable-Debugging](https://img.shields.io/static/v1?labelColor=brightgreen&color=lightgrey&label=Practices&message=Variable-Debugging) ![Principles: Coding Conventions, DRY-Principle](https://img.shields.io/static/v1?labelColor=yellow&color=lightgrey&label=Principles&message=Codinge%20Conventions,%20DRY-Principle)


forthebadge static
[![forthebadge](data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNTUuMzUiIGhlaWdodD0iMzUiIHZpZXdCb3g9IjAgMCAxNTUuMzUgMzUiPjxyZWN0IGNsYXNzPSJzdmdfX3JlY3QiIHg9IjAiIHk9IjAiIHdpZHRoPSI4OC44NSIgaGVpZ2h0PSIzNSIgZmlsbD0iIzMxQzRGMyIvPjxyZWN0IGNsYXNzPSJzdmdfX3JlY3QiIHg9Ijg2Ljg1IiB5PSIwIiB3aWR0aD0iNjguNSIgaGVpZ2h0PSIzNSIgZmlsbD0iIzM4OUFENSIvPjxwYXRoIGNsYXNzPSJzdmdfX3RleHQiIGQ9Ik0xMy43OCAxOS40MkwxMy43OCAxOS40MkwxNS4yNyAxOS40MlExNS4yNyAyMC4xNSAxNS43NSAyMC41NVExNi4yMyAyMC45NSAxNy4xMiAyMC45NUwxNy4xMiAyMC45NVExNy45MCAyMC45NSAxOC4yOSAyMC42M1ExOC42OCAyMC4zMiAxOC42OCAxOS44MEwxOC42OCAxOS44MFExOC42OCAxOS4yNCAxOC4yOCAxOC45NFExNy44OSAxOC42MyAxNi44NSAxOC4zMlExNS44MiAxOC4wMSAxNS4yMSAxNy42M0wxNS4yMSAxNy42M1ExNC4wNSAxNi45MCAxNC4wNSAxNS43MkwxNC4wNSAxNS43MlExNC4wNSAxNC42OSAxNC44OSAxNC4wMlExNS43MyAxMy4zNSAxNy4wNyAxMy4zNUwxNy4wNyAxMy4zNVExNy45NiAxMy4zNSAxOC42NiAxMy42OFExOS4zNiAxNC4wMSAxOS43NSAxNC42MVEyMC4xNSAxNS4yMiAyMC4xNSAxNS45NkwyMC4xNSAxNS45NkwxOC42OCAxNS45NlExOC42OCAxNS4yOSAxOC4yNiAxNC45MVExNy44NCAxNC41NCAxNy4wNiAxNC41NEwxNy4wNiAxNC41NFExNi4zMyAxNC41NCAxNS45MyAxNC44NVExNS41MyAxNS4xNiAxNS41MyAxNS43MUwxNS41MyAxNS43MVExNS41MyAxNi4xOCAxNS45NiAxNi41MFExNi40MCAxNi44MSAxNy4zOSAxNy4xMFExOC4zOSAxNy40MCAxOC45OSAxNy43OFExOS42MCAxOC4xNiAxOS44OCAxOC42NVEyMC4xNiAxOS4xMyAyMC4xNiAxOS43OUwyMC4xNiAxOS43OVEyMC4xNiAyMC44NiAxOS4zNCAyMS40OVExOC41MiAyMi4xMiAxNy4xMiAyMi4xMkwxNy4xMiAyMi4xMlExNi4yMCAyMi4xMiAxNS40MiAyMS43N1ExNC42NCAyMS40MyAxNC4yMSAyMC44M1ExMy43OCAyMC4yMiAxMy43OCAxOS40MlpNMjUuMjMgMjJMMjMuNjkgMjJMMjYuOTEgMTMuNDdMMjguMjQgMTMuNDdMMzEuNDcgMjJMMjkuOTIgMjJMMjkuMjIgMjAuMDFMMjUuOTIgMjAuMDFMMjUuMjMgMjJaTTI3LjU3IDE1LjI4TDI2LjMzIDE4LjgyTDI4LjgxIDE4LjgyTDI3LjU3IDE1LjI4Wk0zNi45MCAyMkwzNS40MiAyMkwzNS40MiAxMy40N0wzNy4zNCAxMy40N0wzOS44MSAyMC4wMUw0Mi4yNiAxMy40N0w0NC4xOCAxMy40N0w0NC4xOCAyMkw0Mi43MCAyMkw0Mi43MCAxOS4xOUw0Mi44NSAxNS40M0w0MC4zMyAyMkwzOS4yNyAyMkwzNi43NSAxNS40M0wzNi45MCAxOS4xOUwzNi45MCAyMlpNNTAuNDAgMjJMNDguOTIgMjJMNDguOTIgMTMuNDdMNTIuMTggMTMuNDdRNTMuNjEgMTMuNDcgNTQuNDUgMTQuMjFRNTUuMjkgMTQuOTYgNTUuMjkgMTYuMThMNTUuMjkgMTYuMThRNTUuMjkgMTcuNDQgNTQuNDcgMTguMTNRNTMuNjQgMTguODMgNTIuMTYgMTguODNMNTIuMTYgMTguODNMNTAuNDAgMTguODNMNTAuNDAgMjJaTTUwLjQwIDE0LjY2TDUwLjQwIDE3LjY0TDUyLjE4IDE3LjY0UTUyLjk3IDE3LjY0IDUzLjM5IDE3LjI3UTUzLjgwIDE2LjkwIDUzLjgwIDE2LjE5TDUzLjgwIDE2LjE5UTUzLjgwIDE1LjUwIDUzLjM4IDE1LjA5UTUyLjk2IDE0LjY4IDUyLjIyIDE0LjY2TDUyLjIyIDE0LjY2TDUwLjQwIDE0LjY2Wk02NC45MyAyMkw1OS41NyAyMkw1OS41NyAxMy40N0w2MS4wNiAxMy40N0w2MS4wNiAyMC44Mkw2NC45MyAyMC44Mkw2NC45MyAyMlpNNzQuNjMgMjJMNjkuMDYgMjJMNjkuMDYgMTMuNDdMNzQuNTkgMTMuNDdMNzQuNTkgMTQuNjZMNzAuNTQgMTQuNjZMNzAuNTQgMTcuMDJMNzQuMDQgMTcuMDJMNzQuMDQgMTguMTlMNzAuNTQgMTguMTlMNzAuNTQgMjAuODJMNzQuNjMgMjAuODJMNzQuNjMgMjJaIiBmaWxsPSIjRkZGRkZGIi8+PHBhdGggY2xhc3M9InN2Z19fdGV4dCIgZD0iTTEwMi44MyAxNS40OEwxMDAuMjUgMTUuNDhMMTAwLjI1IDEzLjYwTDEwNy43NyAxMy42MEwxMDcuNzcgMTUuNDhMMTA1LjIwIDE1LjQ4TDEwNS4yMCAyMkwxMDIuODMgMjJMMTAyLjgzIDE1LjQ4Wk0xMTguODkgMjJMMTEyLjE0IDIyTDExMi4xNCAxMy42MEwxMTguNzMgMTMuNjBMMTE4LjczIDE1LjQ0TDExNC41MCAxNS40NEwxMTQuNTAgMTYuODVMMTE4LjIzIDE2Ljg1TDExOC4yMyAxOC42M0wxMTQuNTAgMTguNjNMMTE0LjUwIDIwLjE3TDExOC44OSAyMC4xN0wxMTguODkgMjJaTTEyNS41NCAyMkwxMjIuODMgMjJMMTI1Ljg5IDE3Ljc1TDEyMi45NiAxMy42MEwxMjUuNjQgMTMuNjBMMTI3LjMyIDE2LjAyTDEyOC45NyAxMy42MEwxMzEuNTQgMTMuNjBMMTI4LjYxIDE3LjY2TDEzMS43NCAyMkwxMjkuMDAgMjJMMTI3LjI2IDE5LjQwTDEyNS41NCAyMlpNMTM3LjgxIDE1LjQ4TDEzNS4yMyAxNS40OEwxMzUuMjMgMTMuNjBMMTQyLjc1IDEzLjYwTDE0Mi43NSAxNS40OEwxNDAuMTggMTUuNDhMMTQwLjE4IDIyTDEzNy44MSAyMkwxMzcuODEgMTUuNDhaIiBmaWxsPSIjRkZGRkZGIiB4PSI5OS44NSIvPjwvc3ZnPg==)](https://forthebadge.com)

shields io svg
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="214" height="20" role="img" aria-label="Code: Variables, for and while Loops"><title>Code: Variables, for and while Loops</title><linearGradient id="s" x2="0" y2="100%"><stop offset="0" stop-color="#bbb" stop-opacity=".1"/><stop offset="1" stop-opacity=".1"/></linearGradient><clipPath id="r"><rect width="214" height="20" rx="3" fill="#fff"/></clipPath><g clip-path="url(#r)"><rect width="37" height="20" fill="#007ec6"/><rect x="37" width="177" height="20" fill="#888"   /><rect width="214" height="20" fill="url(#s)"/></g><g fill="#fff" text-anchor="middle" font-family="Verdana,Geneva,DejaVu Sans,sans-serif" text-rendering="geometricPrecision" font-size="110"><text aria-hidden="true" x="195" y="150" fill="#010101" fill-opacity=".3" transform="scale(.1)" textLength="270">Code     </text><text x="195" y="140" transform="scale(.1)" fill="#fff" textLength="270">Code     </text><text aria-hidden="true" x="1245" y="150" fill="#010101" fill-opacity=".3" transform="scale(.1)" textLength="1670">Variables, for and while Loops</text><text x="1245" y="140" transform="scale(.1)" fill="#fff" textLength="1670">Variables, for and while Loops</text></g></svg>
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="178" height="20" role="img" aria-label="Practices: Variable-Debugging">       <title>Practices: Variable-Debugging       </title><linearGradient id="s" x2="0" y2="100%"><stop offset="0" stop-color="#bbb" stop-opacity=".1"/><stop offset="1" stop-opacity=".1"/></linearGradient><clipPath id="r"><rect width="178" height="20" rx="3" fill="#fff"/></clipPath><g clip-path="url(#r)"><rect width="59" height="20" fill="#555"   /><rect x="59" width="119" height="20" fill="#9f9f9f"/><rect width="178" height="20" fill="url(#s)"/></g><g fill="#fff" text-anchor="middle" font-family="Verdana,Geneva,DejaVu Sans,sans-serif" text-rendering="geometricPrecision" font-size="110"><text aria-hidden="true" x="305" y="150" fill="#010101" fill-opacity=".3" transform="scale(.1)" textLength="490">Practices</text><text x="305" y="140" transform="scale(.1)" fill="#fff" textLength="490">Practices</text><text aria-hidden="true" x="1175" y="150" fill="#010101" fill-opacity=".3" transform="scale(.1)" textLength="1090">Variable-Debugging            </text><text x="1175" y="140" transform="scale(.1)" fill="#fff" textLength="1090">Variable-Debugging            </text></g></svg>

html css
<span style="color:white; background-color:#007ec6; padding: 1px 4px; font-size: 70%">
    Code
</span><span style="color:white; background-color:#888; padding: 1px 4px; font-size: 70%">
    Variables, for and while Loops
</span> <span style="color:white; background-color:green; padding: 1px 4px; font-size: 70%">
    Practices
</span><span style="color:white; background-color:#888; padding: 1px 4px; font-size: 70%">
    Variable-Debugging
</span> <span style="color:white; background-color:DarkGoldenRod; padding: 1px 4px; font-size: 70%">
    Principles
</span><span style="color:white; background-color:#888; padding: 1px 4px; font-size: 70%">
    Coding Conventions, DRY-Principle
</span>
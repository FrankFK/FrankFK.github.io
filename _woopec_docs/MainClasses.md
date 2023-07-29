---
layout: page
title: Woopec - Main Classes
date: 2022-05-03
last_modified_at: 2023-07-30 8:30:00 +0000
typora-root-url: ..
---


## Introduction

## Overview of Methods

### Pen class

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
| Screen (Type is Screen)                                      | The screen on which this figure is drawn                     |
|                                                              |                                                              |

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
* [Working with multiple objects](MultipleTurtles.html) contains information on handling multiple `Figure` or `Turtle` objects.

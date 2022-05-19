---
layout: page
title: Frank Kruse (Homepage)
---
# Hallo dies ist die Startseite

Inhalt: Blog, Woopec-Grafik mit Dokumentation 

# Simple graphics with C#
Programming is fun. Programming with graphics is even more fun. C# is a great programming language. For beginners there should be an easy start to graphic programming with C#.  Woopec tries to help - it's free.

The first version contains turtle graphics. Here is a little code example: 
```c#
public static void TurtleMain()
{
    var woopec = new Turtle() { Shape = Shapes.Bird, FillColor = Colors.DarkBlue, PenColor = Colors.LightBlue, Speed = Speeds.Fastest, IsVisible = false };

    woopec.BeginFill();
    do
    {
        woopec.Forward(200);
        woopec.Right(170);

    } while (woopec.Position.AbsoluteValue > 1);
    woopec.EndFill();
    woopec.PenUp();

    woopec.Speed = Speeds.Slowest;
    woopec.IsVisible = true;
    woopec.Heading = 30;
    woopec.Forward(200);
}
```

This is the result:

![Turtle Fill Example](assets/images/filldemo.jpg)

This demo shows more features:

![Animated Demo](assets/images/AnimatedExample1.gif)

You can find more information here
* Features of [turtle graphics](documentation/turtle-class.md)
* [Getting started](documentation/getting-started.md)

**Give it a try and have fun.**

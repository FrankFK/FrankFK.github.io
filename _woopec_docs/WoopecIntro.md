---
layout: page
title: Woopec - Introduction to C# Turtle Graphics
date: 2022-04-30
last_modified_at: 2022-07-23 8:30:00 +0000
excerpt_separator: <!--more-->
typora-root-url: ..
---

*Programming is fun. Programming with graphics is even more fun. C# is a great programming language. For beginners there should be an easy start to graphic programming with C#.  Woopec helps with easy to learn Turtle Graphics.*

![Woopec: Drawing the word Woopec with C# Turtle Graphics](/assets/images/WoopecDrawWoopec.png)
<sup>([Link to Animation](/woopec_docs/WoopecAnimationExamples.html#drawwoopec))</sup>

<!--more-->

Where do you start if you want to learn programming?

The first thing you need to do is decide on a programming language. From my point of view, C# is a very good choice:

* C# is relatively new and well designed compared to other programming languages like Java, JavaScript or Python.
* C# is free, open-source and designed to work not only with Windows, but also with Linux or MacOS.
* C# has a large range of functions and is therefore also used for large professional programs.
* C# is used for game programming with Unity.

How do you learn to program with C#? 

From my point of view it's not a good idea to start with Unity right away. It's a bit like trying to drive a truck before you've learned to ride a bike. If you're new to programming, start with something simple. 

The simplest are so-called console programs. But they quickly become a bit boring because you can only output texts with them. Learning to program becomes a little more exciting when you can also draw something on the screen. And that's where Turtle Graphics come in. Turtle graphics have been around for a long time (e.g. for python), and they are so easy to learn that even novice programmers can start with them.

This quote from the documentation of the [pyhton-Turtle-Graphics](https://docs.python.org/3/library/turtle.html#module-turtle) describes the advantages of turtle graphics:

> Turtle graphics is a popular way for introducing programming to kids. It was part of the original Logo programming language developed by Wally Feurzeig, Seymour Papert and Cynthia Solomon in 1967.
> 
> Imagine a robotic turtle starting at (0, 0) in the x-y plane. [...] give it the command turtle.Forward(15), and it moves (on-screen!) 15 pixels in the direction it is facing, drawing a line as it moves. Give it the command turtle.Right(25), and it rotates in-place 25 degrees clockwise.
>
> Turtle can draw intricate shapes using programs that repeat simple moves. By combining together these and similar commands, intricate shapes and pictures can easily be drawn

With Woopec you can program turtle graphics with C#. Here you can see a small sample program:

```c#
public static void TurtleMain()
{
    var turtle = Turtle.Seymour();

    turtle.Right(45);
    turtle.Forward(50);
    turtle.Left(90);
    turtle.Forward(100);
    turtle.Right(45);
    turtle.Forward(20);
}
```

This program produces the following result:

![Woopec C# Turtle graphics result of simple example](/assets/images/FirstSample.png)

Woopec is free, you only have to install Visual Studio, which is also free, and download the Woopec package. [Getting started](GettingStarted.html) describes this in more detail.

The next program is a bit bigger: 

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

![Woopec C# turtle graphics Filling Example](/assets/images/filldemo.jpg)

You can also draw more complicated things. 

In the example below, a spirograph curve was first drawn using C# turtle commands. Then many turtles were created that have the shape of this spirograph curve. And finally, these were drawn on the screen with different rainbow colors. 

![Woopec C# turtle graphics with transparent spirograph curves](/assets/images/WoopecSpiroDemo2.png)

<sup>([Link to Animation](/woopec_docs/WoopecAnimationExamples.html#spirodemo2))</sup>

You can create multiple objects that move simultaneously on the screen. You can also coordinate the movements of objects. The example at the top of this page was created this way. You can find the animated version of this example [here](/woopec_docs/WoopecAnimationExamples.html#drawwoopec).

There are also commands to ask the user for input. 

And can use Woopec without animations to draw things quickly. The following example calls the C# version of the [pyhton ByteDesignDemo](https://github.com/python/cpython/blob/main/Lib/turtledemo/bytedesign.py) 

```csharp
    public static void TurtleMain()
    {
        Woopec.Examples.TurtleDemoByteDesign.Run();
    }
```

This example generates the following picture in just a few seconds:

![Woopec C# turtle graphics Byte Design Demo](/assets/images/ByteDesignDemo.png)

I'm still developing Woopec and there will be more.

You can find more information here

* [Getting started](GettingStarted.html)
* Features of [turtle graphics](Turtle.html)
* My [blog](/blog.html) posts about turtle graphics

**Give it a try and have fun.**

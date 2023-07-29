---
layout: page
title: Woopec - Working with multiple objects (parallelism)
date: 2022-05-04
last_modified_at: 2023-07-29 8:30:00 +0000
typora-root-url: ..
---

It is possible to work with multiple `Turtle` or `Figure` objects in a program. The following example creates two turtles, cynthia and wally. Both turtles will move at the same time.  

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

The default rule is:

> Normally the objects behave like in this example. All objects move independently of each other. 

But sometimes you want that objects to move sequentially.  In this example at first cynthia will turn left and move forward, and then wally will turn right and move forward:

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

The rule for this is: 

> If an object is created (wally in this example) the moves of this object (wally.Right) only start when all previous movements have ended. 

The example below works with both options:

![Woopec C# Turtle Graphics Animation Demo](/assets/images/WoopecAnimation.gif)

* At first the green object (`seymour1`) is created and draws a "W". Then this object is hidden.
* Then five bird-shaped objects are created: woopec1, woopec2, ..., woopec5
* The five woopecs draw the two "o"s, the "p", "e" and "c".
* After that a *new* green object (`seymour2`) is created (at the same position as the first green object) and this object moves right and draws the stars.
* Parallel to the movement of seymour2, the five woopecs turn around a little bit and move forward to the right.

The code for this roughly looks like this:

```c#
var seymour1 = Turtle.Seymour();
DrawW(seymour1);
seymour1.HideTurtle();

var woopecO1 = new Turtle();
// ...
var woopec5 = new Turtle();

DrawO(woopec1);
// ...
DrawC(woopec5);

var seymour2 = Turtle.Seymour() {Position = seymour1.Position};
seymour2.Forward(160);
DrawStar(seymour2);

woopec1.Right(360); 
// ...
woopec5.Right(360);
```

Actually you want seymour1 to wait for the word "Woopec" to finish. The code above only manages this with a trick: It hides seymour1 and creates a new object seymour2 when the word is finished. The **`WaitForCompletedMovementOf`** command is intended for such cases. The following example uses the command to achieve the desired result

```c#
var seymour1 = Turtle.Seymour();
DrawW(seymour1);

var woopec1 = new Turtle();
// ...
var woopec5 = new Turtle();

DrawO(woopec1);
// ...
DrawC(woopec5);

seymour1.WaitForCompletedMovementOf(woopec5);
seymour1.Forward(160);
DrawStar(seymour1);

woopec1.WaitForCompletedMovementOf(seymour1);
// ...
woopec5.WaitForCompletedMovementOf(seymour1);

woopec1.Right(360); 
// ...
woopec5.Right(360);

// ...
```

First, the command is used to make seymour1 wait with the Forward(160) movement until woopec5 has finished drawing the letter. Second, the command is used for each woopec so that it does the Right(360) rotation only after seymour1 is finished with the DrawStar command.

Remark: An object can only wait for the completed movement of *one* other object. In the above example `seymour1` waits until the movement of `woopec5` is finished. If you call `WaitForCompletedMovementOf(t)` with different objects `t` only the last one counts. The following example will not work as you might expected:

```c#
seymour1.WaitForCompletedMovementOf(woopec1);
seymour1.WaitForCompletedMovementOf(woopec2);
seymour1.WaitForCompletedMovementOf(woopec3);
seymour1.WaitForCompletedMovementOf(woopec4);
seymour1.WaitForCompletedMovementOf(woopec5);
seymour1.Forward(160);
```

Here `seymour1` will wait until `woopec5` has finished its movement. Regardless of wether the other woopecs have finished their movements. Therefore, the first four statements are useless.

So the rule for `WaitForCompletedMovement` is:

> Calling `object1.WaitForCompletedMovementOf(object2)` ensures that the subsequent movement of `object1` is not executed until the previous movement of `object2` has finished.
>
> If you call `WaitForCompletedMovementOf(t)` with different objects `t` only the last one counts.




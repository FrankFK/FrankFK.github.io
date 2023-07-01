---
layout: page
title: Woopec - Helper Classes
date: 2030-08-20
last_modified_at: 2022-08-20 8:30:00 +0000
typora-root-url: ..
---


## Introduction

Genauer gesagt sind das Value Objects (siehe [ValueObject (martinfowler.com)](https://martinfowler.com/bliki/ValueObject.html)). Dies ist eine Lernseite für Programmiereinsteiger. Da kann ich nicht viel mit Value Objects kommen. Allerdings haben sie auch Eigenschaften, die für den User relevant sind: Zwei Objekte sind gleich, wenn ihre Werte gleich sind. Und sie sind immutable, d.h. Werte können nicht geändert werden.

### Color class

Am einfachsten ist es, eine der vordefinierte Farben zu verwenden. Beispielsweise

```c#
turtle.Color = Colors.Green;
```

Eine Farbe wird basierend auf dem [RGB color model - Wikipedia](https://en.wikipedia.org/wiki/RGB_color_model) durch ihre rot, grün und blau Werte festgelegt. Wenn man eine Farbe anhand ihrer rot grün und  blau Werte erzeugen möchte, geht das so:

```c#
turtle.Color = new Color(redValue, greenValue, blueValue);
```

Die Werte für `redValue`, `greenValue` und `blueValue` müssen zwischen 0 und 255 liegen.

Manchmal möchte man, dass ein Shape durchscheinend ist, so dass das, was hinter einem  Shape liegt, weiterhin zu sehen ist. In diesem Fall kann man eine transparente Farbe erzeugen. Das kann so gemacht werden:

```c#
turtle.Color = Colors.Green.Transparent(0.5);
```

In diesem Beispiel wird ein halb durchscheinendes grün erzeugt. Der Wert für die Transparenz wird *Alpha-Channel* genannt, sein Wert kann zwischen 0.0 (fully opaque) und 1.0 (fully transparent) liegen. Eine beliebige Farbe kann wie folgt erzeugt werden:

```c#
turtle.Color = new Color(redValue, greenValue, blueValue, alphaChannelValue);
```

Also eigentlich ganz einfach. Man kann jede gewünschte Farbe über die richtigen drei Werte für rot, grün und blau. Dann mal eine kurze Frage: Welche r, g, b Werte muss man angeben, wenn man die Farbe gelb haben möchte? Man muss r = 255 und g = 255 angeben - das ist weder plausibel noch einfach. In Wirklichkeit ist Farbwahrnehmung sehr komplex und r, g, b Werte sind nicht immer das beste Modell. Alternativ können Farben auch über das [HSL and HSV - Wikipedia](https://en.wikipedia.org/wiki/HSL_and_HSV) angegeben werden. Auch hier gibt man drei Werte an:

* Hue: Angle on the color circle. Die Werte von 0 bis 240 stehen für die Regenbogenfarben: Von 0 red über 120 green bis zu 240 blue. Die Werte zwischen 240 und 360 stehen für die Farben auf der sogenannten purple line.
* Saturation. 0.0 neutral gray, 0.5 little saturation, 1.0 pure color.
* Value. 0.0 no brightness (black), 1.0 full brighntess

Im folgenden Beispiel sieht man auf dem äußeren Kreis alle Farben mit maximaler Saturation und Value. Im Osten (Hue = 0) liegt rot, links dem Kreis folgend kommen die Regenbogenfarben bis hin zu blau (Hue = 240), danach die Farben der Purpurlinie. Das Farbquadrat in der Mitte zeigt die Farbe rot für unterschiedliche Werte von Saturation und Value an.

<Hier Bild>

Wenn man das mal ausprobieren möchte... Seite, die ich auf dem Schreibtisch liegen habe: [Color Home (lukas-stratmann.com)](https://color.lukas-stratmann.com/)

### Speed class

Am einfachsten ist es, eine vordefinierte Speed zu verwenden:

| **Speed**      | **Description**                                            |
| -------------- | ---------------------------------------------------------- |
| Speeds.Slowest | 100 pixels in one second. Full rotation in 2.3 seconds.    |
| Speeds.Slow    |                                                            |
| Speeds.Normal  |                                                            |
| Speeds.Fast    | 100 pixels in 0.04 seconds. Full rotation in 0.23 seconds. |
| Speeds.Fastest | Fastest speed, no animation                                |

Man kann Speed auch über einen beliebigen double Wert angeben. Der Wert 1 entspricht Speeds.Slowest, der Wert 10 entspricht Speeds.Fast, es können aber auch höhere Werte verwendet werden. 
Es gibt auch noch ein paar Hilfsmethoden:

| Method  | Description  |
| ------- | ------------ |
| MillisecondsForMovement(Vec2D fromPoint, Vec2D toPoint) | Gibt für die aktuelle Speed an, wie viele Millisekunden für die Bewegung von einem zu einem anderen Punkt benötigt werden. |
| MillisecondsForRotation(double oldHeading, double newHeading) | Gibt für die aktuelle Speed an, wie viele Millisekunden für eine Rotation von einem zu einem anderen Winkel benötigt werden. |


### Vec2D class

A two-dimensional vector class.

Beispiele, wie man Vektoren und Listen von Vektoren anlegt:

```c#
// Create a vector with new:
var v = new Vec2D(3, 4);
// A different way to create a vector:
Vec2D v = (3, 4);
// Create a list of vectors:
var list = new List<Vec2D> { (1, 2), (3, 5) };
// A different way to create a list of vectors (e.g. useful, if you want to pass it to a method)
AMethod(new() { (1, 2), (3, 5) });
```



| Method  | Description  |
| ------- | ------------ |
| v1 + v2 | Vector addition |
| v1 - v2 | Vector substraction |
| r * v | Multiply vector v with a number r |
| AbsoluteValue() | The absolute value of the vector (the "length" of the vector) |
| Rotate(double angle) | Rotate the vector (angle is measured in degrees) |
| HeadingTo(Vec2D position) | Calculate the angle from the end-point of the vector to the given `position`. This angle is given in degrees, such that it can be used as a `Heading` of a `Turtle` |
| IsApproximatelyEqualTo(Vec2D vector, double precision) | Return true if a vector is approximately equal to another vector |
|  |  |

### 


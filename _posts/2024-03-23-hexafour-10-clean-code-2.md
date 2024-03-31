---
layout: posts
title: Cleaner Code with YAGNI, KISS, SRP, SoC and IOSP, an Example (h4-10)
tags: LearnToCode C# HexaFour CodeQuality 
image: TBD
excerpt_separator: <!--more-->
typora-root-url: ..
---

<img src="/assets/images/hexafour/SchrankWoopec1Scaled.png" alt="A wooden board painted with colors from Woopec example. Copyright by Frank Kruse" style="zoom:78%;" />

From the very beginning, you can write code that is easy to understand and easy to extent. Even beginners can try to follow some principles right from the start: You aren't gonna need it (YAGNI), keep it simple, stupid (KISS), separation of concerns (SoC), single responsibility (SRP) and integration operation segregation (IOSP).

<!--more-->

I'll start here again with a quote from the book "Clean Code.  A Handbook of Agile Software Craftsmanship" by [Robert C. Martin][RobertCMartin]:

> Your code must be readable by other programmers. This is not simply a matter of writing nice comments. Rather, it requires that you craft the code in such a way that it reveals your intent.

This "other programmer" can also be yourself if you try to understand your own program that you wrote some time ago.

I have already described two tips for readable code in an [earlier article][hexafour-5]: Follow coding conventions and don't repeat your self (DRY). Now there are more to follow. I will explain this using the small program from the [previous article][hexafour-09].

### YAGNI

In this series of articles, we are developing a game. The game is far from finished. We are currently developing the code for drawing the game board. In the last article, we wrote a method for coloring the shapes on the game board. This looks nice, but we don't need it at the moment. The main thing is to have a functioning game in the first place. The colors are nice, maybe we could use them in the future, but right now it's just holding us up.  That's why we're leaving it out. We're applying the YAGNI principle, YAGNI stands for **"You aren't gonna need it."** According to [Wikipedia]([You aren't gonna need it - Wikipedia](https://en.wikipedia.org/wiki/You_aren't_gonna_need_it)), Ron Jeffries once described it like this:

> Always implement things when you actually need them, never when you just foresee that you need them.

### KISS

Another principle is the KISS principle, which stands for "**Keep it simple, stupid**" or "**Keep it simple and stupid**". This principle demands that you keep the code you write as simple as possible. The code from the last article actually follows this principle quite well, it is fairly straightforward and uncomplicated. 

In the following steps, we will first change the code so that it still does exactly the same thing, but is structured differently. This makes it more complicated and less "simple and stupid". So we are moving away a little from the KISS principle here. This is only OK here because our program is still in its infancy and we need a different structure for the subsequent extensions.

### SoC

The abbreviation SoC stands for the **separation of concerns** principle. [Wikipedia](https://en.wikipedia.org/wiki/Separation_of_concerns) describes this principle as follows:

> In computer science *separation of concerns* is a design principle for separating a computer program into distinct sections. Each section addresses a separate *concern*, a set of information that affects the code of a computer program.

In order to understand what is meant by this, it is necessary to clarify what is meant by the term "concern". In my view, a "concern" is something that is more fundamental. As an example, I take this picture from the article about the HexaFour game concept:

<img src="/assets/images/hexafour/ConceptCoorSystem.png" alt="A picture with the board in the background. In the foreground, a green grid with integers at the edge. At the top, a row of hexagons whose positions are marked with slot numbers." style="zoom:60%;" />

Two concerns of the game are presented here: 

* On the one hand, the game has an *interface* that the user can see. In this world, there are blue, hexagonal tiles and a game board with gray, rhomboid borders. And it is important that the blue pieces are exactly the right size to fit between the gray rhombuses.
* On the other hand, there is the *logic* of the game. The shape, color and size of the tiles are irrelevant here. The game board can be reduced to a grid of columns and rows. And the game pieces can move from one grid point to another according to certain rules.

These are two different concerns, user interface and logic, which we should separate as well as possible according to the SoC principle.

### SRP

SRP stands for the **single responsibility principle**. [Wikipedia](https://en.wikipedia.org/wiki/Single_responsibility_principle) explains this principle with four different descriptions:

> "A module should be responsible to one, and only one, actor" [...]
> "A class should have only one reason to change" [...]
> "Gather together the things that change for the same reasons. Separate those things that change for different reasons." [...]

There is also an article [The Single Responsibility Principle](https://blog.cleancoder.com/uncle-bob/2014/05/08/SingleReponsibilityPrinciple.html), in which Robert C. Martin, the originator of the term, describes what he means by it. In this article, Robert C. Martin speaks not only of "responsibilities", but also of "concerns". And the example he uses to explain the single responsibility principle could just as well be an explanation of the separation of concerns principle.

So what is the difference between the "official" definitions of SoC and SRP? I don't know. In my interpretation, SoC is more about the bigger picture And SRP is more about aspects at the next level of detail. And for SRP, this explanation helps me the most: 

> Separate those things that change for different reasons.

### IOSP

SoC and SRP are about *separating* different things, concerns on the one hand and responsibilities on the other. How far can you take such a separation? The abbreviation IOSP stands for **integration operation segregation principle**. According to this principle, code consists of logic and integration, and these two things should also be separated as well as possible. If you do this consistently, there are two types of methods:

* *Operation* methods. This type of method should only contain logic, but not call any other methods of your code.
* *Integration* methods. This type of method should not contain any logic and only call other methods of your code.

A [definition](https://ralfwestphal.substack.com/p/integration-operation-segregation) by Ralf Westphal sums it up like this:

> Functions shall either only contain logic or they shall only call other functions.

### There are many ways

Before we try to structure the first part of our HexaFour game according to the above principles, I would like to point out one thing: We will never manage to strictly follow all principles at all times. These are all just guidelines to help us write good code. Sometimes some do not fit the current problem, sometimes they even contradict each other. For example, if you strictly follow the single responsibility principle, the code can become more complicated and move away from the KISS principle.

To a certain extent, what you consider to be clean code also depends on your own preferences and strengths. On the web page [Design-Types](http://design-types.net/design_types.html), for example, sixteen different types of developers are described. You can answer a questionnaire there and it will determine which design type you are. My design type, for example, is "The Engineer". As this type, I don't like the KISS principle as much as other principles. There are other types, for example "The Craftsman", who like the KISS principle much more. There is no right and wrong. You have to find your own way. It's also worth paying attention to the principles you don't like. Because that's where you might have a blind spot.



*** Ab hier Halde ***



### Aufteilung in Methoden

Im nächsten Schritt wollen wir den Programmablauf in Methoden aufteilen. Jede Methode soll sich dabei nur um einen Belang kümmern (Separation of concerns). Wir müssen darum aufpassen, dass wie beispielsweise nicht in einer Methode das Spieler-Koordinatensystem und das Bildschirm-Koordinatensystem vermischen.

Los geht's. 

Das gesamte Spiel besteht schon mal aus drei Belangen: Initialisierung, Spielen und Beenden. Dafür ruft `WoopecMain` drei verschiedene Methoden auf:

```csharp
public static void WoopecMain()
{
    var tokenRadius = 20.0;
    var maxRow = 4;
    var maxCol = 10;

    InitializeTheGame(tokenRadius, maxRow, maxCol);
    PlayTheGame(tokenRadius, maxRow, maxCol);
    FinishTheGame();
}
```

Noch ein kurzer Hinweis dazu: Wir müssen für das Spiel ein paar Werte festlegen: Wie groß soll ein Token auf dem Bildschirm sein (`tokenRadius`) und welchen Index hat die letzte Zeile bzw. Spalte (`maxRow` bzw. `maxCol`). Diese Werte legen wir hier einmal in `WoopecMain` fest und geben sie dann als Parameter an die Methoden weiter. Das werden wir später noch anders und besser lösen. Im Moment ist es so aber am einfachsten zu verstehen.

Als nächstes kümmern wir uns um die Spiel-Initialisierung. Auch hierbei gibt es unterschiedliche Belange, deshalb werden dafür auch wieder unterschiedliche Methoden aufgerufen:

```c#
private static void InitializeTheGame(double tokenRadius, int maxRow, int maxCol)
{
    RegisterTokenShape(tokenRadius);
    RegisterRhombusShape(tokenRadius);
    RegisterLeftBorderShape(tokenRadius);
    RegisterRightBorderShape(tokenRadius);

    List<BoardElement> boardElements = CreateBoardElements(maxRow, maxCol);
    boardElements.AddRange(CreateBorderBoardElements(maxRow, maxCol));

    foreach (var boardElement in boardElements)
        DrawBoardElement(boardElement, tokenRadius);
}
```

Die ersten vier Methoden erzeugen die unterschiedlichen Shapes, die für das Spielbrett benötigt werden. Den Code dafür haben wir im letzten Artikel schon entworfen. Hier exemplarisch die `RegisterRhombusShape` Methode:

```c#
private static void RegisterRhombusShape(double tokenRadius)
{
    var pen = new Pen();

    var edgeLength = 2 * tokenRadius;

    pen.Move(edgeLength / 2);

    pen.BeginPoly();

    pen.Rotate(120);
    pen.Move(edgeLength);
    pen.Rotate(120);
    pen.Move(edgeLength);
    pen.Rotate(60);
    pen.Move(edgeLength);

    var polygon = pen.EndPoly();

    Shapes.Add("rhombus", polygon);
}
```

Die anderen `Register`-Methoden sehen ähnlich aus. Darum schreibe ich sie hier nicht auf. 

Die nächsten zwei Zeilen von `InitializeTheGame` bewegen sich im Spieler-Koordinatensystem:

```csharp
    List<BoardElement> boardElements = CreateBoardElements(maxRow, maxCol);
    boardElements.AddRange(CreateBorderBoardElements(maxRow, maxCol));
```

Die aufgerufene Methode  `CreateBoardElements` erzeugt die Hauptobjekte des Spielbretts:

```c#
private static List<BoardElement> CreateBoardElements(int maxRow, int maxCol)
{
    List<BoardElement> boardElements = new();

    var createAnchor = true;
    for (var row = 0; row <= maxRow; row++)
    {
        for (var col = 0; col <= maxCol; col++)
        {
            if (createAnchor)
                boardElements.Add(new BoardElement("token", Colors.LightBlue, Colors.White, row, col));
            else
                boardElements.Add(new BoardElement("rhombus", Colors.LightGray, Colors.LightGray, row, col));

            createAnchor = !createAnchor;
        }
    }

    return boardElements;
}
```

Wir machen das hier aber etwas anders als im letzten Artikel:

* Im letzten Artikel wurde direkt Woopec-Figures erzeugt und auf den Bildschirm gezeichnet. Das machen wir hier nicht. Wir erzeugen ein `BoardElement`. Dieses Board-Element lebt nicht in der Bildschirm-Welt, sondern in der Spielerwelt. Es merkt sich den Namen des zu zeichnenden Shapes ("token" oder "rhombus"), seine Farben und seine Zeilen- und Spalten-Koordinaten. 
* Gezeichnet werden diese Board-Elemente hier noch nicht, sie werden lediglich in einer Liste mit Namen `boardElements` gespeichert.
* Wie kommt die aufrufende Methode `InitializeTheGame` an diese `boardElements`-Liste? Unsere Methode `CreateBoardElements` kann diese Liste zurückgeben. Das macht sie in der letzten Zeile über den Befehl `return boardElements;`.  Damit die aufrufende Methode weiß, welche Art von Daten unsere Methode zurückgibt, wird der Typ dieser Daten vor dem Namen der Methode angegeben:
      `List<BoardElement> CreateBoardElements(int maxRow, int maxCol)`

Wir haben hier das erste Beispiel einer Methode, die nicht nur Parameter hat, sondern auch Werte zurückgibt. Die zweite Methode `CreateBorderBoardElements` funktioniert ähnlich und erzeugt eine Liste der Ränder des Spielbretts. Über die `AddRange` Methode werden beide Listen zu einer großen Liste zusammengefasst.

Der letzte Teil in `InitializeTheGame` gibt diese alle Board-Elemente aus der Liste auf dem Bildschirm aus:

```c#
    foreach (var boardElement in boardElements)
        DrawBoardElement(boardElement, tokenRadius);
```

Die Methode `DrawBoardElement` kümmert sich um diese Bildschirm-Ausgabe:

```c#
private static void DrawBoardElement(BoardElement boardElement, double tokenRadius)
{
    var figure = new Figure()
    {
        IsVisible = false,
        Shape = Shapes.Get(boardElement.Shape),
        Speed = Speeds.Fastest,
        OutlineColor = boardElement.OutlineColor,
        FillColor = boardElement.FillColor,
        Heading = 90
    };

    var boardLowerLeftX = -300;
    var boardLowerLeftY = -100;
    var rhombusWidth = 2 * tokenRadius;
    var rhombusHeight = Math.Sqrt(3) * 2 * tokenRadius;

    figure.Position = (
        boardLowerLeftX + boardElement.Column * rhombusWidth,
        boardLowerLeftY + boardElement.Row * rhombusHeight
    );

    figure.IsVisible = true;
}
```

Damit haben wir die Belange Spieler-Koordinatensystem und Bildschirm-Koordinatensystem sauber getrennt. 



### Noch ein Clean Code Prinzip: IOSP

Damit haben wir alle Methoden zusammen, die für die  Spiel-Initialisierung benötigt werden. Zusammengefasst haben wir jetzt diese Methoden:

```
WoopecMain
	- InitializeTheGame
        - RegisterTokenShape
        - RegisterRhombusShape
        - RegisterLeftBorderShape
        - RegisterRightBorderShape
        - CreateBoardElements
        - CreateBorderBoardElements
        - DrawBoardElement
    - PlayTheGame
    - FinishTheGame
```

Die obige Zusammenfassung der Methoden ist so eingerückt, wie sich die Methoden aufrufen. Die Methoden, die am weitesten eingerückt sind sind Operationen, sie rufen keine anderen Methoden auf. Die Methoden, die nicht so weit eingerückt sind, sind Integrationen, sie enthalten quasi keine Logik und rufen nur die anderen Methoden auf.

Das Befolgen von IOSP hat für die Spiel-Initialisierung ganz gut funktioniert. Das ist aber nicht immer so einfach. Bei `PlayTheGame` wird schwierig. Für heute haben wir aber erstmal genug gemacht.

### Kurze Zusammenfassung TBD
* Zusammenfassung *zentraler Begriff*  usw.
* ...

### Übung
Was kann der Leser ausprobieren?

[hexafour-01]: {% post_url 2023-07-01-hexafour-01-overview %}
[hexafour-02]: {% post_url 2023-07-02-hexafour-02-first-program %}
[hexafour-03]: {% post_url 2023-07-14-hexafour-03-draw-a-hexagon %}
[hexafour-04a]: {% post_url 2023-07-23-hexafour-04a-compiler-errors%}
[hexafour-04b]: {% post_url 2023-07-24-hexafour-04b-debugging%}
[hexafour-05]: {% post_url 2023-08-13-hexafour-05-variables-loops-dry %}
[hexafour-06]: {% post_url 2023-09-03-hexafour-06-types-conditions %}
[hexafour-07]: {% post_url 2023-10-29-hexafour-07-board-concept %}
[hexafour-08]: {% post_url 2023-11-19-hexafour-08-using-classes %}
[hexafour-09]: {% post_url 2024-03-09-hexafour-09-define-methods %}


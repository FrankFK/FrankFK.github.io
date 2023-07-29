---
layout: posts
title: Variablen, Schleifen, Coding-Conventions und das DRY-Prinzip (h4-05)
tags: LearnToCode C# HexaFour
excerpt_separator: <!--more-->
typora-root-url: ..
---



![An image created with the Pen class of the Woopec library. On the left, a hexagonal figure drawn with green lines. On the right, a pentagonal figure drawn with blue lines.](/assets/images/hexafour/HexaFour05Title.png)

Mit Variablen und Schleifen können wir unser Programm flexibler gestalten und vermeiden, dass wir denselben Code mehrfach schreiben. Das hilft uns dem DRY-Prinzip zu folgen

<!--more-->

### Auf Wiedersehen Turtle

Bis hierhin haben wir mit der Woopec-Klasse Turtle gearbeitet. Das hat den Einstieg etwas leichter gemacht, weil wir immer sehen konnten, in welche Richtung weiter gezeichnet wird. Eigentlich wollen wir aber hier nur Linien zeichnen und keine Turtles. Darum steigen wir hier auf die Klasse `Pen` um. Wir ändern den Code aus dem [vorletzten Artikel][hexafour-03] so:

```csharp
using Woopec.Core;

internal class Program
{
    public static void WoopecMain()
    {
        var pen = Pen.CreateExample();
        pen.IsDown = true;

        pen.Rotate(60);
        pen.Move(100);
        pen.Rotate(60);
        pen.Move(100);
        pen.Rotate(60);
        pen.Move(100);
        pen.Rotate(60);
        pen.Move(100);
        pen.Rotate(60);
        pen.Move(100);
    }
}
```

Der `Pen` folgt demselben Konzept wie die `Turtle`: 

* Er zeichnet immer in eine bestimmte Richtung. Für das Ändern der Richtung gibt es nur noch eine Methode **`Rotate`**. Ein Wert größer 0 dreht nach links (entspricht also `Turtle.Left`)  und ein Wert kleiner 0 dreht nach rechts (entspricht also `Turtle.Right`).
* Die Methode **`Move`** ändert die Position des Pens. Ein positiver Wert bewegt den Pen nach vorne, ein negativer Wert nach hinten.
* Wenn der Pen während seiner Bewegung zeichnen soll, muss seine Property `IsDown` auf `true` gesetzt sein.
* Alternativ zu `Rotate` und `Move` kann man auch die Pen-Methode `SetPosition` zum Zeichnen nutzen. Wir bleiben aber erstmal bei Rotate und Move



### Variablen

Was müssten wir tun, wenn wir in unserem Programm die Kanten statt 100 Pixeln nur 50 Pixel lang sein sollen?

Wir müssten an sechs Stellen die `100` durch eine `50` ersetzen. Das ist ziemlich umständlich. Viel einfacher ist es, wenn wir eine **C# Variable** definieren und benutzen. Eine Variable können wir so definieren:

```csharp
    var edgeLength = 50;
```

Mit dem **`var` Kennwort** wird dem C# Compiler mitgeteilt, dass hier eine Variable definiert werden soll. 

Der Text `edgeLength` ist der **Variablen-Name**, hier können wir uns einen beliebigen Namen ausdenken. Der Name darf aber nur aus Buchstaben, Zahlen und ein paar Sonderzeichen (z. B. einem `_`) bestehen. Leerzeichen sind nicht erlaubt. Hinter dem Gleichheitszeichen folgt der Wert der Variable, hier also `50`. Diese Variable kann jetzt überall verwendet werden, wo die Kantenlänge benötigt wird. Der betreffende Teil des Programm sieht dann so aus:

```csharp
    var edgeLength = 50;

    pen.Right(60);
    pen.Forward(edgeLength);
    pen.Right(60);
    pen.Forward(edgeLength);
    pen.Right(60);
    // ...
```


### Coding-Conventions (Clean Code)

Im Prinzip kann man eine Variable nennen wie man möchte. Das Programmieren ist aber einfacher, wenn man sich an ein paar Regeln, sogenannte **Coding Conventions** hält. Für die Namen von Variablen gibt es diese Konventionen:

* Man sollte anhand des Namens erkennen, worum es sich handelt. Darum ist der Name `edgeLength` besser ein Name, der zum Beispiel nur aus einem Buchstaben besteht (`e`).
* Variablen-Namen beginnen mit einem Kleinbuchstaben. Dadurch weiß man dort wo die Variable verwendet wird, sofort dass es sich bei dem Namen um eine Variable handelt.
* Wenn der Name aus mehreren Worten besteht, fangen die anderen Worte jeweils mit einem Großbuchstaben an, damit man den Anfang eines neuen Wortes erkennt. Diese Schreibweise nennt man auch *camelCase*.

Weitere Informationen zu Naming-Conventions findet man zum Beispiel bei [Wikipedia][WikiNamingConventions] oder bei [Microsoft][MsNamingConventions].

### The DRY-Principle: Don't Repeat Yourself (Clean Code)

In unserem Sechseck-Programm werden dieselben Zeilen sechsmal wiederholt:

```csharp
    pen.Right(60);
    pen.Forward(edgeLength);
```

Das ist aus mehreren Gründen schlecht: Wenn wir etwas ändern wollen, beispielsweise die `100` durch `edgeLength` ersetzen, müssen wir das an mehreren Stellen ändern. Das ist überflüssige Arbeit. Und wenn wir beim Ändern eine Stelle vergessen, beispielsweise wenn wir in der letzten Zeile die `100` nicht durch die neue Variable ersetzen, funktioniert unser Programm nicht mehr so wie es soll.

Wir sollten daher unser Programm so ändern, dass wir uns im Code nicht mehr wiederholen müssen. 

Dafür benötigen wir...

### Schleifen

Für die mehrfache Ausführung von gleichen Dingen gibt es in C# Schleifen. Wir können unser Programm beispielsweise so ändern, dass es eine **while-Loop** verwendet:

```csharp
    var edgeCounter = 0;
    while (edgeCounter < 6)
    {
        pen.Rotate(60);
        pen.Move(edgeLength);
        edgeCounter = edgeCounter + 1;
    }
```

Hier haben wir mehreren C# Konstrukte benutzt:

* Zuerst wird eine neue Variable `edgeCounter` definiert. Mit dieser Variable zählen wir, wie viele Kanten schon gemalt wurden. 

* Immer, wenn wir eine Kante gemalt haben, erhöhen wir den Wert von `edgeCounter`, indem wir eins hinzuzählen. Das geht so:
        `edgeCounter = edgeCounter + 1;` 

* Das Ganze müssen wir solange wiederholen, wie wir noch weniger als sechs Kanten gemalt haben. Das geben wir hierdurch an:
        `while (edgeCounter < 6)`
    Das Zeichen `<` steht für `ist kleiner als`. Durch `edgeCounter < 6` wird also geprüft, ob der Wert der Variable `edgeCounter` kleiner als `6` ist.
* Dahinter kommt eine geschweifte Klammer auf `{` und weiter unten eine geschweifte Klammer zu `}`.  Diese beiden Klammern definieren eine sogenannten **Code-Block**. Alle Code-Zeilen, die zwischen diesen beiden Klammern stehen, gehören zu diesem Code-Block und werden mehrfach ausgeführt.

* Damit man erkennen kann, wo der Code-Block anfängt und wo er aufhört, werden die Klammern in eigene Zeilen geschrieben und der Inhalt des Code-Blocks wird um vier Zeichen (man kann auch die Tab-Taste drücken) eingerückt. Diese **Code-Einrückung** machen wir immer genau so, damit wir Code-Blöcke überall gut erkennen. (Auch das sind Coding Conventions)

Schleifen kann man noch etwas kompakter als **for-Loop** schreiben. Das sieht dann so aus:

```csharp
    for (var edgeCounter = 0; edgeCounter < 6;  edgeCounter++)
    {
        pen.Rotate(60);
        pen.Move(edgeLength);
    }
```

In der `for`-Loop kommen dieselben Elemente vor wie oben in der while-Loop, sie stehen nur in einer einzigen Zeile. Zuerst kommt die Definition der `edgeCounter`-Variable, dann ein Semikolon, danach die Bedingung wie oft die Schleife durchgeführt werden soll, dann wieder ein Semikolon, und zum Schluss das Statement, um die Variable um eins zu erhöhen. Weil es oft vorkommt, dass man eine Variable um eins erhöhen möchte, gibt es dafür auch noch ein spezielles Statement. Man kann an Stelle von `edgeCounter = edgeCounter + 1`  auch einfach `edgeCounter++` schreiben.

Es gibt auch noch andere Formen von Schleifen. Auch bei der Definition von Bedingungen gibt es viele weitere Möglichkeiten. Ich erkläre das hier nicht näher, weil es dazu eine gute Erklärungsseite von Microsoft gibt. Du solltest dir die Beispiele auf dieser Seite am besten alle ansehen und ausprobieren:   [C# `if` statements and loops - conditional logic tutorial][MSDocsLoops].

### DRY-Principle, Teil 2: Code noch weiter vereinfachen

Der Code ist eigentlich noch nicht DRY genug. Woher kommt die Zahl `60` in `seymour.Rigth(60)`? Diese Zahl hat mit der Anzahl der Kanten zu tun: Weil wir ein gleichmäßig 6-Eck zeichnen wollen, muss sich die Turtle um `360.0 / 6` Grad drehen. Eigentlich wiederholt sich in der `60` also die Anzahl (`6`), die auch in der for-Bedingung (`edgeCounter < 6`) verwendet wird. Das können wir auch noch verbessern: Wir definieren eine Variable `var numberOfEdges = 6`, die die gewünschte Anzahl von Kanten angibt. Damit sieht unser Programm so aus:

```csharp
public static void TurtleMain()
{
    var pen = Pen.CreateExample();
    pen.IsDown = true;

    var edgeLength = 50;
    var numberOfEdges = 6;

    for (var edgeCounter = 0; edgeCounter < numberOfEdges; edgeCounter++)
    {
        pen.Rotate(360.0 / numberOfEdges);
        pen.Move(edgeLength);
    }
}
```

Durch diese Änderungen ist der Code kürzer geworden und es gibt keine Wiederholungen mehr. Man sieht hier auch den entscheidenden Vorteil: Was hätten wir im ursprünglichen Code ändern müssen, wenn wie beispielsweise ein 17-Eck hätten zeichnen wollen? Wir hätten noch viele Statements hinzufügen müssen, und wir hätten die Zahl 60 durch eine andere Zahl ersetzen müssen. Im Code, der dem DRY-Prinzip folgt, müssen wir nur eine einzige Stelle ändern. Wir ändern die Definition von numberOfEdges auf 17:

```csharp
    var numberOfEdges = 17;
```

Diese einzige Änderung sorgt dafür, dass der Code statt eines 6-Ecks ein 17-Eck zeichnet.

An diesem Beispiel sieht man, wie wichtig es ist, beim Programmieren dem DRY-Prinzip zu folgen.

### Debugging von Variablen

Durch die Benutzung von Variablen wird Programm-Code ein Stückchen komplizierter. Dabei können schon mal Fehler passieren. Aber auch hier hilft der Debugger. Wenn man im obigen Code den Cursor auf die Prüfung `edgeCounter < numberOfEdges` stellt, kann man dort einen mit F9 einen Breakpoint anlegen (siehe dazu im [vorherigen Artikel][hexafour-04]). Wenn wir jetzt das Programm im Debugger starten (mit F5), hält es an diesem Breakpoint an. Wir können uns dann im Debugger ansehen, welche Werte die Variablen haben:

![](/assets/images/hexafour/VSBreakpointWithWatchWindow.png)

Unter dem Code zeigt Visual Studio ein Autos-Window an. In diesem Window werden die Werte der Variablen angezeigt, die gerade eine Rolle spielen. Man sieht in diesem Beispiel, dass `edgeCounter` den Wert 0 und `numberOfEdges` den Wert 6 hat. Man kann dann den Code schrittweise (mit F10) oder bis zum nächsten Breakpoint (mit F5) laufen lassen und sieht immer den aktuellen Wert der Variablen.

Der Debugger hat noch viele weitere Features für Variablen. Wenn man beispielsweise den Maus-Cursor über eine Variable im Code bewegt, wird automatisch der Wert angezeigt. Weitere Informationen dazu finden sich in der [Microsoft-Dokumentation][MSDocsInspectVariables]

### Kurze Zusammenfassung

* *Variablen* definieren (`var edgeCounter = 0`), ändern (`edgeCounter = edgeCounter + 1;`), prüfen (`edgeCounter < 6`), verwenden (`Right(360-0 / edgeNumber`).
* *Schleifen* (`for`  oder `while`) benutzen. Es gibt weitere Möglichkeiten, siehe [Microsoft Tutorial][MSDocsLoops]
* *Bedingungen* definieren, z. B. `(edgeCounter < 6)`, Es gibt aber noch viel mehr Möglichkeiten, siehe  [Microsoft Tutorial][MSDocsLoops]
* *Coding Conventions* für Variablen-Namen und für Einrückung im Code benutzen. Siehe dazu auch [Microsoft Naming Conventions][MsNamingConventions]
* Möglichst das *DRY-Prinzip* nutzen.

### Übung

Beispielsweise könntest du folgendes versuchen: Ändere den Code so, dass er statt einer `for`-Schleife wieder eine `while`-Schleife benutzt. Dann ändere den Code so, dass in jedem Schleifendurchlauf die Kantenlänge (`edgeLength`) um eins verringert wird. Und dann ändere die Bedingung für die Schleife so, dass die Schleife erst dann beendet wird, wenn die edgeLength den Wert 1 hat. Was ist das Ergebnis?

[WikiNamingConventions]: https://en.wikipedia.org/wiki/Naming_convention_(programming)
[MsNamingConventions]: https://docs.microsoft.com/en-us/dotnet/csharp/fundamentals/coding-style/coding-conventions
[MSDocsLoops]: https://docs.microsoft.com/en-us/dotnet/csharp/tour-of-csharp/tutorials/branches-and-loops-local
[MSDocsInspectVariables]: https://docs.microsoft.com/en-us/visualstudio/debugger/autos-and-locals-windows?view=vs-2022
[Woopec Docs]: https://frank.woopec.net/woopec_docs/Turtle.html

[hexafour-03]: {% post_url 2023-07-14-hexafour-03-draw-a-hexagon %}

[hexafour-04]: {% post_url 2023-07-23-hexafour-04-debugging %}

[hexafour-overview]: {% post_url 2023-07-01-hexafour-01-overview %}#overview-of-the-posts-in-this-series


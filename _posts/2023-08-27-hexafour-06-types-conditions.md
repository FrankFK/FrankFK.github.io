---
layout: posts
title: TBD (h4-06)
tags: LearnToCode C# HexaFour Woopec.Graphics
excerpt_separator: <!--more-->
typora-root-url: ..
---

Im vorherigen Artikel haben wir unseren Code mithilfe von Variablen und Schleifen so umgeschrieben, dass er einfacher zu verstehen ist. In diesem Artikel wollen wir den Code etwas erweitern: Der User soll angeben können, an welcher Stelle das Hexagon gezeichnet wird. Hierbei lernen wir neue Elemente von C# kennen: Die C# Typen `int`, `double` und `string`. Wir sehen uns an, wie man mit dem `null` Wert umgehen kann, und lernen den Unterschied zwischen `int` und `int?` kennen. Und wir prüfen einen Wert auf `null` und führen abhängig vom Wert mit `if` und `else` unterschiedliche Teile das Programm aus.

### Ein gefülltes Polygon zeichnen

Als Startpunkt nehmen wir den Code aus dem [vorherigen Artikel][hexafour-05] und erweitern in ein kleines bisschen:
```csharp
public static void WoopecMain()
{
    var pen = Pen.CreateExample();
    pen.IsDown = true;

    var edgeLength = 50;
    var numberOfEdges = 6;

    pen.BeginFill();
    for (var edgeCounter = 0; edgeCounter < numberOfEdges; edgeCounter++)
    {
        pen.Rotate(360.0 / numberOfEdges);
        pen.Move(edgeLength);
    }
    pen.EndFill(Colors.Green);
}
```

Der Umriss der zwischen dem Aufruf der Methode `BeginFill` und `EndFill` gezeichnet wurde, wird mit der Farbe `Colors.Green` gefüllt. Auf dem Bildschirm wird so ein grün gefülltes Hexagon angezeigt.

### C# Typen

Im obigen Programm kommen diese drei Variablen vor:

```csharp
    var pen = Pen.CreateExample();
    var edgeLength = 50.0;
    var numberOfEdges = 6;
```

Diese Variablen stehen für ganz unterschiedliche Dinge: 

* `pen` ist ein Objekt der Woopec-Grafik-Bibliothek. Wir können zum Beispiel die Methode `pen.Move(60)` aufrufen. Wir können aber beispielsweise nicht `pen / 2` ausführen.
* `edgeLength` ist eine Kommazahl. Wir können `edgeLength / 2` ausführen, aber zum Beispiel nicht `edgeLength.Move(60)` aufrufen.
* `numberOfEdges` ist eine Zahl ohne Kommastellen. 

Man spricht davon, dass eine Variable eine bestimmten **Typ** hat. *Eine Variable in C# kann ihren Typ nicht ändern. Er bleibt immer derselbe.* C# "weiß" immer ganz genau, welchen Typ eine Variable hat. Das heißt C# weiß, dass `edgeLength` eine Kommazahl ist und man daher nicht  `edgeLength.Right(60)`  aufrufen darf. Wenn du das im Code schreibst, erzeugt C# eine Fehlermeldung und das Programm wird nicht übersetzt.

In den obigen Beispielen erkennt C# beim Übersetzen des Programms automatisch den Typ. Wir können daher ein `var` vor die Variable schreiben. Damit sagen wir C#: "Wenn du selbst herausfinden kannst, welchen Typ die Variable hat, nimm diesen Typ".

Wir können aber genausogut den Typ auch explizit hinschreiben:

```csharp
    Pen pen = Pen.CreateExample();
    double edgeLength = 50.0;
    int numberOfEdges = 6;
```

Solange es glasklar ist, um welchen Typ es sich handelt, können wir bei der einfachen Schreibweise mit `var` bleiben. In allen anderen Fällen sollten wir den Typ besser explizit hinschreiben. Für den C# Compiler wäre es kein Problem, wenn wir `var` schreiben, aber für den Leser des Codes ist es besser, wenn wir ihm durch die Typangabe explizit sagen, um welchen Typ es sich handelt. Wir werden gleich ein Beispiel dafür sehen.

### Vom Benutzer einen Text abfragen

Angenommen wir wollen den Benutzer fragen, welche Farbe unser Hexagon haben soll. Dann können wir dafür die `TextInput` Methode nutzen und das Ergebnis einer Variablen zuweisen:

```csharp
    var color = pen.Screen.TextInput("Choose color", "Enter a color-name (for instance: red)");
```

Durch den Aufruf der `TextInput`-Methode wird ein kleines Dialog-Fenster angezeigt, in das der Anwender einen Text eingeben kann:

![image-20220616123626255](/assets/images/hexafour/WoopecTextInput.png)

Das Ergebnis der Eingabe wird an die Variable `color` zugewiesen. Was für einen Typ hat die Variable `color`? Ist das wirklich eine Farbe? Der User könnte ja auch etwas ganz anderes eingegeben haben. Hier ist es besser, wenn wir den Typ explizit hinschreiben. Die Methode `TextInput` liefert einen C# **string** zurück und diesen Typ schreiben wir auch vor den Namen unserer Variablen:

```csharp
    string colorName = pen.Screen.TextInput("Choose color", "Enter a color-name (for instance: red)");
```

### Der C# string Typ

In Programmen hat man es oft mit Texten zu tun. Darum ist der Typ `string` sehr wichtig. Du solltest dir am besten jetzt ein paar Dinge dazu im Netz ansehen. Beispielsweise das Video [The Basics of Strings | C# 101](https://www.youtube.com/watch?v=JSpC7Cz64h0) in Microsoft Learn. Für das Hexafour-Programm, das wir hier schreiben wollen, brauchen wir nicht viel mehr. Darum gehe ich hier nicht viel tiefer auf strings ein.

### Mit null-strings kann es Probleme geben

Wir können den Wert von `colorName` verwenden, um unser Hexagon mit dieser Farbe zu füllen:

```csharp
    pen.EndFill(colorName);
```

Das Hexgon wird so mit der gewünschten Farbe gefüllt. Mit einer Ausnahme: Was passiert, wenn der User im Dialog-Fenster den Cancel-Button angeklickt hat? Wenn du das Programm im Debugger startest (siehe Artikel 3) und den Cancel Button anklickst, zeigt der Debugger dies an:

![image-20220616124454385](/assets/images/hexafour/VsNullException.png)

Das Programm kann irgendwie nicht mit dem Fall umgehen, dass der Benutzer den Cancel-Button geklickt hat. Starte das Programm noch mal neu, setze einen Breakpoint in die Zeile mit `pen.EndFill(colorName)`, und sieh Dir den Wert der Variable `colorName` an (siehe Artikel 4). Die Variable hat den Wert `null`:

![](/assets/images/hexafour/VSColorNameIsNull.png)

Der Parameter von `pen.EndFill` muss eine Farbe sein, aber der Wert `null` ist keine Farbe. Das Programm kann damit nicht umgehen und darum wird eine Exception erzeugt. Man sagt auch: The program throws an exception. Wir müssen den Fall, dass eine Variable den Wert `null` hat, speziell behandeln. Wir wir das machen, sehen wir uns weiter unten an. Zunächst sehen wir uns aber diesen seltsamen `null` Wert noch genauer an. Im obigen Beispiel haben wir den User nach einem Text gefragt, wenn wir ihn nach einer Zahl fragen, wird es noch interessanter.

### Vom Benutzer eine Zahl abfragen

In unserem geplanten Spiel soll der User angeben können, in welchen "Slot" er seinen nächsten Spielstein setzen möchte. Den Slots geben wir am besten fortlaufende Nummern. Der User soll dann eine Nummer eingeben können. Für die Eingabe von Zahlen gibt es eine spezielle Woopec-Methode:

```csharp
    var userInput = pen.Screen.NumInput("Choose slot", "Enter a slot-number in the range 1..7", 4, 1, 7);
```

Die ersten beiden Parameter kennen wir schon von der `TextInput` Methode. Der dritte Parameter ist ein Default-Wert. Die vierte Wert gibt einen Minimalwert für die Eingabe an, und der fünfte Wert einen Maximalwert. Wenn der User einen Text eingibt, der keine Zahl ist, oder er gibt eine Zahl an, die nicht im Range von Minimal- und Maximalwert liegt, wird ihm sein Fehler angezeigt und er muss seine Eingabe korrigieren:

![image-20220616133048922](/assets/images/hexafour/WoopecNumInput.png)

Wir können uns in unserem Programmcode also darauf verlassen, dass die `NumInput` Methode ein ganze Zahl zwischen 1 und 7 zurück gibt. Bis auf eine Ausnahme: Wenn der User den Cancel-Button gewählt hat, wird der Wert `null` zurückgegeben.  Und das ist auch hier ein Problem:

### Der Wert null ist nicht dasselbe wie der Wert 0

Wir ändern das Programm mal probeweise so, dass wir zu `userInput` die Zahl 50 addieren:

```csharp
    var userInput = pen.Screen.NumInput("Choose slot", "Enter a slot-number in the range 1..7", 4, 1, 7);
    var movement = userInput + 50;
```

Wir führen das Programm im Debugger aus und klicken in der Zahleingabe den Cancel Button. Danach hat `inputValue` den Wert `null`. Dann führen wir die Zeile mit der Zuweisung an `movement` aus. Welchen Wert hat dann die Variable `movement`? Man könnte denken, den Wert `50`. Das ist aber nicht so, der Wert von `movement` ist `null`. Hieran sieht man, dass es einen Unterschied macht, ob die Variable`inputValue` den Wert `null` hat oder den Wert `0`. Das sind zwei ganz verschiedene Dinge. Mit dem Wert `null` kann man nicht rechnen. 

### Die Typ int? und wie man daraus wieder einen int macht

Hier haben wir einen Fall, in dem es besser ist, nicht `var` zu benutzen, sondern explizit hinzuschreiben, welchen Typ unsere Variablen haben. Eigentlich würde man denken, dass es sich so verhält:

```csharp
    int userInput = pen.Screen.NumInput("Choose slot", "Enter a slot-number in the range 1..7", 4, 1, 7);
```

Visual Studio gibt für diese Codezeile aber den folgenden Error an: `Cannot implicitly convert type 'int?' to 'int'`.  Was bedeutet das? Die `NumInput` Methode liefert gar kein Ergebnis vom Typ `int` zurück, sondern ein Ergebnis vom Typ **`int?`** und dieser Typ passt nicht zum Typ der Variablen `userInput`. Der Typ `int?` ist ein sogenannter [nullable value type](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/builtin-types/nullable-value-types). Das Fragezeichen hinter einer Variablen vom Typ `int?` gibt an, dass so eine Variable eine Zahl (also einen `int`) enthalten kann oder der Wert `null`.  Dem entgegengesetzt darf eine Variable vom Typ `int` darf nur eine Zahl enthalten und nicht die `null`.  Weil `NumInput` einen Ergebnis vom Typ `int?` zurückgibt, muss auch unsere Variable `userInput` diesen Typ haben:

```csharp
    int? userInput = pen.Screen.NumInput("Choose slot", "Enter a slot-number in the range 1..7", 4, 1, 7);
```

Wir können den Wert von `userInput` nicht einfach einer Variablen vom Typ `int` zuweisen. Die folgende Codezeile ist falsch, weil `userInput` einen anderen Typ hat als `movement`:

```csharp
    int movement = userInput;
```

Aber so geht es:

```csharp
    int movement = userInput.GetValueOrDefault();
```

Die Methode **`GetValueOrDefault()`** liefert immer einen Wert vom Typ `int` zurück. Bei einer richtigen Zahlen gibt sie die Zahl selbst zurück, und im Fall von `null` die Zahl 0. 

### C# Bedingungen mit `if` definieren

In unserem Programm müssen wir jetzt irgendwie mit dem Sonderfall umgehen, dass der User nicht das Gewünschte eingegeben hat. Hierbei hilft uns der **`if` Befehl** von C#. Wir können es zum Beispiel so machen:

```csharp
    var colorName = seymour.Screen.TextInput("Choose color", "Enter a color-name (for instance: red)");

    if (colorName == null)
    {
        colorName = "red";
    }
```

Der `if`-Befehl ist ähnlich wichtig wie Schleifen (siehe Artikel 4). Ein `if` Statement besteht aus folgenden Teilen:

* Zunächst kommt das `if` Kennwort
* Danach kommt die `if` Bedingung. Diese muss immer in runden Klammern stehen. In unserem Beispiel lautet die if-Bedingung `colorName == null`. Die beiden Zeichen `==` bedeuten "ist gleich". Das heißt in unserem Beispiel: Die if-Bedingung ist erfüllt, wenn der Wert von  `colorName` gleich null ist.
* Danach kommt ein Code-Block mit beliebig vielen Zeilen. Dieser Code-Block beginnt mit `{` und endet mit `}`.  Alle Code-Zeilen, die zwischen diesen beiden Klammern stehen, gehören zu diesem Code-Block und werden ausgeführt, wenn die `if`-Bedingung erfüllt ist.
* Damit man erkennen kann, wo der Code-Block anfängt und wo er aufhört, werden die Klammern in eigene Zeilen geschrieben und der Inhalt des Code-Blocks wird eingerückt. (Das machen wir bei `if`-Code-Blöcken genauso wie bei Schleifen).

### C# `if` und `else`

Wir können dem Programm auch mitteilen was es tun soll, wenn die Bedingung hinter dem `if` nicht zutrifft. Das sieht dann beispielsweise so aus:
```csharp
    var userInput = pen.Screen.NumInput("Choose slot", "Enter a slot-number in the range 1..3", 4, 1, 7);
    if (userInput == null)
    {
        pen.Screen.Bye();
    }
    else
    {
        int slotNumber = userInput.GetValueOrDefault();
        // ...
    }
```

Der else-Befehl bildet mit dem vorherigen if-Befehl eine Einheit. Der Code sagt quasi: `if ` the userInput is `null` execute the first code block, `else` execute the second code block. Im obigen Beispiel wird der `if` Block ausgeführt, wenn `userInput` den Wert `null` hat, weil der Benutzer den Cancel-Button geklickt hatte. In diesem Fall wird das Programm einfach beendet. Dazu wird die Woopec-Methode `Bye()` benutzt. Der `else` Block wird  ausgeführt, wenn `userInput` ungleich `null` ist. Wir müssen den Wert von `userInput` mit `GetValueOrDefault` in einen `int` Typ umformen, sonst könnten wir ihn nicht an `slotNumber`zuweisen.

Weitere Informationen zu den `if` und `else` Befehlen findest du in [C# if statements and loops - conditional logic tutorial][MSDocsLoops]. Dieses Tutorial solltest du dir unbedingt ansehen, weil dort viele Dinge erklärt werden.


### Alles zusammen in einem Programm

Wenn wir alle obigen Stücke zusammensetzen, sieht unser Programm so aus:

```csharp
public static void WoopecMain()
{
    var pen = Pen.CreateExample();

    var edgeLength = 50;
    var numberOfEdges = 6;

    int? userInput = pen.Screen.NumInput("Choose slot", "Enter a slot-number in the range 1..7", 4, 1, 7);

    if (userInput == null)
    {
        // The user want's to quit the game.
        pen.Screen.Bye();
    }
    else
    {
        int slot = userInput.GetValueOrDefault();
        pen.Move(slot * edgeLength);

        pen.BeginFill();
        for (var edgeCounter = 0; edgeCounter < numberOfEdges; edgeCounter++)
        {
            pen.Rotate(360.0 / numberOfEdges);
            pen.Move(edgeLength);
        }
        pen.EndFill(Colors.Green);
    }
}
```

Das Programm kann jetzt schon ein paar Dinge: Es kann den User nach einem Slot fragen und kann abhängig davon, welchen Slot der User eingegeben hat, an der entsprechenden Stelle ein Hexagon zeichnen. Für das vollständige Spiel werden wir noch viel mehr Code schreiben müssen. Und der Code fängt schon wieder an, unübersichtlich zu werden - so richtig schöner clean code ist das nicht mehr. Das sollten wir bald wieder ändern, aber zunächst müssen wir noch weitere C# Elemente kennen lernen.

### Kurze Zusammenfassung

C#

* Kompletter Überblick zu strings: [Strings - C# Programming Guide | Microsoft Learn](https://learn.microsoft.com/en-us/dotnet/csharp/programming-guide/strings/), aber für Anfänger noch zu schwer.

* 
* Gefüllte Shapes mit *`BeginFill` und `EndFill`*  erzeugen.
* Nutzer-Input mit *`TextInput` oder `NumInput`* abfragen.
* Programmfehler erzeugen *Exceptions*. Die Ursache findet man mit dem Debugger.
* Mit dem *`if`* und dem *`else`* Befehl kann man die Code-Ausführung von Bedingungen abhängig machen.

### Übung

Der Code im vorherigen Artikel hat ein Sechseck gezeichnet. Wie kann man den Code so ändern, dass der Benutzer angeben kann, wieviele Ecken gezeichnet werden sollen?

[MSDocsLoops]: https://docs.microsoft.com/en-us/dotnet/csharp/tour-of-csharp/tutorials/branches-and-loops-local
[WoopecDocsMainClasses]: https://frank.woopec.net/woopec_docs/MainClasses.html
[hexafour-05]: {% post_url 2023-08-13-hexafour-05-variables-loops-dry %}

[hexafour-overview]: {% post_url 2023-07-01-hexafour-01-overview %}#overview-of-the-posts-in-this-series

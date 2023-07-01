---
layout: posts
title: The first C# program with graphics
tags: .NET
excerpt_separator: <!--more-->
typora-root-url: ..
---

Wir installieren die für C# Programmierung notwendigen Werkzeuge, schreiben ein erstes Programm mit der Woopec-Grafik-Bibliothek und starten das Programm.

<!--more-->

### Überblick

Ich fange hier ganz vorne an und erkläre, was du für das Entwickeln mit C# auf deinem Rechner installieren musst und wie du Schritt für Schritt damit erste Programme schreiben kannst. Ich nutze hier erst mal Turtle-Graphics, weil damit der Einstieg in die Programmieren leichter fällt. Falls du dich schon etwas in Programmierung mit C# auskennst, kannst du diesen und die nächsten Artikel auch kurz überfliegen. Wir werden Turtle-Grafiken bald wieder hinter uns lassen und kompliziertere Dinge machen.

### Die passenden Werkzeuge

In diesem und den folgenden Artikeln werde ich das C# Programmieren schrittweise und einfach erklären. Vorher müssen aber zunächst die richtigen Werkzeuge auf unserem  Computer installieren, und wir müssen ein paar grundlegende Dinge über diese Werkzeuge wissen.

An Werkzeugen benötigen wir: Einen Windows Computer, die Entwicklungsumgebung Visual Studio und die Grafik-Bibliothek Woopec. 

Als erstes müssen die notwendigen Werkzeuge auf dem Computer installiert werden:

1. Download and install the newest version of  [Visual Studio Community Edition](https://visualstudio.microsoft.com/de/vs/community/). It's free!

2. Take five minutes to learn how you can build and start your first console application with Visual Studio. View [Getting Started with Visual Studio 2019](https://www.youtube.com/watch?v=1CgsMtUmVgs&list=RDCMUChqrDOwARrxdJF-ykAptc7w) for this.

3. Close Visual Studio and open it again. In the first screen choose the link "Continue without code".

4. In Visual Studio choose the menu item `Tools -> Command Line -> Developer Command Prompt` to open a command window. In the command window type this command: 

   ```sh
   dotnet new install Woopec.Templates
   ```

   Press the Enter-key and close the command window.

Jetzt ist dein Computer bereit für C# Programme und Grafiken mit der Woopec Bibliothek.

Follow the steps of [Getting Started with Visual Studio 2019](https://www.youtube.com/watch?v=1CgsMtUmVgs&list=RDCMUChqrDOwARrxdJF-ykAptc7w) to create a new project, but instead of choosing the "Console App" template search for for the template "Woopec Turtle WPF Project" and choose this template. Wähle einen Namen für dein Projekt, mein Vorschlag: `HexaFour`, gib in der Location an, wo dein Programm gespeichert werden soll, und wähle dann den Create-Button.

Visual Studio erzeugt das Projekt und zeigt dir eine Liste der Dateien an. Wähle die Datei `Program.cs` aus. 

### Das erste Programm

Visual Studio zeigt dir den folgenden Programmcode:

```csharp
using Woopec.Core;

internal class Program
{
    public static void WoopecMain()
    {
        var seymour = Turtle.Seymour();

        seymour.Left(45);
        seymour.Forward(100);
        seymour.Right(45);
        seymour.Forward(50);
    }
}
```

Bevor ich genauer erkläre, was dieses Programm macht, probieren wir es erst mal aus. Dazu rufst du im Visual Studio Menü den Punkt Debug - Start Debugging auf:

![image-20230701210046135](/assets/images/hexafour/VisualStudioStartDebugging.png)

Das Programm zeigt ein Fenster an und eine kleine Schildkröte zeichnet einen grünen Strich. 

Zum Beenden des Programm rufst du im Visual Studio Menü den Punkt Debug - Stop Debugging auf.

### Die ersten C# Befehle

Der wichtigste Teil des Programm sind diese vier Zeilen
```csharp
        seymour.Left(45);
        seymour.Forward(100);
        seymour.Right(45);
        seymour.Forward(50);
```

`seymour` ist eine Grafik-Turtle, die mit diesen vier Zeilen auf dem Bildschirm bewegt wird.  `Left`,  `Right` und `Forward` sind sogenannte **Methoden**. Mit diesen kann man die Turtle links oder rechts herum drehen und nach vorne laufen lassen. Die Zahlen in Klammern sind sogenannte **Parameter**. Diese geben an, wieweit sich die Turtle drehen oder wieweit sie gehen soll. Ein einzelner Schritt, beispielsweise `seymour.Left(45)` wird **Statement** genannt. Wichtig ist, dass man am Ende eines Statements das Semikolon `;` nicht vergisst. Dies wird von C# benötigt, um zu erkennen, wo das Statement zu Ende ist. 

Die allererste Zeile des Programms (`using Woopec.Core;`)  sorgt dafür, dass wir im Programm-Code die Woopec-Bibliothek verwenden können. Eine Bibliothek erweitert die Programmiersprache C# um zusätzliche Funktionalität. Die Woopec-Bibliothek enthält die Grafik-Turtle `Turtle.Seymour()` mit einfachen Zeichenfunktionen wie zum Beispiel die `Left` und `Forward` Methoden. Diese **Turtle-Grafik** erleichtert zu Beginn den Einstieg in die Grafik-Programmierung. Im fertigen Spiel wollen wir natürlich keine Turtles mehr sehen, wir nutzen später Woopec-Funktionen, die mit Turtles nichts mehr zu tun haben.

Die anderen Teile des Programms können wir hier erst mal ignorieren. Sie sind notwendig, damit das Programm funktioniert, verstehen können wir sie später.

### Der Visual Studio Editor

Wir nutzen hier **Visual Studio**. Visual Studio ist eine IDE ([Integrated development environment](https://en.wikipedia.org/wiki/Integrated_development_environment)). In so einer IDE sind viele nützliche Tools integriert. Das erste Tool ist der *Editor*. Der Editor zeigt den Programm-Code aus der Datei Program.cs an. Der Editor hat viele nützliche Features. Eines davon ist **Intellisense**. Wenn du die Maus beispielsweise auf die Methode `Left` bewegst, wird eine kleine Beschreibung der Methode und ein kleines Beispiel angezeigt.

### Das Programm mit Visual Studio compilen und starten

Wenn wir im Visual Studio den Menüpunkt Debug - Start Debugging oder die **Taste F5** drücken, passieren mehrere Dinge: 

* Als erstes startet Visual Studio den **Build** des Programms. Das bedeutet, dass der Programmcode in eine Maschinen-lesbares Format übersetzt wird, das *compiled program*.
* Visual Studio startet das compiled program.
* Visual Studio startet zusätzlich einen **Debugger**, mit dem wir die einzelnen Schritte des Programms mitverfolgen können. Dazu kommen wir später.

Während der Compilation wird auch eine  *Executable* Datei erzeugt (HexaFour.exe). Diese Datei könnten wir im Datei-Explorer suchen und über Doppelklick von dort aus unser Programm starten. Das würde auch ohne Visual Studio funktionieren. Während der Programm-Entwicklung ist es aber viel einfacher, das Programm über Visual Studio F5 zu starten.

### Compile Fehler beheben

Programmiersprachen sind pingelig. Ein falsch geschriebener Methodenname oder ein falsches Zeichen führen dazu, dass das Programm nicht compiled werden kann. Stattdessen werden **Build Errors** angezeigt und das Programm kann nicht gestartet werden. Wichtig ist beispielsweise, dass man am Ende eines Statements das Semikolon `;` nicht vergisst. Dies wird von C# benötigt, um zu erkennen, wo ein Statement zu Ende ist. Wenn du beispielsweise das Semikolon hinter `seymour.Left(45)` entfernst und das Programm mit F5 ausführst, wird eine Fehlermeldung angezeigt: `There were build errors. Would you like to continue and run the latest succesful build?`.  Solche Build Errors muss du erst korrigieren bevor du das Programm ausführen kann. Visual Studio zeigt dir aber genau an, was für ein Fehler gefunden wurde und wo sich dieser Fehler befindet:

<img src="/assets/images/hexafour/VSSyntaxError.png" alt="Build Error" style="zoom:80%;" />

Zum einen zeigt eine geschlängelte rote Linie in `Program.cs` an, wo etwas falsch ist. Und in der Error List werden alle Fehler als Liste mit Erklärungen angezeigt. Mit Doppelklick auf einen Zeile der Error-Liste springt der Editor genau an die fehlerhafte Stelle und du kannst den Fehler korrigieren.

### Kurze Zusammenfassung

* Ein C# Programm besteht aus *Statements*. In einem Statement kann ein *Methode* aufgerufen werden. Über *Parameter* kann angegeben werden, was die Methode tun soll.
  Nicht vergessen: Am Ende eines Statements muss immer ein Semikolon (`;`) stehen.
* Wir nutzen *Visual Studio* als IDE. In Visual Studio können wir *Intellisense* nutzen, um uns Hilfe zur Funktionsweise von Methoden zu holen. Bevor wir ein Programm *debuggen* können, muss es *build* werden. Falls es dabei Probleme gibt, werden diese als *Build Errors* angezeigt.
* Über die Taste *F5* (oder den Menüpunkt Debug-Start Debugging) wird zunächst ein Build gemacht und danach - wenn es keine Build Errors gab -- das Programm im Debugger ausgeführt.
* Über die Taste *Shift-F5* (oder den Menüpuntk Debug - Stop Debugging) wird das Programm und der Debugger beendet.

### Übung

Ändere das Programm so, dass es ein Sechseck zeichnet.






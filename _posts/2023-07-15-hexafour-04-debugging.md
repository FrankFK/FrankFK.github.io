---
layout: posts
title: H4.04 Why is this simple C# Program not working? Fixing Compiler Errors and using the Visual Studio Debugger
tags: LearnToCode C# HexaFour
excerpt_separator: <!--more-->
typora-root-url: ..
---
![xxx](/assets/images/hexafour/CompilerErrors.png)

You have written your first C# program and it compiles with errors? This is quite normal in the beginning. Don't let that stop you from learning C#. Here I explain some of the most common errors and how to fix them. Your program runs, but doesn't do what it's supposed to do? This is also quite normal. With the Visual Studio Debugger, you can see step-by-step what your program is doing and quickly find out what is wrong.

<!--more-->

### CS1002 ; expected

Let's start with an example:

```csharp
internal class Program{static void Main(string[] args){Console.WriteLine("Hello World")}}
```

The C# compiler has a problem with this program, it expects a semicolon somewhere. That is why it issues the error message "CS1002 ; expected". In the example above, I intentionally wrote everything on one line, because that is more like how the compiler sees your program code. You would write the above program more like this:

```csharp
internal class Program
{
    static void Main(string[] args)
    {
        Console.WriteLine("Hello World")
    }
}
```

From the compiler's perspective, this version of the program is just like the first one. The C# compiler does not care about spaces or line breaks in your program. That is why it needs a sign by which it can determine that a statement has come to an end. And this sign is the semicolon. Each statement must be terminated with a semicolon, otherwise the compiler will not recognize it. So you have to add a semicolon after the statement that prints "Hello World".

Visual Studio does a lot to help you fix such errors:

![image-20230722152345840](/assets/images/hexafour/VSErrorHelp.png)

(1) The error is displayed in the **Error List**. (2) If you click on the link [CS1002](https://learn.microsoft.com/en-us/dotnet/csharp/misc/cs1002?f1url=%3FappId%3Droslyn%26k%3Dk(CS1002)), you will see a description of the error. (3) In the editor, at the end of line 5, the error location is marked with a red squiggle. And (4) the light bulb at the beginning of line 5 offers you Quick Actions to fix the error. These Quick Actions don't help with this particular error, but the other offerings should help with this type of error.

### Brackets that do not match

C# uses different types of parentheses to indicate the beginning and end of something:

* Curly braces `{` and `}`mark the beginning and end of a code block.
* Square brackets `[`and `]`mark the beginning and end of list-like things.
* Round brackets `(` and `)` enclose the parameters of methods.

If there is a bracket in a file without a partner, then the C# compiler also has a problem. When we delete a *closing* bracket, we usually get appropriate error messages

* CS1513 } expected
* CS2026 ) expected
* CS1003 ] expected

With a small program, the cause of such errors can be found relatively quickly. But it becomes more difficult when the program has many lines. The compiler only knows *that* a bracket is missing, but not *where* it is missing. That is why it displays the error in this example like this:

![](/assets/images/hexafour/VSErrorMissingClosingBrace.png)

The error is displayed at the very end of the file. Now how do you find the place where the bracket is really missing? There are options here as well.

For one thing, you can put the cursor behind the last bracket. Then Visual Studio displays this bracket with a gray background, and it displays the **corresponding opening bracket** also with a gray background. In the example above, this is the bracket in line 4. This doesn't fit properly, and you can see that line 6 is missing a closing parenthesis.

On the other hand, you can also make the cursor **jump to the corresponding opening parenthesis**. For this you use the keyboard shortcut **Ctrl+]**.

### When the faulty spot is difficult to find.

If your program is missing an *opening* parenthesis, the C# compiler has more trouble giving you a good error message. Because the opening bracket is missing, the compiler does not understand the code behind it correctly and displays many error messages:

![image-20230722171641050](/assets/images/hexafour/VSErrorMissingOpeningBrace.png)

Fortunately, it is not so common that an opening bracket is missing. But in such cases it is more difficult to find the error. In this example an opening parenthesis is missing in line 4. This has generated 10 compiler errors! And the first error is printed one line in front of the real error! The only thing that helps here is to stay calm and try to narrow down the location where the error is likely to be. If you can't find the error at all, you can try to make your program smaller. You don't have to delete any lines of the program for that, you can comment them out. A **comment** is a part of your code that the compiler does not even consider. Normally you use this to comment for others how the code is intended. You can find a description of comments in [Microsoft Learn](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/tokens/comments). Here I put a part of the program in a comment, and after that there are no more errors. That's why the cause of the error must be in the commented out part of the program:

![image-20230722174542877](/assets/images/hexafour/VSErrorSearchWithComments.png)

Next, I commented out a smaller part. Now there are errors again. So the error must be somewhere in line 3, 4 or 6:

![image-20230722175111211](/assets/images/hexafour/VSErrorSearchWithComments2.png)

Normally, you find the error this way. If not, you can try rewriting the code in small bites: Start with a version that is compiled without errors. Then gradually add small pieces and check the code again by compiling it. Eventually, you will reach the incorrect location, or you will have automatically written the code correctly.

### Sometimes you can fix errors with Visual Studio Quick Actions

In the following example, I have modified the program from the [last post][hexafour-03] so that it has an error in line 5. The compiler does not know the name "Turtle". If you place the cursor in the faulty line, a small light bulb is displayed at the beginning of the line, showing so-called Quick Actions:

![image-20230722181632217](/assets/images/hexafour/VSQuickActionsAddUsing.png)

Four different Quick Actions are suggested here. The first one is exactly what is missing here: A `using Woopec.Core;` statement must be added at the top of the file. You can correct this directly with the Quick Action. When fixing compiler errors, you have to be a little careful with the Quick Actions. The other three suggestions in this example would not have helped at all. Often there is nothing that helps at all. But sometimes the right suggestion is there.

### By the way: Visual Studio keyboard shortcuts

These were a few tips for fixing compiler errors. Before I give a few tips on debugging, I would also like to briefly mention the Visual Studio Keyboard Shortcuts. I have already mentioned the shortcut *Ctrl+]* above, with which you can jump back and forth between corresponding brackets. This is just the tip of the iceberg. Visual Studio's text editor has over 100 shortcuts. You can find the complete list [here](https://learn.microsoft.com/en-us/visualstudio/ide/default-keyboard-shortcuts-in-visual-studio?view=vs-2022#bkmk_text-editor-context-specific-shortcuts).

### Hier weiter

Zum Debuggen gibt es viele gute Artikel. Google zeigt mir als bestes Suchergebnis beispielsweise diesen an: [First look at the debugger - Visual Studio (Windows) | Microsoft Learn](https://learn.microsoft.com/en-us/visualstudio/debugger/debugger-feature-tour?view=vs-2022)  

.NET Core 101 [.NET: Grundlegendes Debuggen [4 von 8\] | Microsoft Learn](https://learn.microsoft.com/de-de/shows/net-core-101/net-basic-debugging) ist gut, setzt aber schon viel zu viel voraus und geht schon viel zu weit.

[Debugging | C# 101 [15 of 19\] - YouTube](https://www.youtube.com/watch?v=pm_pv0Eb7Fw) ist mehr für Einsteiger. Das, was über den Debugger erzählt wird, ist für Anfänger passend. Man versteht den  Code als Anfänger aber nicht, weil er schon relativ viel Konzepte enthält. Ich fange hier viel früher mit dem Debugger an.

Es ist nicht sonderlich sinnvoll, hier den besten Artikel zum Debuggen schreiben zu wollen. Eher: Versuchen es einfacher zu machen für Leute, denen der Artikel von MS zu schwierig ist? 

Eher in die Richtung gehen:  Diese Debugger Befehle musst du kennen, wenn du mit der Programmierung von C# beginnst.





### Das Programm schrittweise im Debugger ausführen

Wenn es keine Build Errors mehr gibt, macht das Programm aber vielleicht trotzdem nicht was es soll. Bei der Fehlersuche hilft der Debugger.

Bevor du das Programm startest (und auch während das Programm läuft), kannst du den Cursor in eine Zeile im Programm setzen und dort die **F9 Taste** (oder im Debug-Menü den Eintrag "Toggle Breakpoint") auswählen. Das Statement wird dann rot markiert und die Zeile mit einem Punkt markiert:

![image-20220527191547448](image-20220527191547448.png)

Das bedeutet, dass dort jetzt ein **Breakpoint** gesetzt ist. Wenn das Programm jetzt im Debugger (mit F5) gestartet wird, hält es am ersten Breakpoint an, und zeigt das dadurch an, dass die Stelle gelb markiert wird:

![image-20220527192109091](image-20220527192109091.png)

Bevor du weitermachst, musst du das Visual Studio Fenster und das Turtle-Programm-Fenster nebeneinander stellen. Dazu musst du das Visual Studio Fenster über das Icon rechts oben verkleinern, so dass es nicht den ganzen Bildschirm einnimmt und dann das Turtle-Programm-Fenster daneben schieben. In Windows 11 geht das ganz einfach, indem du die Maus auf das Resize-Icon bewegst und dann in dem Auswahlfenster auswählst, dass Visual Studio auf der rechten Seite des Bildschirms angezeigt werden soll:

![image-20220527192636178](image-20220527192636178.png)

!!! Mal ausprobieren, ob man mit unterschiedlichen Windows Layouts arbeiten kann: [Customize window layouts and personalize document tabs - Visual Studio (Windows) | Microsoft Learn](https://learn.microsoft.com/en-us/visualstudio/ide/customizing-window-layouts-in-visual-studio?view=vs-2022) !!!



Wenn du auf das blaue Rechteck geklickt hast, wird Visual Studio auf die rechte Bildschirmhälfte verkleinert und es wird links daneben eine Liste der Fenster angezeigt, aus denen du das Fenster für die linke Hälfte auswählen kannst. Hier wählst du das Turtle-Programm-Fenster. Danach sollte es so ungefähr aussehen:

![image-20220527193450946](image-20220527193450946.png)

Jetzt klickst du einmal in den Code-Editor vom Visual Studio, damit du dich sicher im Visual Studio befindest. Und dann kannst du das Programm Schritt für Schritt ausführen: Durch drücken der **Taste F10** (oder im Debug-Menü die Funktion "Step Over") wird das nächste Statement des Programm ausgeführt. Im obigen Beispiel dreht sich die Turtle also um 60 Grad nach rechts. Im Visual Studio Fenster wandert die gelbe Markierung auf das nächste Statement:

![image-20220527194042041](image-20220527194042041.png)

Mit dem nächsten F10 wird das nächste Statement ausgeführt. Du kannst auch einen weiteren Breakpoint setzen, zum Beispiel in die weiter unten liegende Zeile:

![image-20220527194258839](image-20220527194258839.png)

Wenn du dann die **Taste F5** (oder im Debug-Menü die Funktion "Continue") auswählst, läuft das Programm normal weiter und hält erst wieder an, wenn es diesen Breakpoint erreicht hat.

Wenn du an einer Stelle angekommen bist, die falsch programmiert ist, kannst mit der **Taste Shift-F5** (oder im Debug-Menü die Funktion "Stop Debugging") das Debugging sofort stoppen. 

Du kannst den Code deines Programms erst dann ändern, wenn das Debugging gestoppt wurde.

Dieses **Debugging ist extrem hilfreich**, weil man auf diesem Weg seinem Code bei der Arbeit zusehen kann. Wenn etwas nicht wie gewünscht funktionert, findet damit schnell den Fehler. Wenn ich an einer Stelle in meinem Programm etwas geändert habe, mache ich es eigentlich immer so: Ich setze einen Breakpoint auf das erste Statement, das ich geändert habe, starte dann den Debugger und prüfe schrittweise nach, ob das Programm genau das tut, was ich mir gedacht habe.

### Kurze Zusammenfassung

* This post is part of a series. You can find the previous post [here][hexafour-03] and an overview [here][hexafour-overview].
* Debugger nutzen: Starten mit *F5*, Breakpoint setzen mit *F9*, Step over mit *F10*, zum nächsten Breakpoint mit *F5*, Debuggen beenden mit *Shift F5*.
* Dieser Artikel hat weitere Tipps: [Fix program errors and improve code - Visual Studio (Windows) | Microsoft Learn](https://learn.microsoft.com/en-us/visualstudio/ide/find-and-fix-code-errors?view=vs-2022)

### Übung

Denk dir ein Bild aus und versuche es mit Turtle-Kommandos zu programmieren. Nutze dabei den Debugger und lerne die Tasten für den Debugger am besten auswendig - Du wirst sie noch oft benötigen.



[Woopec Docs]: https://frank.woopec.net/woopec_docs/Turtle.html

[hexafour-03]: {% post_url 2023-07-14-hexafour-03-draw-a-hexagon %}

[hexafour-overview]: {% post_url 2023-07-01-hexafour-01-overview %}#overview-of-the-posts-in-this-series


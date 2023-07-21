---
layout: posts
title: Why is this simple C# Program not working? Fixing Compiler Errors and using the Visual Studio Debugger
tags: LearnToCode C# HexaFour
excerpt_separator: <!--more-->
typora-root-url: ..
---
![xxx](/assets/images/hexafour/CompilerErrors.png)

You have written your first C# program and it compiles with errors? This is quite normal in the beginning. Don't let that stop you from learning C#. Here I explain some of the most common errors and how to fix them. Your program runs, but doesn't do what it's supposed to do? This is also quite normal. With the Visual Studio Debugger, you can see step-by-step what your program is doing and quickly find out what is wrong.

<!--more-->

### Das Programm schrittweise im Debugger ausführen

Zum Debuggen gibt es viele gute Artikel. Google zeigt mir als bestes Suchergebnis beispielsweise diesen an: [First look at the debugger - Visual Studio (Windows) | Microsoft Learn](https://learn.microsoft.com/en-us/visualstudio/debugger/debugger-feature-tour?view=vs-2022)  Es ist nicht sonderlich sinnvoll, hier den besten Artikel zum Debuggen schreiben zu wollen. Eher: Versuchen es einfacher zu machen für Leute, denen der Artikel von MS zu schwierig ist? 

Eher in die Richtung gehen:  Diese Debugger Befehle musst du kennen, wenn du mit der Programmierung von C# beginnst.

Oder: Diese Tipps helfen dir, wenn deine ersten C# Programme nicht funktionieren. Dann könnte ich auch noch mal auf Fehleranzeige, Quick Actions und nicht nur auf Debugger eingehen. Das ist in etwa die Richtung, die dieser Artikel von  MS geht: [Fix program errors and improve code - Visual Studio (Windows) | Microsoft Learn](https://learn.microsoft.com/en-us/visualstudio/ide/find-and-fix-code-errors?view=vs-2022)

* Klammer-Fehler: 
  * Die andere Klammer wird von VS grau hervorgehoben
  * Zur anderen Klammer gehen
    * Liste von MS: [Keyboard shortcuts - Visual Studio (Windows) | Microsoft Learn](https://learn.microsoft.com/en-us/visualstudio/ide/default-keyboard-shortcuts-in-visual-studio?view=vs-2022)
    * Achtung diese Tastenkombination sind bei anderen Tastaturen ggf. anders. Beispielsweise bei mir Edit.GoToBrace ist Ctrl+´
      * Dazu besser nachsehen in Menu - Customize - Keyboard

Als nächstes willst du vielleicht die verschiedenen Turtle-Methoden ausprobieren und das Programm ganz andere Dinge tun lassen. Wenn es Build Errors  gibt, müssen diese zunächst behoben werden, sonst kann das Programm nicht starten. Wenn es keine Build Errors mehr gibt, macht das Programm aber vielleicht trotzdem nicht was es soll. Bei der Fehlersuche hilft der Debugger.

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

### Übung

Denk dir ein Bild aus und versuche es mit Turtle-Kommandos zu programmieren. Nutze dabei den Debugger und lerne die Tasten für den Debugger am besten auswendig - Du wirst sie noch oft benötigen.



[Woopec Docs]: https://frank.woopec.net/woopec_docs/Turtle.html

[hexafour-03]: {% post_url 2023-07-14-hexafour-03-draw-a-hexagon %}

[hexafour-overview]: {% post_url 2023-07-01-hexafour-01-overview %}#overview-of-the-posts-in-this-series


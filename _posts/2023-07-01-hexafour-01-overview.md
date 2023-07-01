---
layout: posts
title: Learn to fly with C#
tags: .NET
excerpt_separator: <!--more-->
typora-root-url: ..
---

Is it easy to build an airplane? Of course it is: I can learn to make paper airplanes very quickly. But what's the next step if I want to build a real airplane one day? For example, I can build a radio-controlled airplane.

Is it easy to develop software? Sure: I can quickly learn to write a few small console programs. But what's the next step? I have an idea.

<!--more-->

### Software entwickeln ist genau so leicht wir Flugzeuge bauen

Programmieren ist super einfach. Als erstes besorge ich mir eine Programmiersprache, beispielsweise python oder C#. Dann sehe ich mir ein paar Videos an und schon kann ich erste Programme schreiben. Das geht nach wenigen Minuten oder Stunden. Oder ist Programmieren doch nicht ganz so einfach? An Projekten bei Microsoft sind zum Beispiel manchmal mehrere 1.000 Entwickler beteiligt (siehe ["Welcome to the Engineering@Microsoft Blog"](https://devblogs.microsoft.com/engineering-at-microsoft/welcome-to-the-engineering-at-microsoft-blog/)). Und in der Regel haben diese Entwickler eine jahrelange Ausbildung hinter sich.

Angenommen ich möchte lernen, wie ich etwas bauen kann, das fliegt. Dann ist das auch erst mal super einfach. Ich nehme mir ein Blatt Papier, sehe mir ein  paar Videos an, und nach wenigen Minuten habe ich einen Papierflieger gebaut, der fliegt. Aber das ist nur der allererste Schritt. Denn es gibt natürlich viel komplexere Flugzeuge, für deren Bau man sehr viel mehr wissen muss: Segelflugzeuge, Propeller-Flugzeuge, Jets, Passagier-Flugzeuge, ...

Wenn man bei der Entwicklung eines echten Flugzeug mitmachen will, benötigt man sehr viel mehr Wissen als für den Bau des Papierfliegers. Aber wie mache ich weiter, wenn ich schon ein paar gute Papierflieger gebaut habe und mehr lernen möchte? Ich kann ja nicht als nächstes versuchen, eine zweisitzige Propellermaschine zu bauen. Dieser Schritt wäre viel zu groß. Eine gute Möglichkeit ist: Ich baue ein ferngesteuerte Modellflugzeug. Dabei kann ich viel lernen, was auch für größere Flugzeuge relevant ist. Und wenn ich etwas falsch mache, kommt niemand zu schaden - außer mein Portemonnaie, weil ich mein Flugzeug reparieren muss.

Bei Software Entwicklung ist es ähnlich. Es ist leicht, ein paar Konsolen-Programme zu schreiben und dabei erste Dinge zu lernen. Aber dann ist der nächste Schritt nicht einfach. Es ist sehr schwer als nächstes eine App oder Game schreiben. Man muss dann so viele Dinge gleichzeitig lernen, dass man einfach nicht richtig klarkommt.  Man braucht etwas, das schwieriger ist als ein Konsolen-Programm aber leichter als eine echtes, vollwertiges Spiel. Mein Vorschlag: In der folgenden Artikelserie erkläre ich, wie man ein kleines grafisches Computer-Spiel programmiert. Das Spiel ist etwas komplizierter und ich erkläre dabei Schritt für Schritt die Programmiersprache C# und einige weitere Dinge, die bei der Software Entwicklung wichtig sind.

![image-20230628204937752](/assets/images/hexafour/AircraftSoftwareDev.png)

### Spielidee

Erst mal habe ich nur eine grobe Idee für das Spiel, das ich programmieren möchte: Zwei Personen sollen es spielen können. Die Spieler können abwechselnd sechs-eckige Steine von oben in ein Spielbrett einwerfen. Ein Spielstein fällt solange herunter, bis er auf Lagerposition trifft. Er gibt zwei Möglichkeiten:

![image-20230701191857281](/assets/images/hexafour/GameIdeaAnchors.png)

Wenn die Ankerposition frei ist (Fall a), bleibt der Spielstein auf der Ankerposition stehen. Wenn die Ankerposition von einem anderen Spielstein belegt ist (Fall b), bewegt sich der andere Spielstein weiter und der von oben kommende Spielstein nimmt die Ankerposition ein.

Gewonnen hat der Spieler, der zuerst vier seiner Steine in einer horizontalen oder schrägen Linie hat. In diesem Beispiel hat blau im nächsten Zug gewonnen:

![image-20230701193340443](/assets/images/hexafour/GameIdeaBlueWillWin.png)

Der Ablauf des nächsten  Zugs von blau ist mit blauen Pfeilen markiert. Der neu eingeworfene Spielstein wird den darunter liegenden blauen Spielstein verschieben. Dieser Spielstein wird sie eine Position weiter schräg nach unten bewegen und dann mit drei anderen Spielsteinen eine Viererreihe bilden. Damit hat blau gewonnen.

Einen Namen für das Spiel habe ich auch schon: "HexaFour". "Hexa", weil die Spielsteine  Hexagons sind und "Four", weil man vier in einer Reihe benötigt, um zu gewinnen.

Außer dem Namen und der groben Spielidee sind noch viele Dinge unklar. Es lohnt sich aber nicht, zunächst für alles und jedes ein Konzept zu machen und erst dann mit dem Programmieren anzufangen. Man kommt viel besser voran (und hat mehr Spaß), wenn man die ersten Dinge schnell umsetzt, das dann ausprobiert und von da aus weiterüberlegt, wie es am besten weitergeht. In echten Software-Projekten wird das oft genauso gemacht, man nennt das Agile Softwareentwicklung.

### Werkzeuge

Ich verwende hier die  **Programmiersprache C#**. C# ist für Einsteiger vielleicht ein kleines bisschen schwieriger als beispielsweise python. Wenn die Programme größer werden, ist man meiner Ansicht nach aber mit C# optimal unterwegs. Es gibt viele kommerzielle Programme, die mit C# entwickelt werden.

Für echte Spiele benötigt man eigentlich eine **Gaming-Engine** - wir könnten beispielsweise Unity benutzen. Als Anfänger muss man dann aber sehr viele Dinge gleichzeitig lernen: Die Programmiersprache C#, Werkzeuge für diese Programmiersprache, die Gaming-Engine, Werkzeuge für die Gaming Engine, usw.. Das ist sehr viel für den Anfang.  Daher starte ich hier ohne Gaming-Engine und nutze stattdessen die **Grafik-Bibliothek Woopec** . Ich bin da nicht ganz unparteiisch, weil ich [Woopec](https://frank.woopec.net/woopec_docs/WoopecIntro.html) selbst entwickelt habe :-)

Das Spiel in diesem Kurs wird nicht so cool aussehen wie ein Unity-Spiel, aber dafür kannst du hier mit ganz wenig Voraussetzungen anfangen. Du lernst, wie man C# ein Spiel mit grafischer Benutzeroberfläche programmiert und kannst dann für das nächste Spiel mit Unity weitermachen. Als Programmiersprache wird in Unity auch C# benutzt, Du lernst also nichts umsonst.

Für Software-Entwicklung muss man sich nicht nur mit einer Programmiersprache und Tools auskennen. Wenn ein Programm größer wird, werden noch andere Dinge wichtig. Die erste Version eines Programms ist schnell zusammengebaut. Man nagelt sinngemäß ein paar Bretter zusammen und schon hat man ein Haus mit einem Dach, in dem man trocken sitzen kann. Aber dann braucht das Haus mehr Räume und zusätzliche Stockwerke. Dann soll das Haus zu einer kleinen Stadt ausgebaut werden. Man braucht mehr Häuser, dann Straßen, dann größere Straßen, ein Krankenhaus, ein Theater, einen Flugplatz, ... Irgendwann ist ein Punkt erreicht, wo das sehr kompliziert werden kann. Ab einer gewissen Größe verliert man die Übersicht wenn das Ganze nicht gut organisiert und strukturiert ist. Darum werde ich hier bei der Entwicklung unseres Programms auch Schritt für Schritt immer stärker darauf achten, dass das Programm gut organisiert und strukturiert ist. Im seinem Buch "Clean Code. A Handbook of Agile Software Craftsmanship" nennt Robert C. Martin das **Clean Code**. 

> [...] writing clean code ist a lot like painting a picture [...] a programmer who writes clean code is an artist who can take a blank screen throug a series of transformations until it is an elegantly coded system.

Mal sehen, wie gut uns das hier gelingen wird.

### Überblick über die folgenden Artikel

In den folgenden Artikeln werde ich beschreiben, wie man mit C# und Woopec-Grafik ein etwas kompliziertes Spiel programmieren kann. Dabei werde ich auch auf Werkzeuge, Programmier-Praktiken und Clean-Code-Prinzipien eingehen. Die folgenden Artikel sind aber ganz bestimmt **keine vollständige Einführung** in C#, Programmierpraktiken oder Clean Code. An einigen Stellen wird es Links auf nähere Informationen geben. An vielen Stellen hilft es aber auch, im Internet nach weiteren Informationen zu suchen.

Hier geht es nur darum anhand eines größeren Beispiels kennenzulernen, wie Software-Entwicklung funktioniert und worauf man dabei achten muss. Ich werde versuchen, ganz klein anzufangen und dann schrittweise immer neue Dinge hinzuzunehmen, so dass am Ende ein fertiges, größeres Programm entsteht. 

Die folgende Liste enthält die bisher erschienen Artikel dieser Serie:

**Artikelliste**:

* 01 - 
* 02 - 

Wenn du nach bestimmten Themen suchst, helfen dir diese Listen:

**C#**:

* Methode, Parameter, Statement: 02

**Visual Studio**:

* Installation, Debugger starten, Debugger beenden: 02

**Woopec-Grafik-Bibliothek**:

* Woopec Projekt erzeugen, erste Turtle Kommandos: 02

**Clean Code**:

* xxx

**Hexa Four Spiel**

* Spielidee: 01
* 


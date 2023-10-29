---
layout: posts
title: First design a Concept and then program it (h4-07)
tags: CodeQuality 
excerpt_separator: <!--more-->
typora-root-url: ..
---

<img src="/assets/images/hexafour/UiConceptTitle.png" alt="A game board with blue hexagons on top." style="zoom:78%;" />

Software development has a lot to do with finding good solutions. Sometimes this is easy, but often it is complicated. In these cases it makes absolutely no sense to start programming immediately. If you do that, it will take you much too long to find a good solution. It is much better to design a good concept first and then start programming.

<!--more-->

In my [previous post]({% post_url 2023-10-16-plea-for-concept %}) I wrote that conceptual work is important in professional software development. But the same is true for the HexaFour game, which we want to program step by step here. In the [fifth article of the HexaFour][hexafour-05] series we already wrote code that draws a hexagon. For this we didn't need a concept. But next we need code that draws the game board. This is not as easy as it looks at first. Here it is definitely worth making a concept first.

### Konzept für das Spielbrett

Wir wissen jetzt, wie wir eine Spieltoken zeichnen können. Als nächstes wollen wir das Spielbrett zeichnen. In der ersten Skizze aus Artikel 1 sah das Spielbrett so aus:

![image-20221109205551362](ConceptFirstIdea.png)

Das war nur eine erste Skizze. Für das Programm müssen wir genauer überlegen, wie sich das Spielbrett zeichnen lässt. Es wäre keine gute Idee sofort mit dem Programmieren loszulegen und über Try and Error zu einer Lösung zu kommen. Wir kommen viel besser zum Ziel, wenn wir uns vor dem Programmieren einen Plan machen. Wir brauchen ein **Konzept**. Auf jeden Fall benötigen wir für das Spielbrett Rhomben-förmige Gebilde (eins davon habe ich oben im Bild grau gekennzeichnet). Wie groß müssen diese Rhomben sein und wo genau müssen sie platziert werden? Dazu muss man etwas auf dem Papier herumprobieren und überlegen. Am Ende stellt sich heraus, dass folgende Größe gut funktioniert:

![image-20221109212931926](ConceptFinalIdea.png)

Der Rhombus ist hier genauso breit wie die Spielmarke (rot markiert) und die Seiten des Rhombus sind so lang sein wie die Breite der Spielmarke. Der Abstand zwischen Rhomben in der gleichen Zeile ist damit auch klar. Die Höhe des Rhombus (grün markiert) kann man mit etwas Mathematik ausrechnen. Wenn eine Zeile fertig gezeichnet ist, liegen die Rhomben der nächsten Zeile eine Rhombus-Höhe tiefer und sind um eine Rhombus-Breite versetzt. Den Rand des Spielfelds können wir mit halben Rhomben begrenzen (dunkelgrau markiert). 

Die obige Skizze ist nicht ganz perfekt, aber als Konzept reicht uns das. Wir haben alle Informationen, die wir für das Zeichnen des Spielbretts benötigen. Am Ende wird es vom Programm gezeichnet so aussehen:

![image-20221109215810393](ConceptInProgram.png)



```csharp

```



### Konzept für das Koordinatensystem 

Man kann die Objekte auf dem Spielbrett aus zwei Perspektive betrachten. Zum *Zeichnen der Objekte* müssen die genauen Bildschirmkoordinaten, Breiten und Größen der Objekte bekannt sein. Für das *Spielen mit den Objekten* ist das aber nicht relevant. Da würde man eher von Zeilen, Spalten und Slots sprechen. Und man würde diese mit Buchstaben oder Zahlen kennzeichnen. Es gibt also zwei Belange mit unterschiedlichen Koordinatensystemen. Welches dieser beiden Koordinatensysteme verwenden wir als Grundlage? Ich habe mich für das Spieler-Koordinatensystem entschieden. Als Kennzeichen für eine spezielle Zeilen, Spalte oder Slot verwende ich Zahlen. Und die Zählung beginne ich innerhalb des Programms mit 0. Das folgende Bild veranschaulicht das:

![image-20221221223517229](CoorSystemConcept.png)

Ich habe ein bisschen Zeit für dieses Konzept benötigt. In diesem Konzept stecken viele Entscheidungen, die ich auch anders hätte treffen können. Ich hätte die columns beispielsweise doppelt so dicht machen können. Das hätte vielleicht den Vorteil, dass man für slots und columns die gleichen Koordinaten verwenden kann. Die Zählung könnte mit 1 anstelle von 0 beginnen. Usw. Am Ende hatte ich bei diesem Konzept das Gefühl, dass der Code so relativ einfach wird. 



### Kurze Zusammenfassung

* Man benötigt kein großes Konzept für alles von 0 bis zum fertigen Programm, aber man braucht immer mal wieder ein *Konzept* für die nächsten Schritte. Ein Konzept muss keine große Dokument mit Schaubildern und viel Text sein, es reicht aus eine klare Vorstellung zu haben, wie wir weiter vorgehen wollen. Aber es lohnt sich, etwas länger über alternative Lösungen und das Konzept nachdenken. Mit einem schlechten Konzept verliert man am Ende Zeit, weil man öfter Dinge verwerfen und von vorne anfangen muss.
* 

### Übung

Wir haben ein Konzept, mit dem wir jetzt hier weitermachen werden. Das ist gut. Aber es gibt immer mehr als eine Möglichkeit. Muss das Spielbrett rechteckig sein? Muss man die Tokens von oben "einwerfen"? Müssen die Tokens sechseckig sein? Kann man die Rhomben kleiner oder größer machen? Müssen es Rhomben sein oder sind auch andere Formen sinnvoll? Wie würde dein Konzept aussehen?

[hexafour-01]: {% post_url 2023-07-01-hexafour-01-overview %}

[hexafour-02]: {% post_url 2023-07-02-hexafour-02-first-program %}

[hexafour-03]: {% post_url 2023-07-14-hexafour-03-draw-a-hexagon %}

[hexafour-04]: {% post_url 2023-07-23-hexafour-04-debugging %}

[hexafour-05]: {% post_url 2023-08-13-hexafour-05-variables-loops-dry %}

[hexafour-06]: {% post_url 2023-09-03-hexafour-06-types-conditions %}




---
layout: posts
title: Learn to fly with C#
tags: LearnToCode C# HexaFour
excerpt_separator: <!--more-->
typora-root-url: ..
---

Is it easy to build an airplane? Of course it is: I can learn to make paper airplanes very quickly. But what's the next step if I want to build a real airplane one day? For example, I can build a radio-controlled airplane.

Is it easy to develop software? Sure: I can quickly learn to write a few small console programs. But what's the next step? I have an idea.

<!--more-->

### Developing software is just as easy as building airplanes

Programming is super easy. First, I get a programming language, for example python or C#. Then I have a look at some videos and I am ready to write my first programs. It takes just a few minutes or hours. Or is programming not quite so easy after all? At Microsoft, for example, sometimes several 1,000 developers are involved in a project (see  ["Welcome to the Engineering@Microsoft Blog"](https://devblogs.microsoft.com/engineering-at-microsoft/welcome-to-the-engineering-at-microsoft-blog/)). And usually these developers have years of training behind them.

Suppose I want to learn how to build something that flies. Then it's also super simple at first. I take a piece of paper, watch a few videos, and after a few minutes I've built a paper airplane that flies. But that's only the very first step. Because, of course, there are much more complex aircraft: gliders, propeller planes, jets, passenger planes. And if you want to design such aircraft, you have to know much, much more.

So if you want to participate in the development of a real airplane, you need a lot more knowledge than for building a paper airplane. But how do you go on if you've already built a few good paper airplanes and want to learn more? You can't try to build a two-seat propeller plane next. That step would be much too big. A good option is: You build a remote controlled model airplane. Thereby you can learn a lot, which is also relevant for bigger airplanes. And if you do something wrong, nobody gets hurt - except your wallet, because you have to repair your plane.

It's similar with software development. It's easy to write a few console programs and learn some first things. But then the next step is not easy. It's very hard to write an app or game next. You then have to learn so many things at the same time that you just can't get a handle on it.  You need something that is harder than a console program but easier than a real, full-fledged game. 

My suggestion: In the following series of articles I explain how to program a small graphical computer game. The game is a bit more complicated and I explain step by step the programming language C# and some other things that are important in software development. I'll try this approach in the following articles of this blog: I'll explain how to program a small graphical computer game. This will not be an app to publish yet, that would be too difficult to start. But the game is already a bit complex, so this way I can explain step by step C# and some other tools and concepts that are important in software development.

So I'm doing something similar here for software development as an RC aircraft for airplane design

![image-20230628204937752](/assets/images/hexafour/AircraftSoftwareDev.png)

### Game idea

First of all, I only have a rough idea for the game I want to program: Two people should be able to play it. Players can take turns dropping hexagonal tiles from the top into a game board. A tile drops down until it hits an anchor position. There are two possibilities:

![image-20230701191857281](/assets/images/hexafour/GameIdeaAnchors.png)

If the anchor position is free (case a), the token remains on the anchor position. If the anchor position is occupied by another token (case b), the other token moves on and the token coming from above takes the anchor position.

The winner is the player who first has four of his tokens in a horizontal or diagonal line. In this example, blue has won on the next move:

![image-20230701193340443](/assets/images/hexafour/GameIdeaBlueWillWin.png)

The sequence of the next move of blue is marked with blue arrows. The new token thrown in will move the blue token below it. This token will move down one position diagonally and then form a row of four with three other tokens. Thus blue has won.

I already have a name for the game: **HexaFour**. "Hexa" because the tiles are hexagons and "Four" because you need four in a row to win.

Besides the name and the rough idea of the game, many things are still unclear. But it is not worth to make a concept for everything and only then to start programming. You can make much better progress (and have more fun) if you implement the first things quickly, then try them out and think about how best to proceed from there. In real software projects, this is often done in the same way; it's called agile software development.

### Tools

I use the **programming language C#** here. C# is perhaps a little bit more difficult for beginners than python, for example. However, when the programs get bigger, I think C# is an optimal way to go. There are many commercial programs that are developed with C#.

For real games, you actually need a **gaming engine** - we could use Unity, for example. But then, as a beginner, you have to learn a lot of things at the same time: the C# programming language, tools for that programming language, the gaming engine, tools for the gaming engine, and so on. That's a lot for the beginning.  Therefore I start here without a gaming engine and use the **graphics library Woopec** instead. I'm not completely impartial there, because I developed [Woopec](https://frank.woopec.net/woopec_docs/WoopecIntro.html) myself :-)

The game in this course won't look as cool as a Unity game, but for that you can get started here with very little prerequisites. You'll first learn how to develop software with C# and then you can move on to Unity for the next game. C# is also used as the programming language in Unity, so you'll learn a lot here that you'll also need later in Unity.

For software development, you need to know more than just a programming language and tools. When a program gets bigger, other things become more important. The first version of a program is quickly assembled. You nail a few boards together and you have a house with a roof where you can sit dry. But then the house needs more rooms and additional floors. Then the house is to be expanded into a small city. You need more houses, then streets, then bigger streets, a hospital, a theater, an airport, ... At some point you reach a point where this can get very complicated. At a certain size you lose the overview if the whole thing is not well organized and structured. That's why, as we develop our program here, I'm also going to pay more and more attention to making sure that the program is well organized and structured. In his book "Clean Code. A Handbook of Agile Software Craftsmanship" Robert C. Martin calls this **clean code**:

> [...] writing clean code ist a lot like painting a picture [...] a programmer who writes clean code is an artist who can take a blank screen throug a series of transformations until it is an elegantly coded system.

Let's see how well we will succeed in writing clean code here.

There is one point I must make at the end: While I will explain many things here, the following blog posts are **most definitely not a complete introduction** to C#, programming practices, or clean code.  Many others have already done that much better than I ever can do. I only explain a few necessary or interesting things here and give you links to more detailed information. Based on this, you can search for the websites, videos or books that best fit your needs.

### Overview of the posts in this series

The following list contains the posts of this series published so far.

**Chronological overview**:

* 01 - 
* 02 - 

If you are looking for specific topics, these lists can help you:

**C#**:

* Method, parameter, statement: 02

**Visual Studio**:

* Installation, debugger start, debugger stop: 02

**Woopec graphics library**:

* Create a new Woopec project: 02
* First turtle commands: 02

**Clean Code**:

* Meaning: 01

**HexaFour game**

* Game idea: 01
* 


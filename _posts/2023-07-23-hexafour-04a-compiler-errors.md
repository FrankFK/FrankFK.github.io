---
layout: posts
title: Why is this simple C# Program not working? Fixing Compiler Errors (h4-04)
tags: LearnToCode C# HexaFour
excerpt_separator: <!--more-->
typora-root-url: ..
---
![Image with Visual Studio compiler errors: CS1002 ; expected. CS1003 , expected. CS1022 Type or namespace definition, or end-of-file expected. CS7036 There is no argument given that corresponds to the required parameter. And more.](/assets/images/hexafour/CompilerErrors.png)

You have written your first C# program and it compiles with errors? This is quite normal in the beginning. Don't let that stop you from learning C#. Here I explain some of the most common errors and how to fix them. 

<!--more-->

### CS1002 ; expected

Let's start with an example:

```csharp
internal class Program{static void Main(string[] args){Console.WriteLine("Hello World")}}
```

The C# compiler has a problem with this program, it expects a semicolon somewhere. That is why it issues the error message "CS1002 ; expected". In the code example above, I intentionally wrote everything on one line, because that is more like how the compiler sees your program code. You would write the above program more like this:

```csharp
internal class Program
{
    static void Main(string[] args)
    {
        Console.WriteLine("Hello World")
    }
}
```

From the compiler's perspective, this version of the program is just like the first one. The C# compiler does not care about spaces, indentations or line breaks in your program. That is why it needs a sign by which it can determine that a statement has come to an end. And this sign is the semicolon. Each statement must be terminated with it, otherwise the compiler will not recognize it. So you have to add a semicolon after the statement that prints "Hello World".

Visual Studio does a lot to help you fix such errors:

![Screenshot of Visual Studio with Error List, squiggled error and Quick Actions](/assets/images/hexafour/VSErrorHelp.png)

(1) The error is displayed in the **Error List**. (2) If you click on the link [CS1002](https://learn.microsoft.com/en-us/dotnet/csharp/misc/cs1002?f1url=%3FappId%3Droslyn%26k%3Dk(CS1002)), you will see a description of the error. (3) In the editor, at the end of line 5, the error location is marked with a red squiggle. And (4) the light bulb at the beginning of line 5 offers you Quick Actions to fix the error. These Quick Actions don't help with this particular error, but the other offerings should help with this type of error.

### Brackets that do not match

C# uses different types of parentheses to indicate the beginning and end of something:

* Curly braces `{` and `}`mark the beginning and end of a code block.
* Square brackets `[`and `]`mark the beginning and end of list-like things.
* Round brackets `(` and `)` enclose the parameters of methods.

If there is a bracket in a file without a matching partner, then the C# compiler also has a problem. If a *closing* bracket is missing, we usually get appropriate error messages:

* CS1513 } expected
* CS2026 ) expected
* CS1003 ] expected

The cause of such errors is relatively easy to find if your program is small. But it becomes more difficult if the program has many lines. The compiler only knows *that* a bracket is missing, but not *where* it is missing. That is why it displays the error in this example like this:

![Screenshot of Visual Studio with missing closing brace and Error List Window showing: "error CS1513 } expected"](/assets/images/hexafour/VSErrorMissingClosingBrace.png)

The error is displayed at the very end of the file. But how do you find the place where the bracket is really missing? There are options here as well: For one thing, you can put the cursor behind the last bracket. Then Visual Studio displays this bracket with a gray background, and it displays the **corresponding opening bracket** also with a gray background. In the example above, this is the bracket in line 4. This doesn't fit properly, and you can see that line 6 is missing a closing parenthesis. On the other hand, you can also make the cursor **jump to the corresponding opening parenthesis**. For this you use the keyboard shortcut **Ctrl+]**.

### If the faulty spot is difficult to find

If your program is missing an *opening* parenthesis, the C# compiler has more trouble giving you a good error message. Because the opening bracket is missing, the compiler does not understand the code behind it correctly and displays many error messages:

![Screenshot of Visual Studio with code missing an opening brace. Error List shows many errors.](/assets/images/hexafour/VSErrorMissingOpeningBrace.png)

Fortunately, it is not so common that an opening bracket is missing. But in such cases it is more difficult to find the error. In this example an opening parenthesis is missing in line 4. This has generated 10 compiler errors! And the first error is printed one line in front of the real error! The only thing that helps here is to stay calm and try to narrow down the location where the error is likely to be. If you can't find the error at all, you can try to make your program smaller. You don't have to delete any lines of the program for that, you can comment them out. A **comment** is a part of your code that the compiler does not even consider. Normally you use this to comment for others how the code is intended. You can find a description of comments in [Microsoft Learn](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/tokens/comments). Here I put a part of the program in a comment, and after that there are no more errors. That's why the cause of the error must be in the commented out part of the program:

![Screenshot of Visusal Studio with code commented out. A way to find the cause of a compiler error.](/assets/images/hexafour/VSErrorSearchWithComments.png)

Next, I commented out a smaller part. Now there are errors again. So the error must be somewhere in line 3, 4 or 6:

![Screenshot of Visusal Studio with less code commented out. A way to find the narrow down the compiler error.](/assets/images/hexafour/VSErrorSearchWithComments2.png)

Normally, you find the error this way. If not, you can try **rewriting the code in small bites**: Start with a version that is compiled without errors. Then gradually add small pieces and check the code again by compiling it. Eventually, you will reach the incorrect location, or you will have automatically written the code correctly.

### Sometimes you can fix errors with Visual Studio Quick Actions

In the following example, I have modified the program from the [last post][hexafour-03] so that it has an error in line 5. The compiler does not know the name "Turtle". If you place the cursor in the faulty line, a small light bulb is displayed at the beginning of the line, showing so-called Quick Actions:

![Screenshot of Visual Studio with a Quick Action. The Quick Action has four suggestions. The first one is 'using Woopec.Core'.](/assets/images/hexafour/VSQuickActionsAddUsing.png)

Four different Quick Actions are suggested here. The first one is exactly what is missing here: A `using Woopec.Core;` statement must be added at the top of the file. You can correct this directly with the Quick Action. When fixing compiler errors, you have to be a little careful with the Quick Actions. The other three suggestions in this example would not have helped at all. Often there is nothing that helps at all. But sometimes the right suggestion is there.

### By the way: Visual Studio keyboard shortcuts

These were a few tips for fixing compiler errors. Before I give a few tips on debugging, I would also like to briefly mention the Visual Studio Keyboard Shortcuts. I have already mentioned the shortcut *Ctrl+]* above, with which you can jump back and forth between corresponding brackets. This is just the tip of the iceberg. Visual Studio's text editor has over 100 shortcuts. You can find the complete list [here](https://learn.microsoft.com/en-us/visualstudio/ide/default-keyboard-shortcuts-in-visual-studio?view=vs-2022#bkmk_text-editor-context-specific-shortcuts).

### Watch the program at work: The debugger

Your program no longer has compiler errors, but when you run it, it doesn't do the right thing. Then the best thing to do is to use the Visual Studio debugger to find out what is wrong. I will describe this in detail in the next [post][hexafour-04b].

### TL;DR

This post is part of a series. You can find the previous post [here][hexafour-03] and an overview [here][hexafour-overview].

Compiler errors:
* The compiler does not see spaces, indentations or line breaks. It needs semicolons and matching brackets to understand the code correctly. Finding errors is helped by the *Error-List Window*, *Quick Actions*, *commenting out* code, and the *[keyboard shortcut](https://learn.microsoft.com/en-us/visualstudio/ide/default-keyboard-shortcuts-in-visual-studio?view=vs-2022#bkmk_text-editor-context-specific-shortcuts)* Ctrl+], you can also *rewrite the code in small pieces*.
* For more information on fixing errors, see for example [Fix program errors and improve code](https://learn.microsoft.com/en-us/visualstudio/ide/find-and-fix-code-errors?view=vs-2022) on Microsoft Lean.

Visual Studio:

* If you don't like working with the mouse, use the Visual Studio shortcuts. There are [over 100](https://learn.microsoft.com/en-us/visualstudio/ide/default-keyboard-shortcuts-in-visual-studio?view=vs-2022#bkmk_text-editor-context-specific-shortcuts) of them.

### Comment on this post ❤️

I am very interested in what readers think of this post and what ideas or questions they have. The easiest way to do this is to respond to my [anonymous survey](https://forms.office.com/r/cTw9mbVj9t).



[Woopec Docs]: https://frank.woopec.net/woopec_docs/Turtle.html

[hexafour-03]: {% post_url 2023-07-14-hexafour-03-draw-a-hexagon %}

[hexafour-04b]: {% post_url 2023-07-24-hexafour-04b-debugging %}

[hexafour-05]: {% post_url 2023-08-13-hexafour-05-variables-loops-dry %}

[hexafour-overview]: {% post_url 2023-07-01-hexafour-01-overview %}#overview-of-the-posts-in-this-series


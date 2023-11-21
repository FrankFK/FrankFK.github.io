---
layout: posts
title: Clean Code C# Coding Kata - Conway's Game of Life
tags: LearnToCode C# CodeQuality Woopec.Graphics
excerpt_separator: <!--more-->
typora-root-url: ..
---

![Screenshot of the GameOfLife program showing the 46th iteration of the "Gosper glider gun" seed configuration.](/assets/images/GameOfLife/GameOfLifeV2.png)

Conway's Game of Life is a very simple game. I'm sure I can implement it in an hour with C#. At least that's what I thought at first. But the implementation is supposed to be clean code, and I also wanted to have a graphical display. That's not so easy after all...

<!--more-->

### Starting point for this article

Last week I participated in a [Coding Retreat](https://www.coderetreat.org/the-workshop/). We met with 20 people who wanted to grow at this retreat. There were six 45 minute sessions. For each session we were split up into different teams of two. In each session, we had the task of programming the game [Conway's Game of Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life).  However, the goal was *not* to have a finished game at the end, instead the goal was to practice TDD and develop clean code.

The coding retreat was a lot of fun. I met new people, got to know people better, and learned different perspectives and approaches. 

After the event, I experimented some more. Especially concerning the graphical output and clean code. This is the result:

![Animation of the GameOfLife program](/assets/images/GameOfLife/GameOfLife.gif)

I describe the essential parts of the code in this post. The whole code can be found on [Github](https://github.com/FrankFK/GameOfLife).

### A cell of the game

The rules for Conway's Game of Life can be found on [Wikipedia](https://en.wikipedia.org/wiki/Conway's_Game_of_Life), so I won't write them here.

The class `Cell` represents a cell in the Game of Life:

```csharp
public class Cell
{
    private bool _willBeAlive;

    public bool IsAlive { get; set; }

    public void CalculateNextState(int livingNeighbors)
    {
        _willBeAlive = WillBeAlive(livingNeighbors);
    }

    public void SwitchToNextState()
    {
        IsAlive = _willBeAlive;
    }

    private bool WillBeAlive(int livingNeighbors)
    {
        // Code according to rules of Conways Game of Life
        // ...
    }
}
```

This class cares whether a cell is currently alive or not (`IsAlive`), it calculates the next state this cell will have (`CalculateNextState`), and it can change the current state accordingly (`SwitchToNextState`).

### Position of a cell

The position of a cell is determined by two coordinates. I have defined a record `CellPosition` for this purpose:

```csharp
public record CellPosition(int Row, int Column);
```

### The grid

The `Grid` class manages all cells and can determine the neighbors of a cell position:

```csharp
public class Grid
{
    private readonly Cell[,] _cells;
    private readonly int _rowCount;
    private readonly int _columnCount;

    public Grid(int rowCount, int columnCount)
    {
        // Initializes all private fields
        // ...
    }

    public Cell CellAt(CellPosition cellPosition) => _cells[cellPosition.Row, cellPosition.Column];

    public IEnumerable<CellPosition> AllCellPositions()
    {
        for (int row = 0; row < _rowCount; row++)
            for (int column = 0; column < _columnCount; column++)
                yield return new CellPosition(row, column);
    }

    public List<Cell> NeighborsOfCellAt(CellPosition cellPosition)
    {
        var neighbors = new List<Cell>();
        // Determines the maximal eight neighbors of cellPosition
        // ...
        return neighbors;
    }
}
```

### The Game

Now the game itself is missing. For this there is the `Game` class.

```csharp
public class Game
{
    private readonly Grid _grid;
    private readonly IRenderer _renderer;

    public Game(int rowCount, int columnCount, IEnumerable<CellPosition> seed, IRenderer renderer)
    {
        _grid = new Grid(rowCount, columnCount);
        foreach (var cellPosition in seed)
            _grid.CellAt(cellPosition).IsAlive = true;
        _renderer = renderer;
    }

    public void Run(int iterationCount)
    {
        ShowState();
        for (int i = 0; i < iterationCount; i++)
        {
            CalculateNextIteration();
            ShowState();
        }
    }

    private void CalculateNextIteration()
    {
        foreach (var cellPosition in _grid.AllCellPositions())
        {
            int livingNeighbors = _grid.NeighborsOfCellAt(cellPosition).Count(neighborCell => neighborCell.IsAlive);
            _grid.CellAt(cellPosition).CalculateNextState(livingNeighbors);
        }
        foreach (var cellId in _grid.AllCellPositions())
        {
            _grid.CellAt(cellId).SwitchToNextState();
        }
    }

    private void ShowState()
    {
        foreach (var cellPosition in _grid.AllCellPositions())
        {
            _renderer.SetCellState(cellPosition, _grid.CellAt(cellPosition).IsAlive);
        }
        _renderer.ShowState();
    }
}
```

The central method is the `Run` method, with which a given number of iterations is calculated and displayed. For this internally the `Grid` and the `Cell` classes are used. The display is done by an `IRenderer` interface, which was passed to the constructor.

### Display on the screen

The display of the game is done under the hood with WPF. Because using WPF directly is a bit complicated, I use my Nuget package [Woopec](https://frank.woopec.net/woopec-docs-index.html) for the display here. 

First, a new Visual Studio project type is defined via this command:

```
dotnet new --install Woopec.Templates
```

After that, you can create a new project of type "Woopec WPF Project" in Visual Studio. The implementation of the `Renderer` class is relatively simple:

```csharp
using Woopec.Core;

namespace GameOfLife
{
    internal class Renderer : IRenderer
    {
        private readonly Figure[,] _cells;

        public Renderer(int rowCount, int columnCount, int cellSize)
        {
            Shape shape = CreateCellShape(cellSize);
            _cells = CreateAllCells(rowCount, columnCount, cellSize, shape);
        }

        public void SetCellState(CellPosition cellId, bool isVisible)
        {
            var figure = _cells[cellId.Row, cellId.Column];
            figure.IsVisible = isVisible;
        }

        public void ShowState()
        {
            Thread.Sleep(10);
        }

        private static Shape CreateCellShape(int cellSize)
        {
            var coor = cellSize / 2.0;
            var polygon = new List<Vec2D>() { (-coor, -coor), (-coor, coor), (coor, coor), (coor, -coor)};
            return new Shape(polygon);
        }

        private static Figure[,] CreateAllCells(int rowCount, int columnCount, int cellSize, Shape shape)
        {
            var cells = new Figure[rowCount, columnCount];
            for (int row = 0; row < rowCount; row++)
                for (int column = 0; column < columnCount; column++)
                    cells[row, column] = CreateFigureAt(row, column, rowCount, columnCount, cellSize, shape);
            return cells;
        }

        private static Figure CreateFigureAt(int row, int column, int rowCount, int columnCount, int cellSize, Shape shape)
        {
            var figure = new Figure() { Shape = shape, Color = Colors.Blue };
            figure.SetPosition((column - columnCount / 2) * cellSize, (rowCount / 2 - row) * cellSize);
            return figure;
        }
    }
}
```

First, a Woopec shape representing a suitably sized square is created (method `CreateCellShape`). Then, for each cell, a Woopec figure with this shape is placed at the appropriate screen position (method `CreateAllCells`). These Woopec figures can be made visible or invisible. Initially they are not visible. Method `SetCellState` is used to make a single cell visible or invisible on the screen. The method `ShowState` makes a small pause, so that the user can look at the current state after an iteration of the game.

### Main-Method

Method `WoopecMain` in `Program.cs` puts all parts together and starts the game:

```csharp
using GameOfLife;
using Woopec.Core;

internal class Program
{
    public static void WoopecMain()
    {
        int rowCount = 120;
        int columnCount = 120;
        var renderer = new Renderer(rowCount, columnCount, 6);
        string gosperGilderGun = @"
        .........................X
        .......................X.X
        .............XX......XX............XX
        ............X...X....XX............XX
        .XX........X.....X...XX
        .XX........X...X.XX....X.X
        ...........X.....X.......X
        ............X...X........
        .............XX.";
        var seed = AliveCellPositionsOfSeed(gosperGilderGun);
        var game = new Game(rowCount, columnCount, seed, renderer);
        game.Run(iterationCount: 1000);
        Screen.Default.Bye();   
    }

    private static IEnumerable<CellPosition> AliveCellPositionsOfSeed(string seedString)
    {
        // Converts a string into a list of all CellPositions of living cells
        // ...
    }
}
```

### And cut

Although this Game of Life Kata looks so simple at first, you can spend a lot of time on it. Actually, at the beginning of this post, I thought that the code was good and done. But even while writing this post, I still changed a few things. And even now I still notice parts of the code that could be changed. For example, I could change the `IRenderer` interface to have only one method (instead of two) with a parameter that contains all visible cells of the next iteration. This would have advantages and disadvantages... 

But at some point you have to say: I have done and learned enough for today. That's why I leave it at that. I think I practiced a few things and did them well. There is always room for improvement. But this is (for now) good enough for me.

### Comment on this post ❤️

I am very interested in what readers think of this post and what ideas or questions they have. The easiest way to do this is to respond to my [anonymous survey](https://forms.office.com/r/dr995EatLQ).


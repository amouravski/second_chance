import '../lib/second_chance.dart';
import 'package:one_hour_game_jam/one_hour_game_jam.dart';

var game1 = ['100',
             '002',
             '112'];

var game2 = ['1400',
             '0020',
             '1120',
             '3000'];

main() {
  var myGame = game2;
  mazeGrid = _createMazeGrid(myGame);
}

Grid mazeGrid;
bool get isWon => checkForWin(mazeGrid);
bool get isLose => checkForLose(mazeGrid);

Point playerPoint;


/** 
 * Creates a simple maze grid given a list of strings encoding the rows.
 * 
 * 0 is free
 * 1 is wall
 * 2 is trap
 * 3 is start
 * 4 is finish
 * 
 * For example:
 *     [101, 001, 222]
 * creates a grid like:
 *     1 0 1
 *     0 0 1
 *     2 2 2
 */    
Grid _createMazeGrid(List<String> grid) {
  var out = new Grid.empty();
  for (int y = 0; y < grid.length; y++) {
    var row = grid[y];
    var gridRow = [];
    for (int x = 0; x < row.length; x++) {
      switch (row[x]) {
        case '0':
          gridRow.add(new MazeCell(x, y));
          break;
        case '1':
          gridRow.add(new MazeCell.wall(x, y));
          break;
        case '2':
          gridRow.add(new MazeCell.trap(x, y));
          break;
        case '3':
          gridRow.add(new MazeCell.start(x, y));
          playerPoint = new Point(x, y);
          break;
        case '4':
          gridRow.add(new MazeCell.goal(x, y));
          break;
      }
    }
    out.addRow(gridRow);
  }
  return out;
}

right() {
  var x = playerPoint.x;
  var y = playerPoint.y;
  if (!checkMove(x+1, y)) return;
  mazeGrid[x][y].isPlayer = false;
  mazeGrid[x+1][y].isPlayer = true;
  playerPoint = new Point(x + 1, y);
}

left() {
  var x = playerPoint.x;
  var y = playerPoint.y;
  if (!checkMove(x-1, y)) return;
  mazeGrid[x][y].isPlayer = false;
  mazeGrid[x-1][y].isPlayer = true;
  playerPoint = new Point(x - 1, y);
}

up() {
  var x = playerPoint.x;
  var y = playerPoint.y;
  if (!checkMove(x, y - 1)) return;
  mazeGrid[x][y].isPlayer = false;
  mazeGrid[x][y - 1].isPlayer = true;
  playerPoint = new Point(x, y - 1);
}

down() {
  var x = playerPoint.x;
  var y = playerPoint.y;
  if (!checkMove(x, y + 1)) return;
  mazeGrid[x][y].isPlayer = false;
  mazeGrid[x][y + 1].isPlayer = true;
  playerPoint = new Point(x, y + 1);
}

//lightClick(LightCell cell, Grid grid) {
//  var neighbors = []..addAll(grid.neighborsAsList(cell));
//  var lookedAt = []..add(cell);
//  var out = []..add(cell);
//  for (LightCell n in neighbors) {
//    if (lookedAt.contains(n)) {
//      continue;
//    }
//    
//    lookedAt.add(n);
//
//    if (!out.contains(n)) {
//      out.add(n);
//    }
//    
//    if (n.color == cell.color) {
//
//      for (LightCell p in grid.neighborsAsList(n)) {
//        
//        if (!out.contains(p)) {
//          out.add(p);
//        }
//      }
//      neighbors.addAll(grid.neighborsAsList(n));
//    }
//  }
//  
//  
//  for (LightCell n in out) {
//    n.flip();
//  }
//  
//  isWon = checkForWin(grid);
//}

checkForWin(Grid grid) {
  for (List<MazeCell> row in grid) {
    for (MazeCell cell in row) {
      if (cell.isPlayer && cell.isGoal) {
        return true;
      }
    }
  }
  
  return false;
}

checkForLose(Grid grid) {
  for (List<MazeCell> row in grid) {
    for (MazeCell cell in row) {
      if (cell.isPlayer && cell.data is Trap) {
        return true;
      }
    }
  }
  
  return false;
}

bool checkMove(x, y) {
  return _isValid(x, y);
}

bool _isValid(int x, int y) {
  return x >= 0 && y >= 0 &&
      x < mazeGrid.width && y < mazeGrid.height &&
      mazeGrid[x][y].isValid() && !(mazeGrid[x][y].data is Wall);
}

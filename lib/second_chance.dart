library second_chance;

import 'package:one_hour_game_jam/one_hour_game_jam.dart';

class MazeCell extends Cell {
  MazeObject data = new MazeObject();
  bool isGoal = false;
  bool isStart = false;
  bool isPlayer = false;
  
  String get color {
    if (isGoal && !(isPlayer)) return 'yellow';
    if (isPlayer) return 'green';
    return data.color;
  }
  
  String get text {
    if (isPlayer) return warn;
    else return '';
  }
  
  String get warn { 
  }
  
  MazeCell(x, y):
    super(x, y);
  
  MazeCell.start(x, y):
    this.isStart = true,
    this.isPlayer = true,
    super(x, y);
  
  MazeCell.goal(x, y):
    this.isGoal = true,
    super(x, y);
  
  MazeCell.trap(x, y):
    this.data = new Trap(),
    super(x, y);
  
  MazeCell.wall(x, y):
    this.data = new Wall(),
    super(x, y);
}

class MazeObject {
  String color;
  factory MazeObject() {
    return new Floor();
  }
}

class Floor implements MazeObject {
  String color = 'gray';
  Floor();
}

class Wall implements MazeObject {
  String color = 'black';
  Wall();
}

class Trap implements MazeObject {
  String color = 'red';
  Trap();
}
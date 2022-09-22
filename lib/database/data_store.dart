import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  // create an instance of database list
  List toDoList = [
    ["Welcome ", false]
  ];

  // reference our box
  final _myBox = Hive.box("BOX");

  // crete initial data if opened first time
  void createInitialData() {
    List toDoList = [
      ["Radhe Radhe 🪶", false],
      ["Welcome ", true]
    ];
  }

  // load the data from database
  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  // update the database
  void updateData() {
    _myBox.put("TODOLIST", toDoList);
  }
}

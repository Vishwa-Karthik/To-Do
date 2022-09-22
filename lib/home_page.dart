import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_application/database/data_store.dart';
import 'package:to_do_application/pages/to_do_tile.dart';

import 'pages/utils/dialog_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the container box
  final _myBox = Hive.box("BOX");

  // create db isntance from data store model
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    // if first time opening app then create default app
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // already exist data
      db.loadData();
    }
    super.initState();
  }

  // text editing controller for adding new task
  final _controller = TextEditingController();

  // checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateData();
  }

  // create new task
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: SaveNewTask,
            onCancel: () => Navigator.pop(context),
          );
        });
    db.updateData();
  }

  // Append newly added Task
  void SaveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.pop(context);
    db.updateData();
  }

  // Delete the task in the list
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.deepPurple.shade800.withOpacity(0.8),
            Colors.deepPurple.shade200.withOpacity(0.8),
          ],
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 15,
            backgroundColor: Colors.transparent,
            title: Text(
              "TO-DO  APP",
              style: GoogleFonts.josefinSans(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 27,
                  color: Colors.white,
                ),
              ),
            ),
            centerTitle: true,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: createNewTask,
            child: const Icon(Icons.add),
          ),
          body: ListView.builder(
            itemCount: db.toDoList.length,
            itemBuilder: ((context, index) {
              return ToDoTile(
                taskName: db.toDoList[index][0],
                taskStatus: db.toDoList[index][1],
                onchanged: (value) => checkBoxChanged(value, index),
                deleteFunction: (context) => deleteTask(index),
              );
            }),
          )),
    );
  }
}

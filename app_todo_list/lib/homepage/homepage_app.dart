import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:app_todo_list/data/data.dart';
import 'package:app_todo_list/utills/todo_app.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _mybox = Hive.box("myBox");

  @override
  void initState() {
    if (_mybox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  ToDoDatabase db = ToDoDatabase();

  final _controller = TextEditingController();

  void checkBoxChanged(int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateData();
  }

  void saveNewTask() {
    setState(() {
      _controller.text.isNotEmpty
          ? db.toDoList.add([_controller.text, false])
          : HomePage();
      _controller.clear();
    });
    db.updateData();
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("TODO BY AARTHI")),
        backgroundColor: const Color.fromARGB(255, 125, 83, 238),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: db.toDoList.length,
            itemBuilder: (BuildContext context, index) {
              return TodoList(
                taskName: db.toDoList[index][0],
                taskComplted: db.toDoList[index][1],
                onChanged: (value) => checkBoxChanged(index),
                deleteFunction: (contex) => deleteTask(index),
              );
            }),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                      hintText: 'Add new TODO items.',
                      filled: true,
                      fillColor: Colors.deepPurpleAccent.shade100,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.lightBlue),
                          borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.deepPurple.shade100),
                          borderRadius: BorderRadius.circular(12))),
                ),
              ),
            ),
            FloatingActionButton(
              onPressed: saveNewTask,
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}

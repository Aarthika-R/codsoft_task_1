import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
//import 'package:todo_list_app/data/database.dart';

class TodoList extends StatelessWidget {
  const TodoList(
      {super.key,
      required this.taskName,
      required this.taskComplted,
      required this.onChanged,
      required this.deleteFunction});

  final String taskName;
  final bool taskComplted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Slidable(
        endActionPane:
            ActionPane(extentRatio: 0.3, motion: StretchMotion(), children: [
          SlidableAction(
            onPressed: deleteFunction,
            icon: Icons.delete,
            borderRadius: BorderRadius.circular(30),
            backgroundColor: Colors.deepPurple.shade100,
          )
        ]),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.deepPurple.shade300,
              borderRadius: BorderRadius.circular(30)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: taskComplted,
                  onChanged: onChanged,
                  checkColor: Colors.black,
                  activeColor: Colors.white,
                  side: BorderSide(color: Colors.white),
                ),
                Expanded(
                  child: Text(
                    taskName,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        decoration: taskComplted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        decorationColor: Colors.deepPurple,
                        decorationThickness: 2),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

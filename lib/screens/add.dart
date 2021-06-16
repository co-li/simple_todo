import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_todo/models/todoitem.dart';
import 'package:simple_todo/models/todolist.dart';

class AddToDo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add To Do'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: TextField(
          enabled: true,
          onSubmitted: (String value) {
            var toDoList = context.read<ToDoListModel>();
            toDoList.add(ToDoItem(description: value, finished: false));
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

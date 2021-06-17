import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_todo/models/todoitem.dart';
import 'package:simple_todo/models/todolist.dart';

class ToDoList extends StatelessWidget {

  Widget _buildToDoList(List<ToDoItem> toDoList) {
    return ListView.separated(
      itemCount: toDoList.length,
      itemBuilder: (BuildContext context, int index) {
        var toDoItem = toDoList[index];
        return CheckboxListTile(
          title: Text(toDoItem.description),
          value: toDoItem.finished,
          controlAffinity: ListTileControlAffinity.leading,
          onChanged: (bool? value) {
            toDoItem.finished = !toDoItem.finished;
            var toDoList = context.read<ToDoListModel>();
            toDoList.updateItem(index, toDoItem);
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("To Do List"),
        actions: [
          IconButton(
              onPressed: () => Navigator.pushNamed(context, '/edit'),
              icon: Icon(Icons.edit)),
        ],
      ),
      body: _buildToDoList(context.watch<ToDoListModel>().toDoList),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add'),
        tooltip: "Add To Do",
        child: Icon(Icons.add),
      ),
    );
  }
}

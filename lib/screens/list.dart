import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_todo/models/todolist.dart';

class ToDoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var toDoList = context.watch<ToDoListModel>();

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
      body: ListView.separated(
        itemCount: toDoList.length(),
        itemBuilder: (BuildContext context, int index) {
          return _ToDoItem(index);
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add'),
        tooltip: "Add To Do",
        child: Icon(Icons.add),
      ),
    );
  }
}

class _ToDoItem extends StatelessWidget {
  final int index;

  const _ToDoItem(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var toDoItem = context.watch<ToDoListModel>().getByIndex(index);

    return ListTile(
      title: Text(toDoItem.description),
      // value: toDoItem.finished,
      // controlAffinity: ListTileControlAffinity.leading,
      // onChanged: (bool? value) {
      //   toDoItem.toggle();
      // },
    );
  }
}

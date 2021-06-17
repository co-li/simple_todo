import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_todo/models/todoitem.dart';
import 'package:simple_todo/models/todolist.dart';

class ToDoEditor extends StatefulWidget {
  final List<ToDoItem> toDoList;

  ToDoEditor({Key? key, required this.toDoList}) : super(key: key);

  @override
  _ToDoEditorState createState() => _ToDoEditorState();
}

class _ToDoEditorState extends State<ToDoEditor> {
  var _toDoList;

  @override
  initState() {
    super.initState();
    _toDoList = widget.toDoList;
  }

  @override
  dispose() {
    _toDoList = null;
    super.dispose();
  }

  Widget _buildItemEditor() {
    return ReorderableListView.builder(
      itemCount: _toDoList.length,
      itemBuilder: (BuildContext context, int index) {
        var _toDoItem = _toDoList[index];

        var _editingController = new TextEditingController.fromValue(
          TextEditingValue(
              text: _toDoItem.description,
              selection: TextSelection.fromPosition(
                TextPosition(offset: _toDoItem.description.length),
              )),
        );

        return Dismissible(
          key: ValueKey(_toDoItem),
          background: Container(color: Colors.red),
          child: ListTile(
            title: TextField(
              controller: _editingController,
              onSubmitted: (String value) {
                _toDoItem.description = value;
              },
            ),
            trailing: Icon(Icons.drag_handle),
          ),
          onDismissed: (direction) {
            _toDoList.remove(_toDoItem);
          },
        );
      },
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final ToDoItem toDoItem = _toDoList.removeAt(oldIndex);
          _toDoList.insert(newIndex, toDoItem);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit To Do'),
        actions: [
          IconButton(
              onPressed: () {
                var toDoList = context.read<ToDoListModel>();
                toDoList.update(_toDoList);
                Navigator.pop(context);
              },
              icon: Icon(Icons.check)),
        ],
      ),
      body: _buildItemEditor(),
    );
  }
}

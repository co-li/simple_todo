import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple ToDo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: ToDo(title: 'To Do List'),
    );
  }
}

class ToDo extends StatefulWidget {
  ToDo({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _ToDoState createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  final _toDoList = <ToDoItem>[];

  Widget _buildToDoList() {
    final toDoTiles = _toDoList.map(
      (ToDoItem toDoItem) {
        return CheckboxListTile(
          title: Text(toDoItem.description),
          value: toDoItem.finished,
          onChanged: (bool? value) {
            setState(() {
              toDoItem.finished = !toDoItem.finished;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        );
      },
    );
    final toDoListView = toDoTiles.isNotEmpty
        ? ListTile.divideTiles(context: context, tiles: toDoTiles).toList()
        : <Widget>[];

    return ListView(children: toDoListView);
  }

  void _addToDo() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Add To Do'),
          ),
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              enabled: true,
              onSubmitted: (String value) {
                setState(() {
                  _toDoList.add(ToDoItem(description: value, finished: false));
                  Navigator.of(context).pop();
                });
              },
            ),
          ),
        );
      }),
    );
  }

  void _editToDo() {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(
          builder: (BuildContext context) => ToDoEditor(toDoList: _toDoList),
        ))
        .then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: [
          IconButton(onPressed: _editToDo, icon: Icon(Icons.edit)),
        ],
      ),
      body: _buildToDoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _addToDo,
        tooltip: 'Add Task',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class ToDoEditor extends StatefulWidget {
  final List<ToDoItem> toDoList;

  ToDoEditor({Key? key, required this.toDoList}) : super(key: key);


  @override
  _ToDoEditorState createState() => _ToDoEditorState();
}

class _ToDoEditorState extends State<ToDoEditor> {
  var _toDoList;

  Widget _buildToDoEditor() {
    return ReorderableListView.builder(
      itemCount: _toDoList.length,
      itemBuilder: (context, index) {
        final toDoItem = _toDoList[index];
        return Dismissible(
          key: ValueKey(toDoItem),
          onDismissed: (direction) {
            setState(() {
              _toDoList.removeAt(index);
            });
          },
          background: Container(color: Colors.red),
          child: ListTile(
            title: TextField(
              controller: toDoItem.editor,
            ),
            trailing: Icon(Icons.drag_handle),
          ),
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

  void _updateToDo() {
    setState(() {
      _toDoList.forEach((ToDoItem toDoItem) {
        toDoItem.description = toDoItem.editor.text;
      });
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    _toDoList = widget.toDoList;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit To Do'),
        actions: [
          IconButton(onPressed: _updateToDo, icon: Icon(Icons.check)),
        ],
      ),
      body: _buildToDoEditor(),
    );
  }
}

class ToDoItem {
  String description;
  bool finished;
  TextEditingController editor;

  ToDoItem({required this.description, required this.finished})
      : editor = new TextEditingController.fromValue(
          TextEditingValue(
            text: description,
            selection: TextSelection.fromPosition(
              TextPosition(offset: description.length),
            ),
          ),
        );
}

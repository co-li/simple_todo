import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_todo/models/todolist.dart';
import 'package:simple_todo/screens/add.dart';
import 'package:simple_todo/screens/edit.dart';
import 'package:simple_todo/screens/list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ToDoListModel(),
        child: MaterialApp(
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
          initialRoute: '/',
          routes: {
            '/': (context) => ToDoList(),
            '/add': (context) => AddToDo(),
            '/edit': (context) => ToDoEditor(toDoList: context.read<ToDoListModel>().toDoList),
          },
        ));
  }
}
import 'package:flutter/material.dart';

class EditToDo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit To Do'),
        actions: [
          IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.check)),
        ],
      ),
    );
  }
}

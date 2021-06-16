import 'package:flutter/foundation.dart';
import 'package:simple_todo/models/todoitem.dart';

class ToDoListModel extends ChangeNotifier {
  final List<ToDoItem> _toDoList = [];

  List<ToDoItem> get toDoList => _toDoList;

  ToDoItem getByIndex(int index) {
    return _toDoList[index];
  }

  int length() {
    return _toDoList.length;
  }

  void add(ToDoItem toDoItem) {
    _toDoList.add(toDoItem);
    notifyListeners();
  }

  void remove(ToDoItem toDoItem) {
    _toDoList.remove(toDoItem);
    notifyListeners();
  }
}
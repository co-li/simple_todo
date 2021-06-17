import 'package:flutter/foundation.dart';
import 'package:simple_todo/models/todoitem.dart';

class ToDoListModel extends ChangeNotifier {
  late List<ToDoItem> _toDoList = [];

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

  void update(List<ToDoItem> toDoList) {
    _toDoList = [];
    _toDoList.addAll(toDoList);
    notifyListeners();
  }

  void updateItem(index, ToDoItem toDoItem) {
    _toDoList.removeAt(index);
    _toDoList.insert(index, toDoItem);
    notifyListeners();
  }

  // void remove(ToDoItem toDoItem) {
  //   _toDoList.remove(toDoItem);
  //   notifyListeners();
  // }
  //
  //
  // void reorderToDo(int oldIndex, int newIndex) {
  //   if (oldIndex < newIndex) {
  //     newIndex -= 1;
  //   }
  //   final ToDoItem toDoItem = _toDoList.removeAt(oldIndex);
  //   _toDoList.insert(newIndex, toDoItem);
  //   notifyListeners();
  // }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:simple_todo/main.dart';

void main() {
  group('ToDoItem Tests', (){
    test('create a new ToDoItem', () {
      var toDoItem = ToDoItem(description: "item 1", finished: false);

      expect(toDoItem.description, "item 1");
      expect(toDoItem.finished, false);
    });
    test('change finished value of a ToDoItem', () {
      var toDoItem = ToDoItem(description: "item 1", finished: false);

      expect(toDoItem.finished, false);

      toDoItem.finished = !toDoItem.finished;
      expect(toDoItem.finished, true);
    });
    test('change description value of a ToDoItem', () {
      var toDoItem = ToDoItem(description: "item 1", finished: false);

      expect(toDoItem.description, "item 1");

      toDoItem.description = "item 2";
      expect(toDoItem.description, "item 2");
    });
  });
}
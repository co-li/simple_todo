class ToDoItem {
  String description;
  bool finished;

  ToDoItem({required this.description, required this.finished});

  void toggle() {
    finished = !finished;
  }
}
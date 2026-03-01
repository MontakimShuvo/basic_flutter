import 'package:flutter/material.dart';

class NewTaskController extends ChangeNotifier {
  final String taskName;
  final List<String> items = [];

  NewTaskController({required this.taskName});

  void addItem() {
    items.add("New item ${items.length + 1} for $taskName");
    notifyListeners();
  }
}

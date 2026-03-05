import 'package:flutter/material.dart';

class NewTaskController extends ChangeNotifier {
  final int? id;
  final String taskName;
  final List<String> items = [];

  NewTaskController({this.id, required this.taskName});

  void addItem() {
    items.add("New item ${items.length + 1} for $taskName");
    notifyListeners();
  }
}

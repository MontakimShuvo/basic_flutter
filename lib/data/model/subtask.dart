import 'package:flutter/material.dart';

class Subtask {
  int? id;
  String title;
  int isCompleted;
  TextEditingController? controller;

  Subtask({
    this.id,
    required this.title,
    this.isCompleted = 0,
    this.controller,
  });

  Map<String, dynamic> toMap(int taskId, int position) {
    return {
      'id': id,
      'task_id': taskId,
      'title': title,
      'is_completed': isCompleted,
      'position': position,
    };
  }
}
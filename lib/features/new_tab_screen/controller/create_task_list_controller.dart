
import 'package:flutter/material.dart';

class CreateTaskListController extends ChangeNotifier {
  final TextEditingController nameController;
  final int? listId;

  CreateTaskListController({this.listId, String? existingName})
      : nameController = TextEditingController(text: existingName);

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}
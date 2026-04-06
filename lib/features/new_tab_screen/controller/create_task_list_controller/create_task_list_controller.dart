import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateTaskListController extends GetxController {
  final int? listId;
  final String? existingName;

  late final TextEditingController textController;

  bool get isEditMode => listId != null;

  CreateTaskListController({this.listId, this.existingName});

  @override
  void onInit() {
    super.onInit();
    textController = TextEditingController(text: existingName);
  }

  void onBack() {
    Get.back();
  }

  void onDone() {
    if (textController.text.isNotEmpty) {
      Get.back(result: {
        'id': listId,
        'name': textController.text,
      });
    }
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}
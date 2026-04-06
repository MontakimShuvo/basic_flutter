import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/common_app_bar.dart';
import '../../../widgets/text_field/common_input_field.dart';
import '../controller/create_task_list_controller/create_task_list_controller.dart';

class CreateTaskListScreen extends GetView<CreateTaskListController> {
  const CreateTaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: controller.isEditMode ? "Rename list" : "Create New Task",
        leadingIcon: "assets/icons/Arrow - Left 2.svg",
        trailingIcon: null,
        tabsTitle: null,
        leadingIconAction: (ctx) => controller.onBack(),
        actionName: "Done",
        actionNameAction: (ctx) => controller.onDone(),
        centerTitlePos: false,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
        child: CommonInputField(
          controller: controller.textController,
          hintText: "Enter list title",
          autofocus: true,
          inputDecoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(15),
            hintText: "Enter list title",
            hintStyle: const TextStyle(
              color: Color(0xffDDDADA),
              fontSize: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.blue,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/features/new_tab_screen/controller/create_task_list_controller.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/text_field/common_input_field.dart';


class CreateTaskListTabScreen extends StatelessWidget {
  final int? listId;
  final String? existingName;

  const CreateTaskListTabScreen({
    super.key,
    this.listId,
    this.existingName,
  });

  bool get isEditMode => listId != null;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CreateTaskListController(
        listId: listId,
        existingName: existingName,
      ),
      child: Builder(
        builder: (context) {
          final controller = context.read<CreateTaskListController>();

          return Scaffold(
            appBar: CommonAppBar(
              title: isEditMode ? "Rename list" : "Create New Task",
              leadingIcon: "assets/icons/Arrow - Left 2.svg",
              trailingIcon: null,
              tabsTitle: null,
              leadingIconAction: (ctx) => Navigator.pop(ctx),
              actionName: "Done",
              actionNameAction: (ctx) {
                if (controller.nameController.text.isNotEmpty) {
                  Navigator.pop(ctx, {
                    'id': listId,
                    'name': controller.nameController.text,
                  });
                }
              },
              centerTitlePos: false,
            ),
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
              child: CommonInputField(
                controller: controller.nameController,
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
        },
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/text_field/common_input_field.dart';

class CreateTaskListTabScreen extends StatefulWidget {
  final int? listId;
  final String? existingName;

  const CreateTaskListTabScreen({
    super.key,
    this.listId,
    this.existingName,
  });

  bool get isEditMode => listId != null;

  @override
  State<CreateTaskListTabScreen> createState() => _CreateTaskListTabScreenState();
}

class _CreateTaskListTabScreenState extends State<CreateTaskListTabScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.existingName);
  }

  void _backButtonAction(BuildContext context) {
    Navigator.pop(context);
  }

  void _doneAction(BuildContext context) {
    if (_controller.text.isNotEmpty) {
      Navigator.pop(context, {
        'id': widget.listId,
        'name': _controller.text,
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: widget.isEditMode ? "Rename list" : "Create New Task",
        leadingIcon: "assets/icons/Arrow - Left 2.svg",
        trailingIcon: null,
        tabsTitle: null,
        leadingIconAction: (ctx) => _backButtonAction(ctx),
        actionName: "Done",
        actionNameAction: (ctx) => _doneAction(ctx),
        centerTitlePos: false,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
        child: CommonInputField(
          controller: _controller,
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

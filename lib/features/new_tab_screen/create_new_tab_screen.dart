import 'package:flutter/material.dart';

import '../../widgets/app_bar.dart';
import '../../widgets/text_field/input_text_field.dart';

class CreateNewTabScreen extends StatefulWidget {
  const CreateNewTabScreen({super.key});

  @override
  State<CreateNewTabScreen> createState() => _CreateNewTabScreenState();
}

class _CreateNewTabScreenState extends State<CreateNewTabScreen> {
  final TextEditingController _controller = TextEditingController();

  void _backButtonAction(BuildContext context) {
    Navigator.pop(context);
  }

  void _doneAction(BuildContext context) {
    if (_controller.text.isNotEmpty) {
      Navigator.pop(context, _controller.text);
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
      appBar: appBar(
        context: context,
        title: "Create New Task",
        leadingIcon: "assets/icons/Arrow - Left 2.svg",
        trailingIcon: null,
        tabsTitle: null,
        leadingIconAction: (ctx) => _backButtonAction(ctx),
        actionName: "Done",
        actionNameAction: (ctx) => _doneAction(ctx),
        centerTitlePos: false,
      ),
      backgroundColor: Colors.white,
      body: searchField(controller: _controller),
    );
  }
}

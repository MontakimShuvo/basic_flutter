import 'package:flutter/material.dart';

import '../widgets/app_bar.dart';
import '../widgets/input_text_field.dart';

class CreateNewTabScreen extends StatelessWidget {
  const CreateNewTabScreen({super.key});

  void _backButtonAction(BuildContext context) {
    Navigator.pop(context);
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
        addNewTask: null,
        centerTitlePos: false,
        actionName: "Done",
      ),
      backgroundColor: Colors.white,
      body: searchField(),
    );
  }
}

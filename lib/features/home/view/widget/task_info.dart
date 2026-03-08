import 'package:flutter/material.dart';

import '../../../../widgets/text_field/common_input_field.dart';

class TaskInfo extends StatelessWidget {

  const TaskInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonInputField(),
        CommonInputField()
      ],
    );
  }
}

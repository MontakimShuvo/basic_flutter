import 'package:flutter/material.dart';
import '../../../../constants/app_constants.dart';
import '../../../../data/model/subtask.dart';
import '../../../../widgets/text_field/common_input_field.dart';

class SubtaskTile extends StatelessWidget {
  final bool? isShownArrow;
  final double? fontSize;
  final double? width;
  final Subtask subtask;
  final VoidCallback onRemove;

  const SubtaskTile({
    super.key,
    this.isShownArrow,
    this.fontSize,
    this.width,
    required this.subtask,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: Row(
        children: [
          if (isShownArrow == true)
              const Icon(Icons.subdirectory_arrow_right, color: Colors.transparent),
          if (isShownArrow == true) const SizedBox(width: AppConstants.valueDouble12),
          GestureDetector(
            onTap: onRemove,
            child: Icon(
              subtask.isCompleted == 1
                  ? Icons.check_circle
                  : Icons.radio_button_unchecked,
              color: subtask.isCompleted == 1 ? Colors.green : Colors.grey,
            ),
          ),
          SizedBox(width: width ?? AppConstants.valueDouble12),
          Expanded(
            child: CommonInputField(
              controller: subtask.controller,
              hintText: "Enter title",
              style: TextStyle(
                fontSize: fontSize ?? AppConstants.valueDouble16,
                decoration: subtask.isCompleted == 1 ? TextDecoration.lineThrough : null,
                color: subtask.isCompleted == 1 ? Colors.grey : Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

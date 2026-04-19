import 'package:flutter/material.dart';
import '../../../../constants/app_constants.dart';

class TaskDetailChip extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  const TaskDetailChip({
    super.key,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.valueDouble14,
        vertical: AppConstants.valueDouble8,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(AppConstants.valueDouble12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text),
          const SizedBox(width: AppConstants.valueDouble6),
          GestureDetector(
            onTap: onTap,
            child: const Icon(Icons.close, size: AppConstants.valueDouble18),
          ),
        ],
      ),
    );
  }
}

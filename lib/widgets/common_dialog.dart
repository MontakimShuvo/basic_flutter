import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class CommonDialog extends StatelessWidget {
  final String title;
  final String content;
  final String cancelText;
  final String deleteText;
  final VoidCallback onCancel;
  final VoidCallback onDelete;

  const CommonDialog({
    super.key,
    required this.title,
    required this.content,
    this.cancelText = "Cancel",
    this.deleteText = "Delete",
    required this.onCancel,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.valueDouble28),
      ),
      backgroundColor: Colors.white,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: AppConstants.valueDouble20,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      content: Text(
        content,
        style: const TextStyle(
          fontSize: AppConstants.valueDouble16,
          color: Colors.black54,
        ),
      ),
      contentPadding: const EdgeInsets.fromLTRB(
        AppConstants.valueDouble24,
        AppConstants.valueDouble20,
        AppConstants.valueDouble24,
        AppConstants.valueDouble24,
      ),
      actions: [
        TextButton(
          onPressed: onCancel,
          child: Text(
            cancelText,
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        TextButton(
          onPressed: onDelete,
          child: Text(
            deleteText,
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
      actionsPadding: const EdgeInsets.only(
        right: AppConstants.valueDouble16,
        bottom: AppConstants.valueDouble16,
      ),
    );
  }
}

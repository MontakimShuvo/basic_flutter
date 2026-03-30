import 'package:flutter/material.dart';
import '../../../../constants/app_constants.dart';

class ListOptionsBottomSheet extends StatelessWidget {
  final VoidCallback onRename;
  final VoidCallback onDelete;
  final bool hasCompletedTasks;

  const ListOptionsBottomSheet({
    super.key,
    required this.onRename,
    required this.onDelete,
    this.hasCompletedTasks = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppConstants.valueDouble20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppConstants.valueDouble28),
          topRight: Radius.circular(AppConstants.valueDouble28),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildOption(
            context: context,
            title: "Rename list",
            onTap: onRename,
          ),
          _buildOption(
            context: context,
            title: "Delete list",
            onTap: onDelete,
          ),
          _buildOption(
            context: context,
            title: "Delete all completed tasks",
            onTap: null,
            isEnabled: false,
          ),
          const SizedBox(height: AppConstants.valueDouble10),
        ],
      ),
    );
  }

  Widget _buildOption({
    required BuildContext context,
    required String title,
    required VoidCallback? onTap,
    bool isEnabled = true,
  }) {
    return InkWell(
      onTap: isEnabled ? () {
        Navigator.pop(context);
        onTap?.call();
      } : null,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: AppConstants.valueDouble16,
          horizontal: AppConstants.valueDouble24,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: AppConstants.valueDouble16,
            fontWeight: FontWeight.w400,
            color: isEnabled ? Colors.black87 : Colors.black26,
          ),
        ),
      ),
    );
  }
}

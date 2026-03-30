import 'package:flutter/material.dart';
import 'package:untitled/features/home/view/widget/list_options_bottom_sheet.dart';
import 'package:untitled/widgets/bottom_sheet/common_bottom_sheet.dart';
import 'package:untitled/widgets/common_dialog.dart';

import '../../../../constants/app_constants.dart';
import '../../controller/new_task_controller.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({
    super.key,
    required this.title,
    required this.controller,
    this.onSortTap,
    this.onRenameTap,
    this.assetIcon,
  });

  final String title;
  final NewTaskController controller;
  final VoidCallback? onSortTap;
  final VoidCallback? onRenameTap;
  final String? assetIcon;

  void showDeleteDialog(BuildContext context, {required VoidCallback onDelete}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CommonDialog(
          title: "Delete this list?",
          content: "All tasks in this list will be permanently deleted",
          onCancel: () => Navigator.pop(context),
          onDelete: () {
            Navigator.pop(context);
            onDelete();
          },
        );
      },
    );
  }

  void _showOptions(BuildContext context) {
    CommonBottomSheet.show(
      context: context,
      body: ListOptionsBottomSheet(
        onRename: () {
          onRenameTap?.call();
        },
        onDelete: () {
          showDeleteDialog(context, onDelete: () {
            controller.deleteList();
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: AppConstants.valueDouble15,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            if (onSortTap != null)
              GestureDetector(
                onTap: onSortTap,
                child: Image.asset(
                  assetIcon ?? 'assets/icons/ic_sorting.png',
                  width: AppConstants.valueDouble20,
                  height: AppConstants.valueDouble20,
                ),
              ),
            if (!controller.isFavouriteTab) ...[
              const SizedBox(width: AppConstants.valueDouble16),
              GestureDetector(
                onTap: () => _showOptions(context),
                child: const Icon(
                  Icons.more_vert,
                  size: AppConstants.valueDouble24,
                  color: Colors.black87,
                ),
              ),
            ]
          ],
        )
      ],
    );
  }
}

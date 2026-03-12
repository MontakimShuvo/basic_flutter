import 'package:flutter/material.dart';

import '../../../../constants/app_constants.dart';
import '../../controller/new_task_controller.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({
    super.key,
    required this.title,
    required this.controller,
    this.onSortTap,
    this.assetIcon,
  });

  final String title;
  final NewTaskController controller;
  final VoidCallback? onSortTap;
  final String? assetIcon;

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
        if (onSortTap != null)
          GestureDetector(
            onTap: onSortTap,
            child: Image.asset(
              assetIcon ?? 'assets/icons/ic_sorting.png',
              width: AppConstants.valueDouble20,
              height: AppConstants.valueDouble20,
            ),
          ),
      ],
    );
  }
}

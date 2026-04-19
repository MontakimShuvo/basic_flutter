import 'package:flutter/material.dart';
import '../../../../constants/app_colors_as.dart';

class NoTaskFoundWidget extends StatelessWidget {
  const NoTaskFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.noCardFoundBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Image.asset(
          'assets/icons/no_task_found.png',
          width: double.infinity,
        ),
      ),
    );
  }
}

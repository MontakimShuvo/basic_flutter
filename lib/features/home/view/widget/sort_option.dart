import 'package:flutter/material.dart';
import 'package:untitled/constants/app_constants.dart';

class SortOption extends StatelessWidget {
  final String title;
  final String value;
  final bool isSelected;
  final VoidCallback onTap;

  const SortOption({
    super.key,
    required this.title,
    required this.value,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppConstants.valueDouble12,
          horizontal: AppConstants.valueDouble12,
        ),
        child: Row(
          children: [
            SizedBox(
              width: AppConstants.valueDouble24,
              child: isSelected
                  ? const Icon(
                Icons.check,
                size: AppConstants.valueDouble20,
                color: Colors.black87,
              )
                  : null,
            ),
            const SizedBox(width: AppConstants.valueDouble12),
            Text(
              title,
              style: const TextStyle(
                fontSize: AppConstants.valueDouble16,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
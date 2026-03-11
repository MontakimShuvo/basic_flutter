import 'package:flutter/material.dart';
import '../../../../constants/app_constants.dart';

class SortBottomSheet extends StatelessWidget {
  final String selectedSort;
  final Function(String) onSortSelected;

  const SortBottomSheet({
    super.key,
    required this.selectedSort,
    required this.onSortSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppConstants.valueDouble20, horizontal: AppConstants.valueDouble16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppConstants.valueDouble28),
          topRight: Radius.circular(AppConstants.valueDouble28),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: AppConstants.valueDouble12, bottom: AppConstants.valueDouble16),
            child: Text(
              "Sort by",
              style: TextStyle(
                fontSize: AppConstants.valueDouble14,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          ),
          _sortOption(context, "My order", "my_order"),
          _sortOption(context, "Date", "date"),
          _sortOption(context, "Deadline", "dead_line"),
          _sortOption(context, "Title", "title"),
          const SizedBox(height: AppConstants.valueDouble10),
        ],
      ),
    );
  }

  Widget _sortOption(BuildContext context, String title, String value) {
    final isSelected = selectedSort == value;
    return InkWell(
      onTap: () {
        onSortSelected(value);
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppConstants.valueDouble12, horizontal: AppConstants.valueDouble12),
        child: Row(
          children: [
            SizedBox(
              width: AppConstants.valueDouble24,
              child: isSelected
                  ? const Icon(Icons.check, size: AppConstants.valueDouble20, color: Colors.black87)
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

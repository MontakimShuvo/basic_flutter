import 'package:flutter/material.dart';
import 'package:untitled/features/home/view/widget/sort_option.dart';
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
          SortOption(
            title: "My order",
            value: "my_order",
            isSelected: selectedSort == "my_order",
            onTap: () {
              onSortSelected("my_order");
              Navigator.pop(context);
            },
          ),
          SortOption(
            title: "Date",
            value: "date",
            isSelected: selectedSort == "date",
            onTap: () {
              onSortSelected("date");
              Navigator.pop(context);
            },
          ),
          SortOption(
            title: "Deadline",
            value: "dead_line",
            isSelected: selectedSort == "dead_line",
            onTap: () {
              onSortSelected("dead_line");
              Navigator.pop(context);
            },
          ),
          SortOption(
            title: "Title",
            value: "title",
            isSelected: selectedSort == "title",
            onTap: () {
              onSortSelected("title");
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: AppConstants.valueDouble10),
        ],
      ),
    );
  }
}



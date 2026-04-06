import 'package:flutter/material.dart';
import '../../../../constants/app_constants.dart';
import '../../../../constants/app_edge_insets.dart';
import '../../../../utils/size_config.dart';
import '../../../../widgets/calendar_widget/task_calendar_sheet.dart';
import '../../../../widgets/text_field/common_input_field.dart';

class TaskInfo extends StatefulWidget {
  final void Function(String title, String details, DateTime? date)? onDone;

  const TaskInfo({
    super.key,
    this.onDone,
  });

  @override
  State<TaskInfo> createState() => _TaskInfoState();
}

class _TaskInfoState extends State<TaskInfo> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();

  final FocusNode _detailsFocusNode = FocusNode();

  bool _showDetails = false;
  DateTime? _selectedDate;

  @override
  void dispose() {
    _titleController.dispose();
    _detailsController.dispose();
    _detailsFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      padding: AppEdgeInsets.defaultPagePadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// TITLE
          CommonInputField(
            controller: _titleController,
            height: AppConstants.valueDouble40,
            hintText: 'New Task',
            autofocus: true,
          ),

          /// DETAILS
          if (_showDetails)
            CommonInputField(
              controller: _detailsController,
              focusNode: _detailsFocusNode,
              height: AppConstants.valueDouble30,
              hintText: 'Add Details',
              hintStyle: TextStyle(
                fontSize: AppConstants.valueDouble14,
                color: Colors.black54,
              ),
            ),

          /// ACTION ROW
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  /// SHOW DETAILS
                  GestureDetector(
                    onTap: () {
                      setState(() => _showDetails = true);
                      _detailsFocusNode.requestFocus();
                    },
                    child: Image.asset(
                      'assets/icons/ic_menu.png',
                      width: AppConstants.valueDouble24,
                      height: AppConstants.valueDouble24,
                    ),
                  ),

                  const SizedBox(width: 20),

                  /// PICK DATE
                  GestureDetector(
                    onTap: () => _openTaskCalendar(context),
                    child: Image.asset(
                      'assets/icons/ic_clock.png',
                      width: AppConstants.valueDouble24,
                      height: AppConstants.valueDouble24,
                    ),
                  ),
                ],
              ),

              /// DONE BUTTON
              TextButton(
                onPressed: _onDone,
                child: const Text('Done'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// ---------------- ACTIONS ----------------

  void _onDone() {
    final title = _titleController.text.trim();

    if (title.isEmpty) return;

    widget.onDone?.call(
      title,
      _detailsController.text.trim(),
      _selectedDate,
    );
  }

  void _openTaskCalendar(BuildContext context) async {
    final result = await showModalBottomSheet<DateTime>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const TaskCalendarSheet(),
    );

    if (result != null) {
      setState(() => _selectedDate = result);
    }
  }
}
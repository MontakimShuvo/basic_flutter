import 'package:flutter/material.dart';

import '../../../../constants/app_constants.dart';
import '../../../../constants/app_edge_insets.dart';
import '../../../../utils/size_config.dart';
import '../../../../widgets/calendar_widget/task_calendar_sheet.dart';
import '../../../../widgets/text_field/common_input_field.dart';
import '../../controller/home_controller.dart';

class TaskInfo extends StatefulWidget {
  final HomeController homeController;
  final void Function(String title, String details, DateTime? date)? onDone;

  const TaskInfo({super.key, required this.homeController, this.onDone});

  @override
  State<TaskInfo> createState() => _TaskInfoState();
}

class _TaskInfoState extends State<TaskInfo> {
  final FocusNode _detailsFocusNode = FocusNode();
  bool _showDetails = false;
  DateTime? _selectedDate;

  @override
  void dispose() {
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
          CommonInputField(
            controller: widget.homeController.taskTitleController,
            height: AppConstants.valueDouble40,
            hintText: 'New Task',
            autofocus: true,
          ),
          if (_showDetails)
            CommonInputField(
              controller: widget.homeController.taskDetailsController,
              focusNode: _detailsFocusNode,
              height: AppConstants.valueDouble30,
              hintText: 'Add Details',
              hintStyle: TextStyle(
                fontSize: AppConstants.valueDouble14,
                color: Colors.black54,
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _showDetails = true;
                      });
                      _detailsFocusNode.requestFocus();
                    },
                    child: Image.asset(
                      'assets/icons/ic_menu.png',
                      width: AppConstants.valueDouble24,
                      height: AppConstants.valueDouble24,
                    ),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      openTaskCalendar(context);
                    },
                    child: Image.asset(
                      'assets/icons/ic_clock.png',
                      width: AppConstants.valueDouble24,
                      height: AppConstants.valueDouble24,
                    ),
                  ),
                ],
              ),

              TextButton(
                  onPressed: () {
                    if (widget.onDone != null) {
                      widget.onDone!(
                        widget.homeController.taskTitleController.text,
                        widget.homeController.taskDetailsController.text,
                        _selectedDate,
                      );
                    }
                  },
                  child: Text('Done')
              ),
            ],
          ),
        ],
      ),
    );
  }

  void openTaskCalendar(BuildContext context) async {
    final result = await showModalBottomSheet<DateTime>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const TaskCalendarSheet(),
    );
    
    if (result != null) {
      setState(() {
        _selectedDate = result;
      });
    }
  }
}

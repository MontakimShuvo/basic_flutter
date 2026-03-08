import 'package:flutter/material.dart';

import '../../../../constants/app_constants.dart';
import '../../../../constants/app_edge_insets.dart';
import '../../../../utils/size_config.dart';
import '../../../../widgets/text_field/common_input_field.dart';
import '../../controller/home_controller.dart';

class TaskInfo extends StatefulWidget {
  final HomeController homeController;

  const TaskInfo({
    super.key,
    required this.homeController,
  });

  @override
  State<TaskInfo> createState() => _TaskInfoState();
}

class _TaskInfoState extends State<TaskInfo> {
  final FocusNode _detailsFocusNode = FocusNode();
  bool _showDetails = false;

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
      height: SizeConfig.screenHeight * AppConstants.percentSkt20,
      child: Column(
        children: [
          CommonInputField(
            controller: widget.homeController.taskTitleController,
            height: AppConstants.valueDoubleSkt40,
            hintText: 'New Task',
            autofocus: true,
          ),
          if (_showDetails)
            CommonInputField(
              controller: widget.homeController.taskDetailsController,
              focusNode: _detailsFocusNode,
              height: AppConstants.valueDoubleSkt30,
              hintText: 'Add Details',
              hintStyle: TextStyle(
                fontSize: AppConstants.valueDoubleSkt14,
                color: Colors.black54,
              ),
            ),
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
                  width: AppConstants.valueDoubleSkt24,
                  height: AppConstants.valueDoubleSkt24,
                ),
              ),
              GestureDetector(
                onTap: () {
                  _selectDate();
                },
                child: Image.asset(
                  'assets/icons/ic_clock.png',
                  width: AppConstants.valueDoubleSkt24,
                  height: AppConstants.valueDoubleSkt24,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> _selectDate() async{
    await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100)
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/features/home/controller/home_controller.dart';
import 'package:untitled/features/home/view/widget/task_info.dart';
import 'package:untitled/widgets/bottom_sheet/common_bottom_sheet.dart';
import 'package:untitled/widgets/common_app_bar.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key, this.title, this.trailingIcon});

  final String? title;
  final String? trailingIcon;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) {
        final tabController = controller.tabController;

        if (tabController == null || controller.tabsTitle.isEmpty) {
          return const Scaffold();
        }

        return Scaffold(
          appBar: CommonAppBar(
            title: title,
            trailingIcon: trailingIcon,
            tabsTitle: controller.tabsTitle,
            tabController: tabController,
            addNewTask: (_) => controller.onCreateNewList(),
          ),
          body: TabBarView(
            controller: tabController,
            children: controller.getTabBarView(context),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _openBottomSheet(context),
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  void _openBottomSheet(BuildContext context) {
    CommonBottomSheet.show(
      context: context,
      body: TaskInfo(
        onDone: (title, details, date) {
          final index = controller.tabController.index;

          if (index < controller.taskControllers.length) {
            controller.taskControllers[index].addItem(
              taskTitle: title,
              notes: details,
              dueDate: date,
            );
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../../../widgets/bottom_sheet/common_bottom_sheet.dart';
import '../controller/home_controller.dart';
import '../../../widgets/app_bar.dart';
import '../../new_tab_screen/create_new_tab_screen.dart';
import 'widget/task_info.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    this.title,
    this.leadingIcon = 'assets/icons/Arrow - Left 2.svg',
    this.trailingIcon = 'assets/icons/dots.svg',
  });

  final String? title;
  final String? leadingIcon;
  final String? trailingIcon;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController _homeController = HomeController();

  void _gotoCreateTaskScreen(BuildContext context) async {
    // Get the current TabController to remember the active index
    final controller = DefaultTabController.of(context);
    final previousIndex = controller.index-1;

    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateNewTabScreen()),
    );

    if (result != null && result is String && context.mounted) {
      _homeController.addNewTask(result);
    } else {
      // If no task was created, animate back to the previous tab
      controller.animateTo(previousIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _homeController,
      builder: (context, child) {
        return DefaultTabController(
          key: ValueKey(_homeController.taskCount),
          initialIndex: (_homeController.taskCount - 1).clamp(0, 1000),
          length: _homeController.tabsTitle.length,
          child: Builder(
            builder: (context) {
              final controller = DefaultTabController.of(context);

              return Scaffold(
                appBar: appBar(
                  context: context,
                  title: widget.title,
                  leadingIcon: widget.leadingIcon,
                  trailingIcon: widget.trailingIcon,
                  tabsTitle: _homeController.tabsTitle,
                  addNewTask: (ctx) => _gotoCreateTaskScreen(ctx),
                ),
                backgroundColor: Colors.white,
                body: TabBarView(children: _homeController.tabBarView),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    commonBottomSheet(
                      context: context,
                      body: TaskInfo(
                        homeController: _homeController,
                        onDone: (title, details, date) {
                          if (title.isNotEmpty) {
                            final index = controller.index;
                            if (index < _homeController.taskControllers.length) {
                              _homeController.taskControllers[index].addItem(
                                taskTitle: title,
                                notes: details,
                                dueDate: date,
                              );
                              _homeController.taskTitleController.clear();
                              _homeController.taskDetailsController.clear();
                              Navigator.pop(context);
                            }
                          }
                        },
                      ),
                    );
                  },
                  backgroundColor: Colors.blue,
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

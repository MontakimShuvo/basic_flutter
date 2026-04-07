// lib/features/home/view/home_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/bottom_sheet/common_bottom_sheet.dart';
import '../controller/home_controller.dart';
import '../../../widgets/common_app_bar.dart';
import 'widget/task_info.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    this.title,
    this.trailingIcon = 'assets/icons/dots.svg',
  });

  final String? title;
  final String? trailingIcon;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final HomeController _homeController = Get.put(HomeController());
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _setupTabController();
    
    // Listen to changes in taskControllers using GetX workers to update the TabController length
    ever(_homeController.taskControllers, (_) => _setupTabController());
  }

  void _setupTabController() {
    final newLength = _homeController.tabsTitle.length;
    if (_tabController == null || _tabController!.length != newLength) {
      _tabController?.removeListener(_handleTabSelection);
      _tabController?.dispose();

      _tabController = TabController(
        length: newLength,
        vsync: this,
        initialIndex: (newLength - 2).clamp(0, newLength - 1),
      );
      _tabController!.addListener(_handleTabSelection);
      if (mounted) setState(() {});
    }
  }

  void _handleTabSelection() {
    if (_tabController != null && !_tabController!.indexIsChanging) {
      final favIndex = _homeController.taskControllers
          .indexWhere((c) => c.isFavouriteTab);
      final currentIndex = _tabController!.index;

      // Refresh data when a tab is selected
      if (currentIndex == favIndex && favIndex != -1) {
        _homeController.taskControllers[favIndex].loadTasks();
      } else if (currentIndex < _homeController.taskControllers.length) {
        _homeController.taskControllers[currentIndex].loadTasks();
      }
    }
  }

  @override
  void dispose() {
    _tabController?.removeListener(_handleTabSelection);
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_tabController == null) return const Scaffold();

      return Scaffold(
        appBar: CommonAppBar(
          title: widget.title,
          trailingIcon: widget.trailingIcon,
          tabsTitle: _homeController.tabsTitle,
          tabController: _tabController,
          addNewTask: (ctx) => _homeController.gotoCreateTaskScreen(ctx),
        ),
        backgroundColor: Colors.white,
        body: TabBarView(
          controller: _tabController,
          children: _homeController.getTabBarView(context),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            CommonBottomSheet.show(
              context: context,
              body: TaskInfo(
                homeController: _homeController,
                onDone: (title, details, date) {
                  if (title.isNotEmpty) {
                    final index = _tabController!.index;
                    if (index < _homeController.taskControllers.length) {
                      _homeController.taskControllers[index].addItem(
                        taskTitle: title,
                        notes: details,
                        dueDate: date,
                      );
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
    });
  }
}

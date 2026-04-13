// lib/features/home/view/home_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setupTabController();
      context.read<HomeController>().addListener(_setupTabController);
    });
  }

  void _setupTabController() {
    final homeController = context.read<HomeController>();
    final newLength = homeController.tabsTitle.length;
    if (_tabController == null || _tabController!.length != newLength) {
      _tabController?.removeListener(_handleTabSelection);
      _tabController?.dispose();

      _tabController = TabController(
        length: newLength,
        vsync: this,
        initialIndex: (newLength - 2).clamp(0, newLength - 1),
      );
      _tabController!.addListener(_handleTabSelection);
      setState(() {});
    }
  }

  void _handleTabSelection() {
    if (_tabController != null && !_tabController!.indexIsChanging) {
      final homeController = context.read<HomeController>();
      final favIndex = homeController.taskControllers
          .indexWhere((c) => c.isFavouriteTab);
      final currentIndex = _tabController!.index;

      if (currentIndex == favIndex && favIndex != -1) {
        homeController.taskControllers[favIndex].loadTasks();
      } else {
        if (currentIndex < homeController.taskControllers.length) {
          homeController.taskControllers[currentIndex].loadTasks();
        }
      }
    }
  }

  @override
  void dispose() {
    // Note: We need to be careful about accessing context here.
    // Usually, you'd remove the listener in a way that doesn't depend on context if possible,
    // or ensure the controller is still alive.
    _tabController?.removeListener(_handleTabSelection);
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, homeController, child) {
        if (_tabController == null) return const Scaffold();

        return Scaffold(
          appBar: CommonAppBar(
            title: widget.title,
            trailingIcon: widget.trailingIcon,
            tabsTitle: homeController.tabsTitle,
            tabController: _tabController,
            addNewTask: (ctx) => homeController.gotoCreateTaskScreen(ctx),
          ),
          backgroundColor: Colors.white,
          body: TabBarView(
            controller: _tabController,
            children: homeController.getTabBarView(context),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              CommonBottomSheet.show(
                context: context,
                body: TaskInfo(
                  homeController: homeController,
                  onDone: (title, details, date) {
                    if (title.isNotEmpty) {
                      final index = _tabController!.index;
                      if (index < homeController.taskControllers.length) {
                        homeController.taskControllers[index].addItem(
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
      },
    );
  }
}
// lib/features/home/view/home_screen.dart

import 'package:flutter/material.dart';
import '../../../widgets/bottom_sheet/common_bottom_sheet.dart';
import '../controller/home_controller.dart';
import '../../../widgets/common_app_bar.dart';
import '../../new_tab_screen/create_task_list_tab_screen.dart';
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
  final HomeController _homeController = HomeController();
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    // Initialize controller after the home controller loads initial lists
    _setupTabController();
    _homeController.addListener(_setupTabController);
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
    }
  }

  void _handleTabSelection() {
    if (_tabController != null && !_tabController!.indexIsChanging) {
      // Find the index of the Favorites tab
      final favIndex = _homeController.taskControllers
          .indexWhere((c) => c.isFavouriteTab);
      final currentIndex = _tabController!.index;


      // If the selected tab is the Favorites tab or other, refresh its data
      if (_tabController!.index == favIndex && favIndex != -1) {
        _homeController.taskControllers[favIndex].loadTasks();
      }else{
        if (currentIndex < _homeController.taskControllers.length) {
          _homeController.taskControllers[currentIndex].loadTasks();
        }
      }
    }
  }

  @override
  void dispose() {
    _homeController.removeListener(_setupTabController);
    _tabController?.removeListener(_handleTabSelection);
    _tabController?.dispose();
    super.dispose();
  }

  void _gotoCreateTaskScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateTaskListTabScreen()),
    );

    if (result != null && result is String && context.mounted) {
      await _homeController.addNewTask(result);
      // Add new tab task
      // The _setupTabController listener will handle updating _tabController length
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _homeController,
      builder: (context, child) {
        if (_tabController == null) return const Scaffold();

        return Scaffold(
          appBar: CommonAppBar(
            title: widget.title,
            trailingIcon: widget.trailingIcon,
            tabsTitle: _homeController.tabsTitle,
            tabController: _tabController, // Pass the controller to your AppBar
            addNewTask: (ctx) => _gotoCreateTaskScreen(ctx),
          ),
          backgroundColor: Colors.white,
          body: TabBarView(
            controller: _tabController,
            children: _homeController.tabBarView,
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
      },
    );
  }
}
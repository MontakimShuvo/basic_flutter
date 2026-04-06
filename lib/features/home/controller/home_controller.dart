import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/di/injector.dart';
import 'package:untitled/features/new_task/view/task_list_screen.dart';
import 'package:untitled/routes/app_routes.dart';
import '../../../data/services/database_service.dart';
import '../../new_task/controller/new_task_controller.dart';
import '../../../widgets/tab_item.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {

  final DatabaseService _dbService = resolve<DatabaseService>();

  /// STATE
  final taskControllers = <NewTaskController>[].obs;

  late TabController tabController;

  /// ---------------- INIT ----------------
  @override
  void onInit() {
    super.onInit();

    _loadTaskLists();

    ever(taskControllers, (_) => _updateTabController());
  }

  /// ---------------- DATA LOAD ----------------
  Future<void> _loadTaskLists() async {
    final lists = await _dbService.getTaskLists();

    taskControllers.clear();

    if (lists.isEmpty) {
      await addNewTask("Favorites");
      return;
    }

    for (var list in lists) {
      taskControllers.add(
        NewTaskController(
          id: list['id'],
          taskName: list['name'],
          isFavouriteTab: list['name'] == "Favorites",
          onDeleteList: _loadTaskLists,
        ),
      );
    }
  }

  /// ---------------- TAB CONTROLLER ----------------
  void _updateTabController() {
    final length = tabsTitle.length;

    if (length == 0) return;

    if (Get.isRegistered<TabController>()) {
      tabController.dispose();
    }

    tabController = TabController(
      length: length,
      vsync: this,
      initialIndex: (length - 2).clamp(0, length - 1),
    );

    tabController.addListener(_handleTabChange);

    update(); // notify UI
  }

  void _handleTabChange() {
    if (!tabController.indexIsChanging) {
      final index = tabController.index;

      if (index < taskControllers.length) {
        taskControllers[index].loadTasks();
      }
    }
  }

  /// ---------------- CRUD ----------------
  Future<void> addNewTask(String taskName) async {
    final newList = {
      'name': taskName,
      'position': taskControllers.length,
      'created_at': DateTime.now().millisecondsSinceEpoch,
    };

    final id = await _dbService.createTaskList(newList);

    taskControllers.add(
      NewTaskController(
        id: id,
        taskName: taskName,
      ),
    );
  }

  Future<void> updateTaskList(int id, String newName) async {
    await _dbService.updateTaskList(id, {'name': newName});
    await _loadTaskLists();
  }

  /// ---------------- UI DATA ----------------
  int get taskCount => taskControllers.length;

  List<TabItem> get tabsTitle {
    final titles = <TabItem>[];

    for (int i = 0; i < taskControllers.length; i++) {
      final controller = taskControllers[i];

      titles.add(
        TabItem(
          index: i,
          title: controller.taskName == "Favorites" ? "" : controller.taskName,
          count: controller.items.length,
        ),
      );
    }

    titles.add(
      TabItem(
        index: taskControllers.length,
        title: '+ new list',
        count: 0,
      ),
    );

    return titles;
  }

  List<Widget> getTabBarView(BuildContext context) {
    final views = <Widget>[];

    for (var controller in taskControllers) {
      views.add(
        TaskListScreen(
          controller: controller,
          onRenameTap: () => onRename(controller),
        ),
      );
    }

    views.add(const Center(child: Text("Click + to add a task")));

    return views;
  }

  /// ---------------- EVENTS (UI TRIGGER) ----------------
  void onRename(NewTaskController controller) {
    Get.toNamed(
      AppRoutes.createTaskList,
      arguments: {
        'listId': controller.id,
        'existingName': controller.taskName,
      },
    )?.then((result) async {
      if (result != null && result is Map) {
        final listId = result['id'];
        final listName = result['name'];

        if (listId != null) {
          await updateTaskList(listId, listName);
        } else {
          await addNewTask(listName);
        }
      }
    });
  }

  void onCreateNewList() {
    Get.toNamed(AppRoutes.createTaskList)?.then((result) async {
      if (result != null && result is Map) {
        await addNewTask(result['name']);
      }
    });
  }

  /// ---------------- CLEANUP ----------------
  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
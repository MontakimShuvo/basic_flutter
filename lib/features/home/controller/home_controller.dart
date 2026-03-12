import 'package:flutter/material.dart';
import '../../../data/database_service.dart';
import '../../new_task/view/new_task_screen.dart';
import '../../../widgets/tab_item.dart';
import '../../new_task/controller/new_task_controller.dart';

class HomeController extends ChangeNotifier {
  final List<NewTaskController> taskControllers = [];
  final DatabaseService _dbService = DatabaseService();

  var taskTitleController = TextEditingController();
  var taskDetailsController = TextEditingController();

  HomeController() {
    _loadTaskLists();
  }

  // Load existing lists from DB on startup
  Future<void> _loadTaskLists() async {
    final lists = await _dbService.getTaskLists();
    if (lists.isEmpty) {
      // Create default Favorites if DB is empty
      await addNewTask("Favorites");
    } else {
      taskControllers.clear();
      for (var list in lists) {
        taskControllers.add(NewTaskController(
          id: list['id'],
          taskName: list['name'],
          isFavouriteTab: list['name'] == "Favorites"
        ));
      }
      notifyListeners();
    }
  }

  Future<void> addNewTask(String taskName) async {
    // 1. Prepare data for SQLite
    final newList = {
      'name': taskName,
      'position': taskControllers.length,
      'created_at': DateTime.now().millisecondsSinceEpoch,
    };

    // 2. Perform DB Operation: INSERT
    final id = await _dbService.createTaskList(newList);

    // 3. Update local state
    taskControllers.add(NewTaskController(
      id: id,
      taskName: taskName,
    ));

    notifyListeners();
  }

  int get taskCount => taskControllers.length;

  List<TabItem> get tabsTitle {
    List<TabItem> titles = [];
    for (int i = 0; i < taskControllers.length; i++) {
      titles.add(TabItem(
        index: i,
        title: taskControllers[i].taskName == "Favorites" ? "" : taskControllers[i].taskName,
        count: taskControllers[i].items.length,
      ));
    }
    // Add the "+ new task" tab at the end
    titles.add(TabItem(index: taskControllers.length, title: '+ new list', count: 0));
    return titles;
  }

  List<Widget> get tabBarView {
    List<Widget> views = [];
    for (var controller in taskControllers) {
      views.add(NewTaskScreen(controller: controller));
    }
    // Add a placeholder for the "+ new task" tab view
    views.add(const Center(child: Text("Click + to add a task")));
    return views;
  }
}

import 'package:flutter/material.dart';
import '../pages/new_task_screen.dart';
import '../widgets/tab_item.dart';
import 'new_task_controller.dart';

class HomeController extends ChangeNotifier {
  final List<NewTaskController> taskControllers = [];

  HomeController() {
    taskControllers.add(NewTaskController(taskName: "Favorites"));
  }

  void addNewTask(String taskName) {
    taskControllers.add(NewTaskController(taskName: taskName));
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
    titles.add(TabItem(index: taskControllers.length, title: '+ new task', count: 0));
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

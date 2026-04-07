import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/di/injector.dart';
import 'package:untitled/features/new_tab_screen/create_task_list_tab_screen.dart';
import '../../../data/services/database_service.dart';
import '../../new_task/view/task_list_screen.dart';
import '../../../widgets/tab_item.dart';
import '../../new_task/controller/new_task_controller.dart';

class HomeController extends GetxController {
  final taskControllers = <NewTaskController>[].obs;
  final DatabaseService _dbService = resolve<DatabaseService>();

  var taskTitleController = TextEditingController();
  var taskDetailsController = TextEditingController();

  HomeController() {
    _loadTaskLists();
  }

  Future<void> _loadTaskLists() async {
    final lists = await _dbService.getTaskLists();
    if (lists.isEmpty) {
      await addNewTask("Favorites");
    } else {
      taskControllers.clear();
      for (var list in lists) {
        taskControllers.add(NewTaskController(
          id: list['id'],
          taskName: list['name'],
          isFavouriteTab: list['name'] == "Favorites",
          onDeleteList: ()=>_loadTaskLists()
        ));
      }
    }
  }

  Future<void> addNewTask(String taskName) async {
    final newList = {
      'name': taskName,
      'position': taskControllers.length,
      'created_at': DateTime.now().millisecondsSinceEpoch,
    };

    final id = await _dbService.createTaskList(newList);

    taskControllers.add(NewTaskController(
      id: id,
      taskName: taskName,
    ));
  }

  Future<void> updateTaskList(int id, String newName) async {
    await _dbService.updateTaskList(id, {'name': newName});
    await _loadTaskLists();
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
    titles.add(TabItem(index: taskControllers.length, title: '+ new list', count: 0));
    return titles;
  }

  List<Widget> getTabBarView(BuildContext context) {
    List<Widget> views = [];
    for (var controller in taskControllers) {
      views.add(
          TaskListScreen(
            controller: controller,
            onRenameTap: () => gotoCreateTaskScreen(
                context,
                id: controller.id,
                name: controller.taskName
            ),
          )
      );
    }
    views.add(const Center(child: Text("Click + to add a task")));
    return views;
  }

  void gotoCreateTaskScreen(BuildContext context, {int? id, String? name}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateTaskListTabScreen(
          listId: id,
          existingName: name,
        ),
      ),
    );

    if (result != null && result is Map && context.mounted) {
      final listId = result['id'];
      final listName = result['name'];

      if (listId != null) {
        await updateTaskList(listId, listName);
      } else {
        await addNewTask(listName);
      }
    }
  }
}

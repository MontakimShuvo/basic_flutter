import 'package:get/get.dart';
import 'package:untitled/features/new_tab_screen/controller/create_task_list_controller/create_task_list_controller.dart';

class CreateTaskListBinding extends Bindings {
  @override
  void dependencies() {
    final args = Get.arguments as Map<String, dynamic>?;
    Get.lazyPut(() => CreateTaskListController(
          listId: args?['listId'] as int?,
          existingName: args?['existingName'] as String?,
        ));
  }
}
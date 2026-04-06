import 'package:get/get.dart';
import 'package:untitled/features/task_details/controller/task_details_controller.dart';

class TaskDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TaskDetailsController(task: Get.arguments as Map<String, dynamic>));
  }
}
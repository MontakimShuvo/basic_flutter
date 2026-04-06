import 'package:get/get.dart';
import 'package:untitled/features/home/bindings/home_binding.dart';
import 'package:untitled/features/home/view/home_screen.dart';
import 'package:untitled/features/new_tab_screen/bindings/create_task_list_binding.dart';
import 'package:untitled/features/new_tab_screen/view/create_task_list_screen.dart';
import 'package:untitled/features/task_details/bindings/task_details_binding.dart';
import 'package:untitled/features/task_details/view/task_details_screen.dart';
import 'package:untitled/routes/app_routes.dart';

class AppPages {
  static const initial = AppRoutes.home;

  static final pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.taskDetails,
      page: () => const TaskDetailsScreen(),
      binding: TaskDetailsBinding(),
    ),
    GetPage(
      name: AppRoutes.createTaskList,
      page: () => const CreateTaskListScreen(),
      binding: CreateTaskListBinding(),
    ),
  ];
}
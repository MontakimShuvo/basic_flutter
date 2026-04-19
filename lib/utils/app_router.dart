import 'package:go_router/go_router.dart';
import '../features/home/view/home_screen.dart';
import '../features/new_tab_screen/create_task_list_tab_screen.dart';
import '../features/task_details/view/task_details_screen.dart';

class AppRouter {
  static const String home = '/';
  static const String createTaskList = '/create-task-list';
  static const String taskDetails = '/task-details';

  static final GoRouter router = GoRouter(
    initialLocation: home,
    routes: [
      GoRoute(
        path: home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: createTaskList,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return CreateTaskListTabScreen(
            listId: extra?['listId'],
            existingName: extra?['existingName'],
          );
        },
      ),
      GoRoute(
        path: taskDetails,
        builder: (context, state) {
          final task = state.extra as Map<String, dynamic>;
          return TaskDetailsScreen(task: task);
        },
      ),
    ],
  );
}

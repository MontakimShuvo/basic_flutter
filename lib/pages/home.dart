import 'package:flutter/material.dart';

import '../controllers/home_controller.dart';
import '../widgets/app_bar.dart';
import 'create_new_tab_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    this.title,
    this.leadingIcon = 'assets/icons/Arrow - Left 2.svg',
    this.trailingIcon = 'assets/icons/dots.svg',
  });

  final String? title;
  final String? leadingIcon;
  final String? trailingIcon;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController _homeController = HomeController();

  void _gotoCreateTaskScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateNewTabScreen()),
    );

    if (result != null && result is String && context.mounted) {
      _homeController.addNewTask(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _homeController,
      builder: (context, child) {
        return DefaultTabController(
          key: ValueKey(_homeController.taskCount),
          initialIndex: _homeController.taskCount - 1,
          length: _homeController.tabsTitle.length,
          child: Builder(
            builder: (context) {
              final controller = DefaultTabController.of(context);
              
              return Scaffold(
                appBar: appBar(
                  context: context,
                  title: widget.title,
                  leadingIcon: widget.leadingIcon,
                  trailingIcon: widget.trailingIcon,
                  tabsTitle: _homeController.tabsTitle,
                  addNewTask: (ctx) => _gotoCreateTaskScreen(ctx),
                ),
                backgroundColor: Colors.white,
                body: TabBarView(children: _homeController.tabBarView),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    final index = controller.index;
                    if (index < _homeController.taskControllers.length) {
                      _homeController.taskControllers[index].addItem();
                    }
                  },
                  backgroundColor: Colors.blue,
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

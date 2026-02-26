import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/app_bar.dart';
import '../widgets/tab_item.dart';
import 'create_new_tab_screen.dart';
import 'new_task_screen.dart';

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
  late List<TabItem> tabsTitle;
  late List<Widget> tabBarView;
  final List<GlobalKey<NewTaskScreenState>> _taskKeys = [];

  @override
  void initState() {
    super.initState();

    final key = GlobalKey<NewTaskScreenState>();
    _taskKeys.add(key);

    tabsTitle = [
      const TabItem(index: 0, title: '', count: 0),
      const TabItem(index: 1, title: '+ new task', count: 0),
    ];

    tabBarView = [
      NewTaskScreen(key: key, taskName: ""),
      const Center(child: Text("Click + to add a task")),
    ];
  }
  
  void _gotoCreateTaskScreen(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateNewTabScreen()),
    );
  }

  void _addNewTask(BuildContext context) {
    setState(() {
      int newIndex = tabsTitle.length - 1;
      String taskName = 'Task ${tabsTitle.length}';

      final key = GlobalKey<NewTaskScreenState>();
      _taskKeys.add(key);

      tabsTitle.insert(
        newIndex,
        TabItem(index: newIndex, title: taskName, count: 0),
      );

      tabBarView.insert(
        newIndex,
        NewTaskScreen(key: key, taskName: taskName),
      );
    });

    /// switch to new tab after build
    Future.microtask(() {
      DefaultTabController.of(context)?.animateTo(tabsTitle.length - 2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabsTitle.length,
      child: Builder(
        builder: (context) {
          final controller = DefaultTabController.of(context);

          return Scaffold(
            appBar: appBar(
              context: context,
              title: widget.title,
              leadingIcon: widget.leadingIcon,
              trailingIcon: widget.trailingIcon,
              tabsTitle: tabsTitle,
              addNewTask: (ctx) => _gotoCreateTaskScreen(ctx),
            ),
            backgroundColor: Colors.white,
            body: TabBarView(children: tabBarView),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                final index = controller.index ?? 0;
                if (index < _taskKeys.length) {
                  _taskKeys[index].currentState?.addItem();
                }
              },
              backgroundColor: Colors.blue,
              child: const Icon(Icons.add, color: Colors.white),
            ),
          );
        },
      ),
    );
  }


}

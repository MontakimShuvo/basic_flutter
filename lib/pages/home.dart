import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/tab_item.dart';
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

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late List<TabItem> tabsTitle;
  late List<Widget> tabBarView;
  late TabController _tabController;
  final List<GlobalKey<NewTaskScreenState>> _taskKeys = [];
  int _selectedIndex = 0;

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

    _tabController = TabController(length: tabsTitle.length, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    if (_tabController.indexIsChanging) return;
    setState(() {
      _selectedIndex = _tabController.index;
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  void _addNewTask() {
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

      // Dispose old controller and create a new one with updated length
      _tabController.removeListener(_handleTabChange);
      _tabController.dispose();
      _selectedIndex = newIndex;
      _tabController = TabController(
        length: tabsTitle.length,
        vsync: this,
        initialIndex: _selectedIndex,
      );
      _tabController.addListener(_handleTabChange);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          title: widget.title,
          leadingIcon: widget.leadingIcon,
          trailingIcon: widget.trailingIcon),
      backgroundColor: Colors.white,
      body: TabBarView(
        controller: _tabController,
        children: tabBarView,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_selectedIndex < _taskKeys.length) {
            _taskKeys[_selectedIndex].currentState?.addItem();
          }
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  AppBar appBar({String? title, String? leadingIcon, String? trailingIcon}) {
    return AppBar(
      title: Text(
        title ?? 'Tasks',
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0.0,
      leading: leadingIcon != null
          ? GestureDetector(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xffF7F8F8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SvgPicture.asset(
                  leadingIcon,
                  height: 20,
                  width: 20,
                ),
              ),
            )
          : null,
      actions: [
        if (trailingIcon != null)
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.all(10),
              alignment: Alignment.center,
              width: 37,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(50),
              ),
              child: SvgPicture.asset(
                trailingIcon,
                height: 5,
                width: 5,
              ),
            ),
          ),
      ],
      bottom: TabBar(
        controller: _tabController,
        onTap: (index) {
          if (index == tabsTitle.length - 1) {
            _addNewTask();
          }
        },
        tabAlignment: TabAlignment.start,
        isScrollable: true,
        tabs: tabsTitle,
        padding: EdgeInsets.zero,
        labelPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      ),
    );
  }
}

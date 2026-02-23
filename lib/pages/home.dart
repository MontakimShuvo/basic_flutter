import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/tab_item.dart';

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

  @override
  void initState() {
    super.initState();
    tabsTitle = [
      const TabItem(index: 0, title: '', count: 0),
      const TabItem(index: 1, title: 'All Tasks', count: 12),
      const TabItem(index: 2, title: '+ new task', count: 0),
    ];
    tabBarView = [
      const Center(child: Text("Favorite Tasks")),
      const Center(child: Text("All Tasks")),
      const Center(child: Text("Click + to add a task")),
    ];
  }

  void _addNewTask() {
    setState(() {
      int newIndex = tabsTitle.length - 1;
      tabsTitle.insert(
        newIndex,
        TabItem(index: newIndex, title: 'Task ${tabsTitle.length}', count: 0),
      );
      tabBarView.insert(
        newIndex,
        Center(child: Text("Content for Task ${tabsTitle.length - 1}")),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      key: ValueKey(tabsTitle.length),
      initialIndex: 0,
      length: tabsTitle.length,
      child: Scaffold(
        appBar: appBar(
            title: widget.title,
            leadingIcon: widget.leadingIcon,
            trailingIcon: widget.trailingIcon),
        backgroundColor: Colors.white,
        body: TabBarView(
          children: tabBarView,
        ),
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

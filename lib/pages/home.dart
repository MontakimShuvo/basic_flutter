import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/tab_item.dart';

class HomePage extends StatelessWidget {
   HomePage({
     super.key,
     this.title,
     this.leadingIcon = 'assets/icons/Arrow - Left 2.svg',
     this.trailingIcon = 'assets/icons/dots.svg',
   });
  final String? title;
  final String? leadingIcon;
  final String? trailingIcon;
   List<TabItem> tabsTitle = [
     TabItem(index: 0, title: '', count: 0),
     TabItem(index: 1, title: 'All Tasks', count: 12),
     TabItem(index: 3, title: '+ new task', count: 0),
   ];
   List<Widget> tabBarView = [
     const Center(child: Text("Favorite Tasks")),
     const Center(child: Text("All Tasks")),
     const Center(child: Text("All Tasks")),
   ];


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: tabsTitle.length,
      child: Scaffold(
        appBar: appBar(title: title, leadingIcon: leadingIcon, trailingIcon: trailingIcon),
        backgroundColor: Colors.white,
        body:  TabBarView(
          children: tabBarView,
        ),
      ),
    );
  }

  Container _searchField() {
    return Container(
          margin: EdgeInsets.only(top: 40, left: 20, right: 20),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0xff1d1617).withOpacity(0.11),
                blurRadius: 40,
                spreadRadius: 0.0,
              ),
            ],
          ),
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.all(15),
              hintText: "Search pancake",
              hintStyle: TextStyle(
                color: Color(0xffDDDADA),
                fontSize: 14,
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset('assets/icons/Search.svg'),
              ),
              suffixIcon: SizedBox(
                width: 100,
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      VerticalDivider(
                        color: Colors.black,
                        thickness: 0.1,
                        indent: 10,
                        endIndent: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: SvgPicture.asset('assets/icons/Filter.svg'),
                      ),
                    ],
                  ),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        );
  }

  AppBar appBar({String? title, String? leadingIcon, String? trailingIcon}) {
    return AppBar(
      title: Text(
        title ?? 'Tasks',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0.0,
      leading: leadingIcon != null ? GestureDetector(
        onTap: () {},
        child: Container(
          margin: EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0xffF7F8F8),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SvgPicture.asset(
            leadingIcon,
            height: 20,
            width: 20,
          ),
        ),
      ) : null,
      actions: [
        if (trailingIcon != null)
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.all(10),
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
      bottom:  TabBar(
        tabAlignment: TabAlignment.startOffset,
        isScrollable: true,
        tabs: tabsTitle
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? leadingIcon;
  final String? trailingIcon;
  final String? actionName;
  final List<Widget>? tabsTitle;
  final bool centerTitlePos;
  final void Function(BuildContext)? leadingIconAction;
  final void Function(BuildContext)? actionNameAction;
  final void Function(BuildContext)? addNewTask;

  const CommonAppBar({
    super.key,
    this.title,
    this.leadingIcon,
    this.trailingIcon,
    this.actionName,
    this.tabsTitle,
    this.centerTitlePos = true,
    this.leadingIconAction,
    this.actionNameAction,
    this.addNewTask,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title ?? 'Tasks',
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: centerTitlePos,
      backgroundColor: Colors.white,
      elevation: 0.0,
      leading: leadingIcon != null
          ? GestureDetector(
              onTap: () {
                leadingIconAction?.call(context);
              },
              child: Container(
                margin: const EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xffF7F8F8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SvgPicture.asset(leadingIcon!, height: 20, width: 20),
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
              child: SvgPicture.asset(trailingIcon!),
            ),
          ),
        if (actionName != null)
          GestureDetector(
            onTap: () {
              actionNameAction?.call(context);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Text(
                actionName!,
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
      bottom: tabsTitle != null
          ? TabBar(
              isScrollable: true,
              tabs: tabsTitle!,
              onTap: (index) {
                if (index == tabsTitle!.length - 1) {
                  addNewTask?.call(context);
                }
              },
              tabAlignment: TabAlignment.start,
              padding: EdgeInsets.zero,
              labelPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (tabsTitle != null ? kTextTabBarHeight : 0),
      );
}

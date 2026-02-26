import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

AppBar appBar({
  required BuildContext context,
  String? title,
  String? leadingIcon,
  String? trailingIcon,
  String? actionName,
  List<Widget>? tabsTitle,
  bool? centerTitlePos,
  void Function(BuildContext)? leadingIconAction,
  void Function(BuildContext)? addNewTask,
}) {
  return AppBar(
    title: Text(
      title ?? 'Tasks',
      style: const TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    centerTitle: centerTitlePos ?? true,
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
              child: SvgPicture.asset(leadingIcon, height: 20, width: 20),
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
            child: Text(trailingIcon),
          ),
        ),
      if (actionName != null)
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Text(
            actionName ?? "",
            style: TextStyle(
              color: Colors.black.withOpacity(0.4),
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
    ],
    bottom: tabsTitle != null
        ? TabBar(
            isScrollable: true,
            tabs: tabsTitle,
            onTap: (index) {
              if (index == tabsTitle.length - 1) {
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

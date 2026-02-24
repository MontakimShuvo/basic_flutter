import 'package:flutter/material.dart';

class NewTaskScreen extends StatefulWidget {
  final String taskName;
  const NewTaskScreen({super.key, required this.taskName});

  @override
  State<NewTaskScreen> createState() => NewTaskScreenState();
}

class NewTaskScreenState extends State<NewTaskScreen> with AutomaticKeepAliveClientMixin {
  final List<String> items = [];

  void addItem() {
    setState(() {
      items.add("New item ${items.length + 1} for ${widget.taskName}");
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(items[index]),
                leading: const Icon(Icons.label),
              );
            },
          ),
        ),
      ],
    );
  }
}

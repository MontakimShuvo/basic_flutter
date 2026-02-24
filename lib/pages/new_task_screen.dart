import 'package:flutter/material.dart';

class NewTaskScreen extends StatefulWidget {
  final String taskName;
  const NewTaskScreen({super.key, required this.taskName});

  @override
  State<NewTaskScreen> createState() => NewTaskScreenState();
}

class NewTaskScreenState extends State<NewTaskScreen> {
  final List<String> items = [];

  void addItem() {
    setState(() {
      items.add("New item ${items.length + 1} for ${widget.taskName}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.star, color: Colors.white, size: 30),
                  const SizedBox(height: 5),
                  Text(
                    widget.taskName,
                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
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

import 'package:flutter/material.dart';
import 'package:untitled/features/home/view/home.dart';
import 'package:untitled/features/new_task/view/widget/task_card_container.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      home:  HomePage(),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/di/injector.dart';
import 'package:untitled/features/home/controller/home_controller.dart';
import 'package:untitled/features/home/view/home_screen.dart';
import 'package:untitled/features/new_task/controller/new_task_controller.dart';
import 'package:untitled/utils/size_config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupInjector();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      home: const HomeScreen(),
    );
  }
}

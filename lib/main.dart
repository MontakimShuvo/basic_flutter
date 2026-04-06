import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/di/injector.dart';
import 'package:untitled/routes/app_pages.dart';
import 'package:untitled/utils/size_config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupInjector();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      initialRoute: AppPages.initial,
      getPages: AppPages.pages,
    );
  }
}
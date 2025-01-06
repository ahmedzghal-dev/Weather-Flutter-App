import 'package:flutter/material.dart';
import 'package:flutter_application_1/helper/theme_helper.dart';
import 'package:flutter_application_1/screens/home/home_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeHelper.light,
      home: HomeView(),
    );
  }
}

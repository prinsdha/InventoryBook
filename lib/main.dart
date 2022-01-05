import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product/core/constant/app_theme.dart';
import 'package:product/core/utils/binding.dart';
import 'package:product/core/utils/config.dart';
import 'package:product/core/utils/routes.dart';
import 'package:product/ui/screen/add_product/add_product_screen.dart';
import 'package:product/ui/screen/home/home_screen.dart';
import 'package:product/ui/shared/image_picker_controller.dart';

late AppImagePicker appImagePicker;
void main() {
  appImagePicker = AppImagePicker();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'product',
      theme: AppTheme.defTheme,
      initialBinding: Binding(),
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      getPages: routes,
    );
  }
}

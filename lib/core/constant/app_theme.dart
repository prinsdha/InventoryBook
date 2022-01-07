import 'package:flutter/material.dart';
import 'package:product/core/constant/app_colors.dart';
import 'package:product/core/constant/app_settings.dart';

class AppTheme {
  static final ThemeData defTheme = ThemeData(
      appBarTheme: const AppBarTheme(backgroundColor: AppColor.kAppBarColor),
      fontFamily: kFont,
      textTheme: const TextTheme(
        bodyText2: TextStyle(fontSize: 16),
      ),
      scaffoldBackgroundColor: Colors.white);
}

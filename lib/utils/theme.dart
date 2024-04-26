import 'package:expense_app/utils/colors.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: AppColor.kWhitColor,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,
    brightness: Brightness.light,
    tertiary: Colors.black,
    onTertiary: Colors.grey[200],
    primaryContainer: Colors.white,
    shadow: Colors.grey[300],
  ),
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: Colors.grey[300]),
);

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: AppColor.kBlueColor.shade900,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.indigo,
    brightness: Brightness.dark,
    tertiary: Colors.white,
    onTertiary: Colors.grey[600],
    primaryContainer: Colors.grey[900],
    shadow: Colors.black,
  ),
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: Colors.grey[700]),
);

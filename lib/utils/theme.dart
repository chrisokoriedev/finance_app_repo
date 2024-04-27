import 'package:expense_app/utils/colors.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: AppColor.kWhitColor,
  colorScheme: ColorScheme.fromSeed(
    primary: AppColor.kDarkGreyColor,
    seedColor: Colors.blue,
    brightness: Brightness.light,
    tertiary: Colors.black,
    onTertiary: Colors.grey[200],
    primaryContainer: AppColor.kDarkGreyColor,
    shadow: Colors.grey[300],
  ),
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: Colors.grey[300]),
);

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: AppColor.kDarkGreyColor,
  bottomSheetTheme:
      const BottomSheetThemeData(backgroundColor: AppColor.kDarkGreyColor),
  colorScheme: ColorScheme.fromSeed(
    primary: AppColor.kWhitColor,
    seedColor: Colors.indigo,
    brightness: Brightness.dark,
    tertiary: Colors.white,
    onTertiary: Colors.grey[600],
    primaryContainer: AppColor.kGreyColor,
    shadow: Colors.black,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColor.kDarkGreyColor),
);

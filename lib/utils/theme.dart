import 'package:expense_app/utils/colors.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  bottomAppBarTheme: const BottomAppBarTheme(color: AppColor.kWhitColor),
  scaffoldBackgroundColor: AppColor.kWhitColor,
  colorScheme: ColorScheme.fromSeed(
    primary: AppColor.kDarkGreyColor,
    onPrimary: AppColor.kWhitColor,
    seedColor: AppColor.kWhitColor,
    brightness: Brightness.light,
    primaryContainer: AppColor.kDarkGreyColor,
    shadow: AppColor.kGreyColor.withOpacity(0.6),
    tertiary: AppColor.kWhitColor,
    onPrimaryContainer: AppColor.kGreyColor.withOpacity(0.4),
    
  ),
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: Colors.grey[300]),
);

ThemeData darkTheme = ThemeData(
  bottomAppBarTheme: const BottomAppBarTheme(color: AppColor.kDarkGreyColor),
  scaffoldBackgroundColor: AppColor.kDarkGreyColor,
  bottomSheetTheme:
      const BottomSheetThemeData(backgroundColor: AppColor.kDarkGreyColor),
  colorScheme: ColorScheme.fromSeed(
      primary: AppColor.kWhitColor,
      onPrimary: AppColor.kDarkGreyColor,
      seedColor: Colors.indigo,
      brightness: Brightness.dark,
      tertiary: Colors.white,
      primaryContainer: AppColor.kGreyColor,
      shadow: AppColor.kGreyColor,
      onPrimaryContainer: AppColor.kGreyColor.withOpacity(0.4)),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColor.kDarkGreyColor),
);

import 'package:expense_app/core/theme/neu_theme.dart';
import 'package:expense_app/core/utils/colors.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  extensions: const [NeuColors.light],
  // Background matches the neumorphic surface so raised/inset shadows read.
  appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFE8EBF0)),
  bottomAppBarTheme: const BottomAppBarThemeData(color: Color(0xFFE8EBF0)),
  scaffoldBackgroundColor: const Color(0xFFE8EBF0),
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
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColor.kDarkGreyColor),
);

ThemeData darkTheme = ThemeData(
  extensions: const [NeuColors.dark],
  // Background matches the neumorphic surface so raised/inset shadows read.
  bottomAppBarTheme: const BottomAppBarThemeData(color: Color(0xFF24262B)),
  scaffoldBackgroundColor: const Color(0xFF24262B),
  bottomSheetTheme:
      const BottomSheetThemeData(backgroundColor: Color(0xFF24262B)),
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

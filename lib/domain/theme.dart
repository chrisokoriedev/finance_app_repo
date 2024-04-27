import 'package:expense_app/provider/local_auth.dart';
import 'package:expense_app/provider/theme.dart';
import 'package:expense_app/utils/string_app.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class ThemeStateProvider extends StateNotifier {
//   final Ref ref;
//   final SharedPreferences sharedPreferences;
//   ThemeStateProvider(super.state, this.ref, this.sharedPreferences);

//   ThemeMode currentTheme = ThemeMode.light;
//   ThemeMode get themeData => currentTheme;

//   Future loadTheme() async {
//     final themeState = ref.watch(themeProvider);
//     if (themeState == true) {
//       currentTheme = ThemeMode.light;
//     } else if (themeState == false) {
//       currentTheme = ThemeMode.dark;
//     } else {
//       currentTheme = ThemeMode.system;
//     }
//     return state = currentTheme;
//   }

//   Future switchTheme(bool newThemState) async {
//     final themeState = ref.watch(themeProvider);

//     if (themeState == true) {
//       currentTheme = ThemeMode.light;
//       sharedPreferences.setBool(AppString.theme, themeState);
//     } else if (themeState == false) {
//       currentTheme = ThemeMode.dark;
//       sharedPreferences.setBool(AppString.theme, themeState);
//     }

//     state = currentTheme;
//   }
// }


class ThemeStateProvider extends StateNotifier {
  final Ref ref;
  final SharedPreferences sharedPreferences;

  ThemeStateProvider(super.state, this.ref)
      : sharedPreferences = ref.watch(sharedPreferencesProvider);

  Future<void> switchTheme(bool newThemeState) async {
    state = newThemeState ? ThemeMode.light : ThemeMode.dark;
    await sharedPreferences.setBool(AppString.theme, newThemeState);
  }
}

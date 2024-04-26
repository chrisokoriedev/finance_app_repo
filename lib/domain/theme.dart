import 'package:expense_app/provider/theme.dart';
import 'package:expense_app/utils/string_app.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeStateProvider extends StateNotifier {
  final Ref ref;
  final SharedPreferences sharedPreferences;
  ThemeStateProvider(super.state, this.ref, this.sharedPreferences);

  ThemeMode _currentTheme = ThemeMode.light; 
  ThemeMode get themeData => _currentTheme;

  Future loadTheme() async {
    final themeState = ref.watch(themeProvider);
    if (themeState == true) {
      _currentTheme = ThemeMode.light;
    } else if (themeState == false) {
      _currentTheme = ThemeMode.dark;
    } else {
      _currentTheme = ThemeMode.system;
    }
    return state = _currentTheme;
  }

  Future switchTheme() async {
    final themeState = ref.watch(themeProvider);

    if (themeState == true) {
      _currentTheme = ThemeMode.light;
      sharedPreferences.setBool(AppString.theme, themeState);
    } else if (themeState == false) {
      _currentTheme = ThemeMode.dark;
      sharedPreferences.setBool(AppString.theme, themeState);
    }
    state = _currentTheme;
  }
}

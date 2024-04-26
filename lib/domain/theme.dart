import 'package:expense_app/provider/local_auth.dart';
import 'package:expense_app/utils/string_app.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeStateNofiter = StateNotifierProvider((ref) =>
    ThemeStateProvider(ref, ref, ref.watch(sharedPreferencesProvider)));

class ThemeStateProvider extends StateNotifier {
  final Ref ref;
  final SharedPreferences sharedPreferences;
  ThemeStateProvider(super.state, this.ref, this.sharedPreferences);
  ThemeMode _currentTheme = ThemeMode.system;
  ThemeMode get themeData => _currentTheme;
  Future loadTheme() async {
    if (sharedPreferences.getBool(AppString.theme) == true) {
      _currentTheme = ThemeMode.light;
    } else {
      _currentTheme = ThemeMode.dark;
    }
    return _currentTheme;
  }

  Future<void> switchTheme() async {
    await sharedPreferences.setBool(
        AppString.theme, _currentTheme == ThemeMode.light ? true : false);
  }
}

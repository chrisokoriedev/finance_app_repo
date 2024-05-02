import 'package:expense_app/provider/local_auth.dart';
import 'package:expense_app/utils/string_app.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

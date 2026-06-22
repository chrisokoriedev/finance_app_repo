import 'package:expense_app/core/provider/local_auth.dart';
import 'package:expense_app/core/utils/string_app.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeStateProvider extends StateNotifier<String> {
  final Ref ref;
  final SharedPreferences sharedPreferences;

  ThemeStateProvider(super.state, this.ref)
      : sharedPreferences = ref.watch(sharedPreferencesProvider);

  Future<void> switchTheme(String themeName) async {
    state = themeName;
    await sharedPreferences.setString(AppString.theme, themeName);
  }
}

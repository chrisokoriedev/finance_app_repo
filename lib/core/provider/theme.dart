import 'package:expense_app/core/domain/theme.dart';
import 'package:expense_app/core/provider/local_auth.dart';
import 'package:expense_app/core/utils/string_app.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final themeProvider = StateProvider.autoDispose<String>((ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  try {
    return sharedPreferences.getString(AppString.theme) ?? 'cyber_charcoal';
  } catch (e) {
    // If the stored value was a boolean from the legacy version, getString will throw.
    // Clean it up and fall back to the default theme.
    sharedPreferences.remove(AppString.theme);
    return 'cyber_charcoal';
  }
});

final themeStateNofiter =
    StateNotifierProvider.autoDispose<ThemeStateProvider, String>((ref) {
  final initialTheme = ref.watch(themeProvider);
  return ThemeStateProvider(initialTheme, ref);
});

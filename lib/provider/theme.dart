import 'package:expense_app/domain/theme.dart';
import 'package:expense_app/provider/local_auth.dart';
import 'package:expense_app/utils/string_app.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final themeProvider = StateProvider.autoDispose((ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  return sharedPreferences.getBool(AppString.theme) ?? false;
});

final themeStateNofiter =
    StateNotifierProvider.autoDispose((ref) => ThemeStateProvider(ref, ref));

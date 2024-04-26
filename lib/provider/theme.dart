import 'package:expense_app/domain/theme.dart';
import 'package:expense_app/provider/local_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final themeStateNofiter = StateNotifierProvider((ref) =>
    ThemeStateProvider(ref, ref, ref.watch(sharedPreferencesProvider)));

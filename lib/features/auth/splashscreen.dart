import 'package:expense_app/core/provider/local_auth.dart';
import 'package:expense_app/core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SplashScreen extends HookConsumerWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Read the biometric flag synchronously (it is backed by SharedPreferences
    // already loaded at startup) so the splash routes without a loading flicker.
    final enabled = ref.watch(biometricAuthStateProvider);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.pushReplacement(
          enabled ? AppRouter.bioScreen : AppRouter.mainControl);
    });
    return const SizedBox.shrink();
  }
}

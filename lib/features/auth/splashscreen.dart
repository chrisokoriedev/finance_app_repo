import 'package:expense_app/provider/local_auth.dart';
import 'package:expense_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SplashScreen extends HookConsumerWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(biometricAuthStateFutureProvider);
    return provider.when(
      data: (enabled) {
        if (enabled) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            context.push(AppRouter.bioScreen);
          });
        } else {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            context.push(AppRouter.mainControl);
          });
        }
        return const SizedBox.shrink();
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stackTrace) {
        debugPrint('Error checking biometrics: $error');
        debugPrint('StackTrace: $stackTrace');
        return const Text('Error checking biometrics. Please try again later.');
      },
    );
  }
}

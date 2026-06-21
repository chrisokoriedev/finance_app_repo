import 'package:expense_app/core/provider/app_provider.dart';
import 'package:expense_app/core/provider/firebase.dart';
import 'package:expense_app/core/theme/neu_theme.dart';
import 'package:expense_app/core/utils/const.dart';
import 'package:expense_app/core/utils/routes.dart';
import 'package:expense_app/core/utils/text.dart';
import 'package:expense_app/core/utils/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BioAuthScreen extends HookConsumerWidget {
  const BioAuthScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceSize = MediaQuery.of(context).size;
    final firebaseAuth = ref.watch(firebaseAuthProvider);
    final neu = context.neu;

    ref.listen(bioAuthNotifierProvider, (previous, next) {
      next.maybeWhen(
          orElse: () => null,
          success: (message) {
            EasyLoading.showSuccess('Welcome back')
                // ignore: use_build_context_synchronously
                .then((value) => context.push(AppRouter.mainControl));
          },
          failed: (message) {
            EasyLoading.showError('Not recognised');
          });
    });

    void login() =>
        ref.read(bioAuthNotifierProvider.notifier).loginBioWithLocalAuth();

    return Scaffold(
      backgroundColor: neu.surface,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w)
              .copyWith(top: deviceSize.height * 0.12, bottom: 6.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: neu.surface,
                  boxShadow: neu.raised,
                ),
                child: SizedBox(
                  width: 22.w,
                  height: 22.w,
                  child: UserAvatar(firebaseAuth: firebaseAuth),
                ),
              ),
              Gap(2.5.h),
              TextWidget(
                  text: getUserName(),
                  fontSize: 18.sp,
                  color: neu.textPrimary,
                  fontWeight: FontWeight.w500),
              Gap(0.6.h),
              TextWidget(
                  text: 'Welcome back',
                  fontSize: 13.sp,
                  color: neu.textSecondary),
              const Spacer(),
              GestureDetector(
                onTap: login,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: neu.surface,
                    boxShadow: neu.raised,
                  ),
                  child:
                      Icon(Icons.fingerprint, size: 28.sp, color: neu.primary),
                ),
              ),
              Gap(2.h),
              TextButton(
                onPressed: login,
                child: TextWidget(
                    text: 'Tap to unlock with fingerprint',
                    fontSize: 13.sp,
                    color: neu.textSecondary,
                    fontWeight: FontWeight.w500),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:expense_app/notifer/local_auth.dart';
import 'package:expense_app/provider/firebase.dart';
import 'package:expense_app/utils/const.dart';
import 'package:expense_app/utils/routes.dart';
import 'package:expense_app/utils/text.dart';
import 'package:expense_app/utils/user_avatar.dart';
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
    final theme = Theme.of(context).colorScheme;

    ref.listen(bioAuthNotifierProviderII, (previous, next) {
      next.maybeWhen(
          orElse: () => null,
          success: (message) {
            EasyLoading.showSuccess('Am in')
                // ignore: use_build_context_synchronously
                .then((value) => context.push(AppRouter.mainControl));
          },
          failed: (message) {
            EasyLoading.showError('Not regonised');
          });
    });
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 50.sp)
          .copyWith(top: deviceSize.height * 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 20.w,
            child: UserAvatar(firebaseAuth: firebaseAuth),
          ),
          Gap(3.h),
          TextWigdet(
              text: getUserName(), fontSize: 20.sp, color: theme.primary),
          Gap(3.h),
          GestureDetector(
            onTap: () => ref
                .read(bioAuthNotifierProviderII.notifier)
                .loginBioWithLocalAuth(),
            child: Icon(
              Icons.fingerprint_sharp,
              size: 30.sp,
            ),
          ),
          Gap(2.h),
          TextButton(
            onPressed: () => ref
                .read(bioAuthNotifierProviderII.notifier)
                .loginBioWithLocalAuth(),
            child: TextWigdet(
                text: 'Click to login with fingerprint',
                fontSize: 14.sp,
                color: theme.primary,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

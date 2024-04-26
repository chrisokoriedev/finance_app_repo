import 'package:expense_app/features/Porfile/profile.dart';
import 'package:expense_app/notifer/auth_notifer.dart';
import 'package:expense_app/notifer/create_expense_notifer.dart';
import 'package:expense_app/utils/const.dart';
import 'package:expense_app/utils/routes.dart';
import 'package:expense_app/utils/switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'widget/delete_acct.dart';

final emailValidationProvider = StateProvider.autoDispose<bool>((ref) => false);

class SettingAndSupport extends HookConsumerWidget {
  const SettingAndSupport({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authNotifierProvider, (previous, next) {
      next.maybeWhen(
        orElse: () => null,
        authenticated: (user) async {
          EasyLoading.showSuccess('User Account Deleted');
          context.pushReplacement(AppRouter.authScreen);
        },
        unauthenticated: (message) {
          EasyLoading.showError(message!);
        },
      );
    });
    ref.listen(createExpenseNotifierProvider, (previous, next) {
      next.maybeWhen(
        orElse: () => null,
        success: (message) async {
          EasyLoading.showSuccess(message!);
          context.pop();
        },
        failed: (message) {
          EasyLoading.showError(message!);
        },
      );
    });
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 20.sp),
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CustomButton(
                title: 'Biometrie',
                icons: LineIcons.fingerprint,
                showLastWidget: true,
                lastWidget: CustomSwitch()),
            const CustomButton(
                title: 'Light Mode',
                icons: LineIcons.lightbulb,
                showLastWidget: true,
                lastWidget: CustomSwitch()),
            const CustomButton(
              title: 'Email us',
              icons: LineIcons.facebookMessenger,
              press: launchEmail,
            ),
            const CustomButton(
              title: 'Donate to us',
              icons: LineIcons.gift,
              press: launchDonation,
            ),
            CustomButton(
              title: 'Clear all data',
              icons: LineIcons.userInjured,
              press: () {
                ref
                    .read(createExpenseNotifierProvider.notifier)
                    .deleteUserRecord();
              },
            ),
            CustomButton(
              title: 'Delete Account',
              icons: LineIcons.userInjured,
              margin: 0,
              press: () => showModalBottomSheet(
                  context: context,
                  builder: (context) => const DeleteUserAccount()),
            ),
          ],
        ),
      ],
    );
  }
}

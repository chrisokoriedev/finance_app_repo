import 'package:expense_app/features/Porfile/profile.dart';
import 'package:expense_app/notifer/auth_notifer.dart';
import 'package:expense_app/notifer/create_expense_notifer.dart';
import 'package:expense_app/provider/firebase.dart';
import 'package:expense_app/utils/colors.dart';
import 'package:expense_app/utils/const.dart';
import 'package:expense_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 20.sp),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomButton(
            title: 'Biometrie',
            icons: LineIcons.fingerprint,
            press: () => showModalBottomSheet(
                context: context, builder: (_) => const CommingSoon()),
          ),
          CustomButton(
            title: 'Light Mode',
            icons: LineIcons.lightbulb,
            press: () => showModalBottomSheet(
                context: context, builder: (_) => const CommingSoon()),
          ),
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
    );
  }
}

class DeleteUserAccount extends HookConsumerWidget {
  const DeleteUserAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String emailText = '';
    final firebaseProvider = ref.watch(firebaseAuthProvider);
    final emailValidation = ref.watch(emailValidationProvider);
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 20.sp)
          .copyWith(bottom: MediaQuery.of(context).viewInsets.bottom + 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Delete User Account',
              style: TextStyle(fontSize: 16.sp, color: AppColor.kBlackColor)),
          Gap(2.h),
          CustomTextFormField(
              hintText: 'Enter current email account',
              textInputType: TextInputType.text,
              maxLine: 1,
              onChanged: (value) {
                emailText = value;
                ref.read(emailValidationProvider.notifier).state =
                    emailText == firebaseProvider.currentUser!.email;
              }),
          Gap(2.h),
          ElevatedButton(
              style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(
                    Size(double.maxFinite, 2.h),
                  ),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: customBorderRadius(10))),
                  backgroundColor: MaterialStateColor.resolveWith((states) =>
                      emailValidation
                          ? AppColor.kGreenColor.shade300
                          : AppColor.kredColor.shade300)),
              onPressed: emailValidation
                  ? () {
                      context.pop();
                      context.pop();
                      ref
                          .read(authNotifierProvider.notifier)
                          .deleteUserAccount();
                    }
                  : null,
              child: Text('Delete Account',
                  style:
                      TextStyle(fontSize: 14.sp, color: AppColor.kWhitColor))),
        ],
      ),
    );
  }
}

launchEmail() async {
  const email = 'okoriec01@gmail.com';
  const subject = 'App Feedback';
  const body = 'Type here...';

  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: email,
    queryParameters: {
      'subject': subject,
      'body': body,
    },
  );
  await launchUrl(emailLaunchUri);
}

launchDonation() async =>
    await launchUrl(Uri.parse('https://justpaga.me/ChrisIuil'));

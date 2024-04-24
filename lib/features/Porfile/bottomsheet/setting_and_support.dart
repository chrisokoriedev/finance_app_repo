import 'package:expense_app/features/Porfile/profile.dart';
import 'package:expense_app/notifer/auth_notifer.dart';
import 'package:expense_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingAndSupport extends HookConsumerWidget {
  const SettingAndSupport({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
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
          const CustomButton(
            title: 'Clear all data',
            icons: LineIcons.userInjured,
          ),
          const CustomButton(
            title: 'Delete Account',
            icons: LineIcons.userInjured,
            margin: 0,
          ),
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

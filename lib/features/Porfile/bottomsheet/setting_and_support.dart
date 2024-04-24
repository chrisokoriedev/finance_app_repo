import 'package:expense_app/features/Porfile/profile.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingAndSupport extends StatelessWidget {
  const SettingAndSupport({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 20.sp),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Under Development this is a demo"),
          CustomButton(
            title: 'Biometrie',
            icons: LineIcons.fingerprint,
          ),
          CustomButton(
            title: 'Light Mode',
            icons: LineIcons.lightbulb,
          ),
          CustomButton(
            title: 'Email us',
            icons: LineIcons.facebookMessenger,
            press: launchEmail,
          ),
          CustomButton(
            title: 'Donate to us',
            icons: LineIcons.gift,
            press: launchDonation,
          ),
          CustomButton(
            title: 'Clear all data',
            icons: LineIcons.userInjured,
          ),
          CustomButton(
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

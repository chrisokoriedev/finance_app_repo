import 'package:expense_app/features/Porfile/profile.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
          ),
          CustomButton(
            title: 'Donate to us',
            icons: LineIcons.gift,
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

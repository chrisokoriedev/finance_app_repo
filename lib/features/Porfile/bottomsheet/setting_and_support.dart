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
          CustomButton(
            title: 'Biometrie',
            icons: LineIcons.fingerprint,
          ),
          CustomButton(
            title: 'Feedback',
            icons: LineIcons.wonSign,
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


import 'package:expense_app/utils/colors.dart';
import 'package:expense_app/utils/text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:line_icons/line_icon.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomButton extends StatelessWidget {
  final IconData icons;
  final String? title;
  final Color? color;
  final double? margin;
  final Widget? lastWidget;
  final bool? showLastWidget;
  final VoidCallback? press;
  const CustomButton(
      {super.key,
      this.title,
      this.color,
      this.press,
      required this.icons,
      this.margin = 20,
      this.lastWidget,
      this.showLastWidget = false});

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: press,
      child: Container(
        width: double.infinity,
        alignment: Alignment.centerLeft,
        height: 5.h,
        margin: EdgeInsets.only(bottom: margin!.sp),
        padding: EdgeInsets.symmetric(horizontal: 15.sp),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.sp),
            color: theme.primaryContainer.withOpacity(1.0.sp)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                LineIcon(icons),
                Gap(2.w),
                TextWigdet(text: title!, fontSize: 15.sp, letterSpacing: 1.5),
              ],
            ),
            if (showLastWidget ?? false) lastWidget ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

import 'package:expense_app/core/theme/neu_theme.dart';
import 'package:expense_app/core/utils/text.dart';
import 'package:expense_app/core/widgets/neu.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
    final neu = context.neu;
    final tint = color ?? neu.primary;
    return GestureDetector(
      onTap: press,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: margin!.sp),
        padding: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 1.3.h),
        decoration: BoxDecoration(
          color: neu.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: neu.raised,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                NeuIconWell(icon: icons, color: tint, size: 38, radius: 12),
                Gap(3.5.w),
                TextWidget(
                    text: title!,
                    color: color ?? neu.textPrimary,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500),
              ],
            ),
            if (showLastWidget ?? false)
              lastWidget ?? const SizedBox.shrink()
            else
              Icon(Icons.chevron_right, color: neu.textSecondary, size: 18.sp),
          ],
        ),
      ),
    );
  }
}

import 'package:expense_app/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // SizedBox.expand fills its parent whether or not it sits inside a Stack,
    // so this overlay can't crash with a `Positioned` outside a Stack.
    return SizedBox.expand(
      child: ColoredBox(
        color: AppColor.kDarkGreyColor.withOpacity(0.7),
        child: Center(
          child: Container(
            width: 20.w,
            height: 10.h,
            decoration: BoxDecoration(
                color: AppColor.kBlackColor,
                borderRadius: BorderRadius.circular(10.sp)),
            child: const Center(
                child: CircularProgressIndicator(
              color: AppColor.kWhitColor,
            )),
          ),
        ),
      ),
    );
  }
}

import 'package:expense_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 0,
        left: 0,
        right: 0,
        bottom: 0,
        child: Container(
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
        ));
  }
}
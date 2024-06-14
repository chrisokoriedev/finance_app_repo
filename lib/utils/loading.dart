import 'package:expense_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Container(
      color: theme.onPrimary,
      child: Center(
        child: Container(
          width: 20.w,
          height: 10.h,
          decoration: BoxDecoration(
              color: AppColor.kBlackColor,
              borderRadius: BorderRadius.circular(10.sp)),
          child: const Center(
              child: SpinKitCubeGrid(
            color: AppColor.kWhitColor,
          )),
        ),
      ),
    );
  }
}
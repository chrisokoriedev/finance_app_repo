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
            color: theme.onPrimary,
            borderRadius: BorderRadius.circular(10.sp),
            boxShadow: [
          BoxShadow(
              blurRadius: 10,
              offset: const Offset(0, 1),
              color: AppColor.lightGrey.withOpacity(0.5))
        ]
          ),
          child:  Center(
              child: SpinKitCubeGrid(
            color: theme.primary,
          )),
        ),
      ),
    );
  }
}

import 'package:expense_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CreateExpenseView extends StatelessWidget {
  const CreateExpenseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                height: 32.h,
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: AppColor.kBlackColor,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(30.sp),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
              top: 150,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 80.w,
                  height: 50.h,
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 6.h),
                  decoration: BoxDecoration(
                      color: AppColor.kWhitColor,
                      borderRadius: BorderRadius.circular(10.sp),
                      boxShadow: [
                        BoxShadow(
                            color: AppColor.kBlackColor.withOpacity(0.4),
                            offset: const Offset(0, 6),
                            blurRadius: 12,
                            spreadRadius: 6)
                      ]),
                ),
              ))
        ],
      ),
    );
  }
}

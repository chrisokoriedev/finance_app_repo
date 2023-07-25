import 'package:expense_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                    bottom: Radius.circular(25.sp),
                  ),
                ),
                child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Good Morning',
                              style: TextStyle(
                                  color: AppColor.kWhitColor,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'Christian Okorie',
                              style: TextStyle(
                                  color: AppColor.kWhitColor,
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Container(
                          width: Adaptive.w(10),
                          height: 5.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7.sp),
                              color: Colors.grey.shade900),
                          child: LineIcon.bell(
                            color: AppColor.kWhitColor,
                            size: 18.sp,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 180,
            left: 29,
            child: Container(
              width: Adaptive.w(85),
              padding: EdgeInsets.all(15.sp),
              height: 15.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(15.sp),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Balance',
                        style: TextStyle(
                            color: AppColor.kWhitColor,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      LineIcon.horizontalEllipsis(color: AppColor.kWhitColor,size: 16.sp,)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

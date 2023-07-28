import 'package:expense_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:line_icons/line_icon.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'model/day_model.dart';

final selectedTabProvider = StateProvider<int>((ref) => 0);

class Statistics extends ConsumerWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var selectedTab = ref.watch(selectedTabProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                children: [
                  Gap(5.h),
                  Text(
                    'Statistics',
                    style: TextStyle(
                      fontSize: 17.sp,
                      color: AppColor.kBlackColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gap(2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      4,
                      (index) => GestureDetector(
                        onTap: () => ref
                            .read(selectedTabProvider.notifier)
                            .state = index,
                        child: Chip(
                          elevation: 0.0,
                          backgroundColor: selectedTab == index
                              ? AppColor.kBlackColor
                              : AppColor.kWhitColor,
                          label: Text(
                            dayType[index],
                            style: TextStyle(
                              fontSize: 13.sp,
                              letterSpacing: 1.7,
                              fontWeight: FontWeight.w500,
                              color: selectedTab == index
                                  ? AppColor.kWhitColor
                                  : AppColor.kBlackColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Gap(1.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Chip(
                        label: Row(
                          children: [
                            Text(
                              'Expense',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Gap(2.w),
                            LineIcon.arrowDown(
                              size: 15.px,
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

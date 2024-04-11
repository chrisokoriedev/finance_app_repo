import 'package:expense_app/provider/item_provider.dart';
import 'package:expense_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:line_icons/line_icon.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'chart_view.dart';
import 'model/day_model.dart';

final selectedTabProvider = StateProvider<int>((ref) => 0);

class Statistics extends ConsumerWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(selectedTabProvider);
    final itemProvider = ref.watch(itemsProvider);
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(5.h),
                Center(
                  child: Text(
                    'Statistics',
                    style: TextStyle(
                      fontSize: 17.sp,
                      color: AppColor.kBlackColor,
                      fontWeight: FontWeight.w700,
                    ),
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
                              fontSize: 15.sp,
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
                ),
                Gap(2.5.h),
                const ChartComponent(),
                Gap(2.5.h),
                Row(
                  children: [
                    Text(
                      'Top Spending',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColor.kBlackColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Gap(1.w),
                    LineIcon.wallet(
                      size: 16.sp,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

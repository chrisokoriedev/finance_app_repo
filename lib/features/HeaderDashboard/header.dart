// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:expense_app/domain/cal.dart';
import 'package:expense_app/provider/firebase.dart';
import 'package:expense_app/provider/item_provider.dart';
import 'package:expense_app/utils/colors.dart';
import 'package:expense_app/utils/const.dart';
import 'package:expense_app/utils/text.dart';
import 'package:expense_app/utils/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icon.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'controller/time_controller.dart';

class DashboardHeader extends ConsumerWidget {
  final PageController pageCntrl;
  const DashboardHeader(this.pageCntrl, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totals = ref.watch(totalStateProvider);
    final cloud = ref.watch(cloudItemsProvider);
    final greeting = ref.watch(greetingProvider);
    final firebaseAuth = ref.watch(firebaseAuthProvider);
    final theme = Theme.of(context).colorScheme;

    return cloud.when(
        data: (data) {
          ref.read(totalStateProvider.notifier).state.calculateTotals(data);
          return Stack(
            children: [
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 30.h,
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: theme.primaryContainer.withOpacity(1.5.sp),
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
                                TextWigdet(
                                  text: _getGreetingText(greeting),
                                  color: theme.primary,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                TextWigdet(
                                  text: getUserName(),
                                  color: theme.primary,
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () => pageCntrl.jumpToPage(3),
                              child: SizedBox(
                                  width: Adaptive.w(10),
                                  height: 5.h,
                                  child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(30.sp),
                                      child: UserAvatar(
                                          firebaseAuth: firebaseAuth))),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 180,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: Adaptive.w(90),
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: theme.onPrimary,
                      borderRadius: BorderRadius.circular(15.sp),
                      boxShadow: [
                        BoxShadow(
                          color: theme.primaryContainer.withOpacity(1.5.sp),
                          offset: const Offset(0, 6),
                          blurRadius: 12,
                          spreadRadius: 6,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextWigdet(
                              text: 'Total Balance',
                              color: theme.primary,
                              fontSize: 15.sp,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w400,
                            ),
                            LineIcon.horizontalEllipsis(
                              color: theme.primary,
                              size: 16.sp,
                            ),
                          ],
                        ),
                        Gap(0.3.h),
                        TextWigdet(
                          text: "₦${totals.state.grandTotal}",
                          color: theme.primary,
                          fontSize: 18.sp,
                          letterSpacing: 1.7,
                          fontWeight: FontWeight.w500,
                        ),
                        Gap(1.5.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildExpenseDashBoardComponent(
                                'Income',
                                LineIcon.lineChart(
                                  size: 17.sp,
                                  color: AppColor.kWhitColor,
                                ),
                                '${totals.state.totalIncome}',
                                AppColor.kGreenColor),
                            _buildExpenseDashBoardComponent(
                                'Expense',
                                LineIcon.barChartAlt(
                                  size: 17.sp,
                                  color: AppColor.kWhitColor,
                                ),
                                '${totals.state.totalExpense}',
                                AppColor.kredColor),
                            _buildExpenseDashBoardComponent(
                                'Debt',
                                LineIcon.areaChart(
                                  size: 17.sp,
                                  color: AppColor.kWhitColor,
                                ),
                                '${totals.state.totalDebt}',
                                AppColor.kBlueColor),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        error: (error, stackTrace) => const Text('Error fetching data'),
        loading: () => const CircularProgressIndicator());
  }

  String _getGreetingText(Greeting greeting) {
    switch (greeting) {
      case Greeting.morning:
        return 'Good Morning';
      case Greeting.afternoon:
        return 'Good Afternoon';
      case Greeting.evening:
        return 'Good Evening';
      default:
        return '';
    }
  }

  Widget _buildExpenseDashBoardComponent(
      String title, Widget icon, String amount, Color dataColor) {
    return BuildExpenseDashBoardComponent(
      title: title,
      icon: icon,
      amount: amount,
      dataColor: dataColor,
    );
  }
}

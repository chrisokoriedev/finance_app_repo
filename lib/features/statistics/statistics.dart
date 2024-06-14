import 'dart:math';

import 'package:expense_app/model/create_expense.dart';
import 'package:expense_app/provider/item_provider.dart';
import 'package:expense_app/utils/colors.dart';
import 'package:expense_app/utils/const.dart';
import 'package:expense_app/utils/loading.dart';
import 'package:expense_app/utils/string_app.dart';
import 'package:expense_app/utils/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:line_icons/line_icon.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'chart_view.dart';
import 'model/day_model.dart';

final selectedTabProvider = StateProvider<int>((ref) => 0);
final expenseItemTypeProvider =
    StateProvider<String>((ref) => AppString.income);

class Statistics extends ConsumerWidget {
  final PageController pageController;
  const Statistics(this.pageController, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).colorScheme;

    final selectedTab = ref.watch(selectedTabProvider);
    final itemProvider = ref.watch(cloudItemsProvider);
    final expenseType = ref.watch(expenseItemTypeProvider);
    return PopScope(
      canPop: false,
      onPopInvoked: (value) => pageController.jumpToPage(0),
      child: itemProvider.when(
        error: (_, __) => Text(
          'Error $__',
        ),
        loading: () => const LoadingWidget(),
        data: (data) {
          List<CreateExpenseModel> expenseData = data
              .where((expense) => expense.expenseType == expenseType)
              .toList()
            ..sort((a, b) => b.amount.compareTo(a.amount));

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IntrinsicWidth(
                  stepWidth: double.infinity,
                  stepHeight: 2.h,
                  child: Column(children: [
                    Gap(5.h),
                    Center(
                      child: TextWigdet(
                        text: 'Statistics',
                        fontSize: 17.sp,
                        color: theme.primary,
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
                            side: BorderSide.none,
                            backgroundColor: selectedTab == index
                                ? AppColor.kBlackColor
                                : AppColor.kGreyColor.withOpacity(0.8.spa),
                            label: Text(
                              dayType[index],
                              style: TextStyle(
                                fontSize: 13.sp,
                                letterSpacing: 1.7,
                                fontWeight: FontWeight.w500,
                                color: selectedTab == index
                                    ? theme.tertiary
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
                          label: SizedBox(
                            width: 20.w,
                            height: 2.h,
                            child: DropdownButton<String>(
                              value: expenseType,
                              underline: Container(),
                              isExpanded: true,
                              hint: Text(
                                'Type',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: AppColor.kBlackColor),
                              ),
                              selectedItemBuilder: (context) => expenseListType
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(
                                        e,
                                        style: TextStyle(
                                            fontSize: 13.9.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              items: expenseListType
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(
                                        e,
                                        style: TextStyle(
                                            fontSize: 13.9.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                ref
                                    .read(expenseItemTypeProvider.notifier)
                                    .state = value!;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(children: [
                      const ChartComponent(),
                      Gap(2.5.h),
                      Row(
                        children: [
                          TextWigdet(
                            text: 'Top $expenseType',
                            fontSize: 14.sp,
                            color: theme.primary,
                            fontWeight: FontWeight.w700,
                          ),
                          Gap(2.w),
                          LineIcon.wallet(
                            size: 18.sp,
                            color: switch (expenseType) {
                              AppString.income => AppColor.kGreenColor,
                              AppString.expenses => AppColor.kredColor,
                              AppString.debt => AppColor.kBlueColor,
                              _ => AppColor.kGreyColor,
                            },
                          )
                        ],
                      ),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: expenseData.isNotEmpty
                              ? min(expenseData.length, 5)
                              : 1,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            if (expenseData.isEmpty) {
                              return const NoDataView();
                            }

                            final history = expenseData[index];
                            Icon iconData;
                            if (history.expenseType == AppString.income) {
                              iconData = LineIcon.wallet(
                                size: 18.sp,
                                color: AppColor.kGreenColor,
                              );
                            } else if (history.expenseType ==
                                AppString.expenses) {
                              iconData = LineIcon.alternateWavyMoneyBill(
                                size: 18.sp,
                                color: AppColor.kredColor,
                              );
                            } else {
                              iconData = LineIcon.alternateWavyMoneyBill(
                                size: 18.sp,
                                color: AppColor.kBlueColor,
                              );
                            }
                            return ListTile(
                              title: Row(
                                children: [
                                  TextWigdet(
                                      text:
                                          '${history.expenseType}\tfor\t${history.name}',
                                      color: theme.primary,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600),
                                ],
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWigdet(
                                      text: history.explain,
                                      color: theme.primary,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600),
                                ],
                              ),
                              leading: iconData,
                              trailing: TextWigdet(
                                  text: history.amount.toString(),
                                  color: theme.primary,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600),
                            );
                          })
                    ]),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'dart:math';

import 'package:expense_app/model/create_expense.dart';
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
final expenseItemTypeProvider =
    StateProvider.autoDispose<String>((ref) => 'Income');
List<String> expenseListType = [
  'Expense',
  'Income',
  'Debt',
];

class Statistics extends ConsumerWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(selectedTabProvider);
    final itemProvider = ref.watch(itemsProvider);
    final expenseType = ref.watch(expenseItemTypeProvider);
    return itemProvider.when(
      error: (_, __) => Text('Error $__'),
      loading: () => const Center(child: CircularProgressIndicator()),
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
                                  fontSize: 14.sp, color: AppColor.kBlackColor),
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
                              ref.read(expenseItemTypeProvider.notifier).state =
                                  value!;
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
                        Text(
                          'Top $expenseType',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColor.kBlackColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Gap(1.w),
                        LineIcon.wallet(
                          size: 18.sp,
                          color: switch (expenseType) {
                            'Income' => AppColor.kGreenColor,
                            'Expense' => AppColor.kredColor,
                            'Debt' => AppColor.kBlueColor,
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
                          final history = expenseData[index];
                          Icon iconData;
                          if (history.expenseType == "Income") {
                            iconData = LineIcon.wallet(
                              size: 18.sp,
                              color: AppColor.kGreenColor,
                            );
                          } else if (history.expenseType == "Expense") {
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
                                Text(
                                  '${history.expenseType}\tfor\t${history.name}',
                                  style: TextStyle(
                                      color: AppColor.kDarkGreyColor,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  history.explain,
                                  style: TextStyle(
                                      color: AppColor.kDarkGreyColor,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            leading: iconData,
                            trailing: Text(
                              history.amount.toString(),
                              style: TextStyle(
                                  fontSize: 18.sp, fontWeight: FontWeight.w600),
                            ),
                          );
                        })
                  ]),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

import 'package:expense_app/features/CreateExpense/create_expense_view.dart';
import 'package:expense_app/utils/colors.dart';
import 'package:expense_app/utils/const.dart';
import 'package:expense_app/utils/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';

class ExpenseTypeComponent extends ConsumerWidget {
  const ExpenseTypeComponent({
    super.key,
    required this.chooseExpense,
    required this.expenseListType,
  });

  final String chooseExpense;
  final List<String> expenseListType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      height: 5.h,
      decoration: BoxDecoration(
          color: AppColor.kGreyColor.withOpacity(0.3),
          borderRadius: customBorderRadius(10)),
      child: DropdownButton<String>(
        value: chooseExpense,
        underline: Container(),
        isExpanded: true,
        hint: Text(
          'Type',
          style: TextStyle(fontSize: 14.sp, color: AppColor.kBlackColor),
        ),
        selectedItemBuilder: (context) => expenseListType
            .map(
              (e) => DropdownMenuItem(
                value: e,
                child: TextWigdet(
                  text: e,
                  fontSize: 13.9.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
            .toList(),
        items: expenseListType
            .map(
              (e) => DropdownMenuItem(
                value: e,
                child: TextWigdet(
                  text: e,
                  fontSize: 13.9.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          ref.read(expenseItemTypeProvider.notifier).state = value!;
        },
      ),
    );
  }
}

class ExpenseSubTypeComponent extends ConsumerWidget {
  const ExpenseSubTypeComponent({
    super.key,
    required this.chooseSubExpense,
    required this.expenseSubListType,
  });

  final String chooseSubExpense;
  final List expenseSubListType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).colorScheme;
    return SizedBox(
      height: 5.h,
      child: CustomDropdown.search(
        closedHeaderPadding:
            EdgeInsets.symmetric(horizontal: 2.w, vertical: 16.sp),
        decoration: CustomDropdownDecoration(
            closedBorderRadius: customBorderRadius(10),
            headerStyle: TextStyle(
                color: theme.primary,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600),
            hintStyle: TextStyle(
                color: theme.primary,
                fontSize: 13.9.sp,
                fontWeight: FontWeight.w600),
            closedFillColor: AppColor.kGreyColor.withOpacity(0.3),
            expandedFillColor: theme.onPrimary),
        hintText: 'Select expense catergory',
        noResultFoundText: 'Cat not find any result',
        items: expenseSubListType,
        excludeSelected: false,
        onChanged: (value) => ref
            .read(expenseSubItemTypeProvider.notifier)
            .state = value.toString(),
      ),
    );
  }
}

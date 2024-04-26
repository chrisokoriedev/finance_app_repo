import 'package:expense_app/notifer/create_expense_notifer.dart';
import 'package:expense_app/state/local.dart';
import 'package:expense_app/utils/colors.dart';
import 'package:expense_app/utils/const.dart';
import 'package:expense_app/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

import 'widget/expense_type_sub_dropdown.dart';
import 'widget/submt_button.dart';

final selectedDateTimeStateProvider =
    StateProvider.autoDispose<DateTime>((ref) => DateTime.now());
final expenseItemTypeProvider =
    StateProvider.autoDispose<String>((ref) => 'Income');
final expenseSubItemTypeProvider =
    StateProvider.autoDispose<String>((ref) => '..');
final expenseAmountController = TextEditingController();
final expenseTitleController = TextEditingController();
final expenseDescripritionController = TextEditingController();

class CreateExpenseView extends ConsumerWidget {
  const CreateExpenseView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final choosedDate = ref.watch(selectedDateTimeStateProvider);
    final chooseExpense = ref.watch(expenseItemTypeProvider);
    final chooseSubExpense = ref.watch(expenseSubItemTypeProvider);
    final authState = ref.watch(createExpenseNotifierProvider);
    ref.listen(createExpenseNotifierProvider, (previous, next) {
      next.maybeWhen(
        orElse: () => null,
        success: (message) async {
          EasyLoading.showSuccess(message!);
          context.pop();
        },
        failed: (message) {
          EasyLoading.showError(message!);
        },
      );
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create data',
          style: TextStyle(
            fontSize: 17.sp,
            color: AppColor.kBlackColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 80.w,
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
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
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 9,
                            child: CustomTextFormField(
                              textEditingController: expenseTitleController,
                              hintText: 'Title',
                              textInputType: TextInputType.text,
                              maxLine: 1,
                              maxlength: 15,
                            ),
                          ),
                          Gap(2.w),
                          Flexible(
                            flex: 4,
                            child: ExpenseTypeComponent(
                                chooseExpense: chooseExpense,
                                expenseListType: expenseListType),
                          ),
                        ],
                      ),
                      Gap(2.h),
                      chooseExpense == 'Expense'
                          ? Column(
                              children: [
                                ExpenseSubTypeComponent(
                                    chooseSubExpense: chooseSubExpense,
                                    expenseSubListType: expenseSubListType),
                                Gap(2.h),
                              ],
                            )
                          : Column(
                              children: [
                                Container(),
                              ],
                            ),
                      CustomTextFormField(
                          textEditingController: expenseAmountController,
                          hintText: 'Amount',
                          textInputType: TextInputType.number,
                          maxLine: 1,
                          maxlength: 12),
                      Gap(2.h),
                      CustomTextFormField(
                        textEditingController: expenseDescripritionController,
                        hintText: 'Explain',
                        textInputType: TextInputType.text,
                        maxLine: 3,
                        maxlength: 30,
                      ),
                      Gap(2.h),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        height: 5.h,
                        decoration: BoxDecoration(
                            color: AppColor.kGreyColor.withOpacity(0.3),
                            borderRadius: customBorderRadius(10)),
                        child: GestureDetector(
                          onTap: () async {
                            DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate:
                                    ref.read(selectedDateTimeStateProvider),
                                firstDate: DateTime(2001),
                                lastDate: DateTime(2080));

                            if (newDate != null) {
                              ref
                                  .read(selectedDateTimeStateProvider.notifier)
                                  .state = newDate;
                            }
                          },
                          child: Text(
                            'Day: ${choosedDate.day} - ${choosedDate.month} - ${choosedDate.year} ',
                            style: TextStyle(
                                fontSize: 15.sp, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Gap(3.h),
                      BuildCreateDataComponent(
                        expenseTitleController: expenseTitleController,
                        expenseDescripritionController:
                            expenseDescripritionController,
                        expenseAmountController: expenseAmountController,
                        chooseExpense: chooseExpense,
                        choosedDate: choosedDate,
                        chooseSubExpense: chooseSubExpense,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (authState == const AppStateManager.loading())
            const LoadingWidget(),
        ],
      ),
    );
  }
}

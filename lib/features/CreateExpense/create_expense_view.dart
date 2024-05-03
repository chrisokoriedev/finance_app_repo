import 'package:expense_app/notifer/create_expense_notifer.dart';
import 'package:expense_app/notifer/expense_category.dart';
import 'package:expense_app/provider/item_provider.dart';
import 'package:expense_app/state/local.dart';
import 'package:expense_app/utils/colors.dart';
import 'package:expense_app/utils/const.dart';
import 'package:expense_app/utils/loading.dart';
import 'package:expense_app/utils/string_app.dart';
import 'package:expense_app/utils/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icon.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

import 'widget/expense_type_sub_dropdown.dart';
import 'widget/submt_button.dart';

final selectedDateTimeStateProvider =
    StateProvider.autoDispose<DateTime>((ref) => DateTime.now());
final expenseItemTypeProvider =
    StateProvider.autoDispose<String>((ref) => AppString.income);
final expenseSubItemTypeProvider =
    StateProvider.autoDispose<String>((ref) => '..');
final expenseAmountController = TextEditingController();
final expenseTitleController = TextEditingController();
final expenseDescripritionController = TextEditingController();

class CreateExpenseView extends HookConsumerWidget {
  const CreateExpenseView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).colorScheme;

    final choosedDate = ref.watch(selectedDateTimeStateProvider);
    final chooseExpense = ref.watch(expenseItemTypeProvider);
    final chooseSubExpense = ref.watch(expenseSubItemTypeProvider);
    final expenseCatergoryList = ref.watch(expenseListCatProvider);
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
    ref.listen(expenseCategoryNotifier, (previous, next) {
      next.maybeWhen(
        orElse: () => null,
        success: (message) async {
          EasyLoading.showSuccess(message!);
        },
        failed: (message) {
          EasyLoading.showError(message!);
        },
      );
    });
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 17.sp,
          color: AppColor.kBlackColor,
          fontWeight: FontWeight.w700,
        ),
        title: TextWigdet(
          text: 'Create data',
          color: theme.primary,
          fontSize: 17.sp,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.5,
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 10,
            bottom: 10,
            left: 10,
            right: 10,
            child: Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                width: 80.w,
                height: chooseExpense == AppString.expenses ? 58.h : 50.h,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                decoration: BoxDecoration(
                    color: theme.onPrimary,
                    borderRadius: BorderRadius.circular(10.sp),
                    boxShadow: [
                      BoxShadow(
                          color: AppColor.kGreyColor.withOpacity(1.5.sp),
                          offset: const Offset(0, 6),
                          blurRadius: 12,
                          spreadRadius: 6)
                    ]),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
                    chooseExpense == AppString.expenses
                        ? Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 10,
                                    child: expenseCatergoryList.when(
                                        data: (data) =>
                                            ExpenseSubTypeComponent(
                                                chooseSubExpense:
                                                    chooseSubExpense,
                                                expenseSubListType: [
                                                  ...expenseSubListType,
                                                  ...data
                                                ]),
                                        loading: () => const Text('data'),
                                        error: (_, __) {
                                          return Text('failed $__');
                                        }),
                                  ),
                                  Flexible(
                                      flex: 2,
                                      child: Center(
                                          child: GestureDetector(
                                              onTap: () => showModalBottomSheet(
                                                  context: context,
                                                  builder: (_) =>
                                                      const AddCategories()),
                                              child: LineIcon.plus(
                                                size: 6.w,
                                              )))),
                                ],
                              ),
                              Gap(2.h),
                            ],
                          )
                        : Container(),
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
                    GestureDetector(
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
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        height: 5.h,
                        decoration: BoxDecoration(
                            color: AppColor.kGreyColor.withOpacity(0.3),
                            borderRadius: customBorderRadius(10)),
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
            ),
          ),
          if (authState == const AppStateManager.loading())
            const LoadingWidget(),
        ],
      ),
    );
  }
}

final newCategoryText = StateProvider<String>((ref) => '');

class AddCategories extends HookConsumerWidget {
  const AddCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(expenseCategoryNotifier, (previous, next) {
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
    final authState = ref.watch(expenseCategoryNotifier);

    final text = ref.watch(newCategoryText);
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h)
          .copyWith(bottom: MediaQuery.of(context).viewInsets.bottom + 20.spa),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextFormField(
              hintText: 'Enter text',
              textInputType: TextInputType.text,
              maxLine: 1,
              onChanged: (value) =>
                  ref.read(newCategoryText.notifier).state = value),
          Gap(2.h),
          ElevatedButton(
              style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(
                    Size(double.maxFinite, 2.h),
                  ),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: customBorderRadius(10))),
                  backgroundColor: MaterialStateColor.resolveWith((states) =>
                      authState == const AppStateManager.loading()
                          ? AppColor.kGreyColor
                          : AppColor.kBlackColor)),
              onPressed: authState == const AppStateManager.loading()
                  ? null
                  : () {
                      if (text.length <= 3) {
                        EasyLoading.showInfo('too short');
                      } else if (text.length >= 16) {
                        EasyLoading.showInfo('too long');
                      } else {
                        ref
                            .read(expenseCategoryNotifier.notifier)
                            .addToList(text);
                      }
                    },
              child: TextWigdet(
                  text: authState == const AppStateManager.loading()
                      ? 'Loading'
                      : 'Add To Catogory List',
                  fontSize: 14.sp,
                  color: AppColor.kWhitColor)),
        ],
      ),
    );
  }
}

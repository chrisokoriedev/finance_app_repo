import 'package:expense_app/core/provider/app_provider.dart';
import 'package:expense_app/core/provider/item_provider.dart';
import 'package:expense_app/core/state/local.dart';
import 'package:expense_app/core/utils/const.dart';
import 'package:expense_app/core/theme/neu_theme.dart';
import 'package:expense_app/core/utils/loading.dart';
import 'package:expense_app/core/utils/string_app.dart';
import 'package:expense_app/core/utils/text.dart';
import 'package:expense_app/core/widgets/neu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
    final neu = context.neu;

    final choosedDate = ref.watch(selectedDateTimeStateProvider);
    final chooseExpense = ref.watch(expenseItemTypeProvider);
    final chooseSubExpense = ref.watch(expenseSubItemTypeProvider);
    final expenseCategoryList = ref.watch(expenseListCatProvider);
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
    final typeIndex = expenseListType
        .indexOf(chooseExpense)
        .clamp(0, expenseListType.length - 1);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        iconTheme: IconThemeData(color: neu.textPrimary),
        title: TextWidget(
          text: 'New transaction',
          color: neu.textPrimary,
          fontSize: 17.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(6.w, 1.h, 6.w, 4.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NeuSegmented(
                    segments: const ['Income', 'Expense', 'Debt'],
                    selectedIndex: typeIndex,
                    activeColor: _typeColor(neu, chooseExpense),
                    onChanged: (i) => ref
                        .read(expenseItemTypeProvider.notifier)
                        .state = expenseListType[i],
                  ),
                  Gap(2.5.h),
                  CustomTextFormField(
                    textEditingController: expenseAmountController,
                    hintText: 'Amount',
                    textInputType: TextInputType.number,
                    maxLine: 1,
                    maxlength: 12,
                  ),
                  Gap(1.8.h),
                  CustomTextFormField(
                    textEditingController: expenseTitleController,
                    hintText: 'Title',
                    textInputType: TextInputType.text,
                    maxLine: 1,
                    maxlength: 15,
                  ),
                  Gap(1.8.h),
                  if (chooseExpense == AppString.expenses) ...[
                    Row(
                      children: [
                        Expanded(
                          child: expenseCategoryList.when(
                            data: (data) => ExpenseSubTypeComponent(
                                chooseSubExpense: chooseSubExpense,
                                expenseSubListType: [
                                  ...expenseSubListType,
                                  ...data
                                ]),
                            loading: () => const SizedBox.shrink(),
                            error: (_, __) => const SizedBox.shrink(),
                          ),
                        ),
                        Gap(3.w),
                        GestureDetector(
                          onTap: () => showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              isScrollControlled: true,
                              builder: (_) => const AddCategories()),
                          child: NeuCard(
                            padding: const EdgeInsets.all(12),
                            radius: 14,
                            child: Icon(Icons.add,
                                color: neu.primary, size: 20.sp),
                          ),
                        ),
                      ],
                    ),
                    Gap(1.8.h),
                  ],
                  CustomTextFormField(
                    textEditingController: expenseDescripritionController,
                    hintText: 'Explain',
                    textInputType: TextInputType.text,
                    maxLine: 3,
                    maxlength: 30,
                  ),
                  Gap(1.8.h),
                  GestureDetector(
                    onTap: () async {
                      DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: ref.read(selectedDateTimeStateProvider),
                          firstDate: DateTime(2001),
                          lastDate: DateTime(2080));
                      if (newDate != null) {
                        ref.read(selectedDateTimeStateProvider.notifier).state =
                            newDate;
                      }
                    },
                    child: NeuWell(
                      radius: 15,
                      padding: EdgeInsets.symmetric(
                          horizontal: 4.w, vertical: 1.7.h),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today_outlined,
                              size: 15.sp, color: neu.textSecondary),
                          Gap(3.w),
                          TextWidget(
                            text:
                                '${choosedDate.day} - ${choosedDate.month} - ${choosedDate.year}',
                            color: neu.textPrimary,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
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
          if (authState == const AppStateManager.loading())
            const LoadingWidget(),
        ],
      ),
    );
  }

  Color _typeColor(NeuColors neu, String type) {
    if (type == AppString.income) return neu.income;
    if (type == AppString.expenses) return neu.expense;
    return neu.debt;
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
    final neu = context.neu;
    final text = ref.watch(newCategoryText);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h)
          .copyWith(bottom: MediaQuery.of(context).viewInsets.bottom + 4.h),
      decoration: BoxDecoration(
        color: neu.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(
          top: BorderSide(color: neu.primary, width: 3),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                text: 'Add Custom Category',
                color: neu.textPrimary,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
              IconButton(
                icon: Icon(Icons.close, color: neu.textSecondary, size: 18.sp),
                onPressed: () => Navigator.pop(context),
              )
            ],
          ),
          Gap(2.h),
          CustomTextFormField(
              hintText: 'Category name',
              textInputType: TextInputType.text,
              maxLine: 1,
              onChanged: (value) =>
                  ref.read(newCategoryText.notifier).state = value),
          Gap(2.5.h),
          SizedBox(
            width: double.infinity,
            child: NeuButton(
              filled: true,
              color: authState == const AppStateManager.loading()
                  ? neu.surface
                  : neu.primary,
              onTap: authState == const AppStateManager.loading()
                  ? null
                  : () {
                      if (text.length <= 3) {
                        EasyLoading.showInfo('Too short');
                      } else if (text.length >= 16) {
                        EasyLoading.showInfo('Too long');
                      } else {
                        ref
                            .read(expenseCategoryNotifier.notifier)
                            .addToList(text);
                      }
                    },
              child: TextWidget(
                  text: authState == const AppStateManager.loading()
                      ? 'Adding…'
                      : 'Add category',
                  fontSize: 14.5.sp,
                  fontWeight: FontWeight.w600,
                  color: neu.surface),
            ),
          ),
        ],
      ),
    );
  }
}

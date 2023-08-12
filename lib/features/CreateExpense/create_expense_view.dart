import 'package:expense_app/main.dart';
import 'package:expense_app/model/create_expense.dart';
import 'package:expense_app/utils/colors.dart';
import 'package:expense_app/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icon.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

final selectedDateTimeStateProvider =
    StateProvider<DateTime>((ref) => DateTime.now());
final expenseItemTypeProvider = StateProvider<String>((ref) => 'Income');
final expenseSubItemTypeProvider =
    StateProvider<String>((ref) => 'Transportation');

class CreateExpenseView extends ConsumerWidget {
  const CreateExpenseView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenseAmountController = TextEditingController();
    final expenseTitleController = TextEditingController();
    final expenseDescripritionController = TextEditingController();
    List<String> expenseListType = [
      'Expense',
      'Income',
      'Debt',
    ];
    List<String> expenseSubListType = [
      'Transportation',
      'Housing',
      'Food',
      'Health Care',
      'Education',
      'Debt Payments',
      'Clothing'
    ];
    final choosedDate = ref.watch(selectedDateTimeStateProvider);
    final chooseExpense = ref.watch(expenseItemTypeProvider);
    final chooseSubExpense = ref.watch(expenseSubItemTypeProvider);
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                height: 32.h,
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 7.h),
                decoration: BoxDecoration(
                  color: AppColor.kBlackColor,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(30.sp),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: LineIcon.arrowLeft(
                        color: AppColor.kWhitColor,
                        size: 20.sp,
                      ),
                    ),
                    Text(
                      'Create',
                      style: TextStyle(
                        fontSize: 17.sp,
                        color: AppColor.kWhitColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    LineIcon.blackberry(
                      color: AppColor.kWhitColor,
                      size: 20.sp,
                    )
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 150,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 80.w,
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 6.h),
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
                    ExpenseTypeComponent(
                        chooseExpense: chooseExpense,
                        expenseListType: expenseListType),
                    Gap(2.5.h),
                    chooseExpense == 'Expense'
                        ? Column(
                            children: [
                              ExpenseSubTypeComponent(
                                  chooseSubExpense: chooseSubExpense,
                                  expenseSubListType: expenseSubListType),
                              Gap(2.5.h),
                            ],
                          )
                        : Column(
                            children: [
                              Container(),
                            ],
                          ),
                    CustomTextFormField(
                      textEditingController: expenseTitleController,
                      hintText: 'Title',
                      textInputType: TextInputType.text,
                      maxLine: 1,
                      maxlength: 12,
                    ),
                    Gap(2.5.h),
                    CustomTextFormField(
                      textEditingController: expenseAmountController,
                      hintText: 'Amount',
                      textInputType: TextInputType.number,
                      maxLine: 1,
                      maxlength: 5,
                    ),
                    Gap(2.5.h),
                    CustomTextFormField(
                      textEditingController: expenseDescripritionController,
                      hintText: 'Explain',
                      textInputType: TextInputType.text,
                      maxLine: 3,
                      maxlength: 30,
                    ),
                    Gap(2.5.h),
                    BuildDateTimeCoMponent(choosedDate: choosedDate),
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
        ],
      ),
    );
  }
}

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
                child: Text(
                  e,
                  style:
                      TextStyle(fontSize: 13.9.sp, fontWeight: FontWeight.w600),
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
                  style:
                      TextStyle(fontSize: 13.9.sp, fontWeight: FontWeight.w600),
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
  final List<String> expenseSubListType;

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
        value: chooseSubExpense,
        underline: Container(),
        isExpanded: true,
        hint: Text(
          'Type',
          style: TextStyle(fontSize: 14.sp, color: AppColor.kBlackColor),
        ),
        selectedItemBuilder: (context) => expenseSubListType
            .map(
              (e) => DropdownMenuItem(
                value: e,
                child: Text(
                  e,
                  style:
                      TextStyle(fontSize: 13.9.sp, fontWeight: FontWeight.w600),
                ),
              ),
            )
            .toList(),
        items: expenseSubListType
            .map(
              (e) => DropdownMenuItem(
                value: e,
                child: Text(
                  e,
                  style:
                      TextStyle(fontSize: 13.9.sp, fontWeight: FontWeight.w600),
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          ref.read(expenseSubItemTypeProvider.notifier).state = value!;
        },
      ),
    );
  }
}

class BuildDateTimeCoMponent extends ConsumerWidget {
  const BuildDateTimeCoMponent({
    super.key,
    required this.choosedDate,
  });

  final DateTime choosedDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () async {
        DateTime? newDate = await showDatePicker(
            context: context,
            initialDate: ref.read(selectedDateTimeStateProvider),
            firstDate: DateTime(2001),
            lastDate: DateTime(2080));
        if (newDate != null) {
          ref.read(selectedDateTimeStateProvider.notifier).state = newDate;
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
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
class BuildCreateDataComponent extends ConsumerWidget {
  const BuildCreateDataComponent({
    super.key,
    required this.expenseTitleController,
    required this.expenseDescripritionController,
    required this.expenseAmountController,
    required this.chooseExpense,
    required this.choosedDate,
    required this.chooseSubExpense,
  });

  final TextEditingController expenseTitleController;
  final TextEditingController expenseDescripritionController;
  final TextEditingController expenseAmountController;
  final String chooseExpense;
  final String chooseSubExpense;
  final DateTime choosedDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(
            Size(double.maxFinite, 2.h),
          ),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: customBorderRadius(10))),
          backgroundColor:
              MaterialStateColor.resolveWith((states) => AppColor.kBlackColor)),
      onPressed: () {
        if (expenseTitleController.text.isNotEmpty &&
            expenseDescripritionController.text.isNotEmpty &&
            expenseDescripritionController.text.isNotEmpty) {
          var add = CreateExpenseModel(
              expenseTitleController.text,
              expenseAmountController.text,
              chooseExpense,
              expenseDescripritionController.text,
              choosedDate,
              chooseSubExpense);

          boxUse.add(add);
          context.pop();
        } else {
          SnackBar snackBar = SnackBar(
            backgroundColor: AppColor.kDarkGreyColor,
            content: Text(
              'Enter All Field',
              style: TextStyle(fontSize: 14.sp, color: AppColor.kWhitColor),
            ),
            showCloseIcon: true,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: Text(
        'Create',
        style: TextStyle(
            fontSize: 14.sp,
            color: AppColor.kWhitColor,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
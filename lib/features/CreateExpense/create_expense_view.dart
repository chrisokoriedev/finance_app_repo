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
final expenseItemType = StateProvider<String>((ref) => 'Expense');

class CreateExpenseView extends ConsumerWidget {
  const CreateExpenseView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenseAmount = TextEditingController();
    final expenseDescriprition = TextEditingController();
    List<String> expenseListType = ['Expense', 'Income', 'Debt'];
    final choosedDate = ref.watch(selectedDateTimeStateProvider);
    final chooseExpense = ref.watch(expenseItemType);
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
                    LineIcon.book(
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
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      height: 5.h,
                      decoration: BoxDecoration(
                          color: AppColor.kGreyColor.withOpacity(0.3),
                          borderRadius: customBorderRadius(10)),
                      child: DropdownButton<String>(
                        value: chooseExpense,
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
                          ref.read(expenseItemType.notifier).state = value!;
                        },
                      ),
                    ),
                    Gap(2.5.h),
                    CustomTextFormField(
                      textEditingController: expenseDescriprition,
                      hintText: 'Amount',
                      textInputType: TextInputType.number,
                      maxLine: 1,
                      maxlength: 10,
                    ),
                    Gap(2.5.h),
                    CustomTextFormField(
                      textEditingController: expenseAmount,
                      hintText: 'Explain',
                      textInputType: TextInputType.text,
                      maxLine: 3,
                      maxlength: 30,
                    ),
                    Gap(2.5.h),
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
                    ElevatedButton(
                      style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(
                            Size(double.maxFinite, 2.h),
                          ),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: customBorderRadius(10))),
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => AppColor.kBlackColor)),
                      onPressed: () {},
                      child: Text(
                        'Create',
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColor.kWhitColor,
                            fontWeight: FontWeight.bold),
                      ),
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

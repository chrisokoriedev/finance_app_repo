import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'colors.dart';

List<String> expenseListType = ['Expense', 'Income', 'Debt'];
List<String> expenseSubListType = [
  '..',
  'Transportation',
  'Housing',
  'Food',
  'Health Care',
  'Education',
  'Debt Payments',
  'Clothing'
];

BorderRadius customBorderRadius(double amount) =>
    BorderRadius.circular(amount.sp);

class BuildExpenseDashBoardComponent extends StatelessWidget {
  final String title;
  final Widget icon;
  final String amount;
  final Color dataColor;

  const BuildExpenseDashBoardComponent({
    super.key,
    required this.title,
    required this.icon,
    required this.amount,
    required this.dataColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25.w,
      height: 15.h,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(
        horizontal: 15.sp,
      ),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 48, 47, 47).withOpacity(0.8),
          borderRadius: BorderRadius.circular(10.sp),
          boxShadow: [
            BoxShadow(
                color: AppColor.kBlackColor.withOpacity(0.3),
                blurRadius: 12.sp,
                spreadRadius: 4.sp,
                offset: const Offset(0, 6))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 10.w,
              height: 5.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.sp), color: dataColor),
              child: icon),
          Gap(2.h),
          Text(
            '₦$amount',
            style: TextStyle(
                color: AppColor.kWhitColor,
                fontSize: 15.sp,
                letterSpacing: 1.6,
                fontWeight: FontWeight.w600),
          ),
          Gap(9.sp),
          Text(
            title,
            style: TextStyle(
                color: dataColor.withOpacity(0.6),
                fontSize: 13.sp,
                letterSpacing: 1.6,
                fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final TextInputType textInputType;
  final int maxLine;
  final int maxlength;
  final Function(String)? onChanged;
  const CustomTextFormField({
    super.key,
    required this.textEditingController,
    required this.hintText,
    required this.textInputType,
    required this.maxLine,
    required this.maxlength,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      controller: textEditingController,
      maxLines: maxLine,
      maxLength: maxlength,
      onChanged: onChanged,
      style: TextStyle(
          fontSize: 14.sp,
          color: AppColor.kDarkGreyColor,
          fontWeight: FontWeight.w600),
      cursorWidth: 1.w,
      cursorColor: AppColor.kDarkGreyColor,
      cursorRadius: Radius.circular(10.sp),
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        counterText: '',
        fillColor: AppColor.kGreyColor.withOpacity(0.3),
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 14.sp, color: AppColor.kDarkGreyColor),
        isCollapsed: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.8.h),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: customBorderRadius(10),
        ),
      ),
    );
  }
}

class NoDataView extends StatelessWidget {
  const NoDataView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/gifs/coming_soon.gif',
            width: 70.w,
          ),
          Text(
            'No items to display',
            style: TextStyle(
              color: AppColor.kDarkGreyColor,
              fontSize: 15.sp,
              letterSpacing: 1.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

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

  const BuildExpenseDashBoardComponent({
    super.key,
    required this.title,
    required this.icon,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 22.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                  radius: 13.sp,
                  backgroundColor: AppColor.kWhitColor,
                  child: icon),
              Gap(2.w),
              Text(
                title,
                style: TextStyle(
                    color: AppColor.kWhitColor,
                    fontSize: 13.sp,
                    letterSpacing: 1.6,
                    fontWeight: FontWeight.w300),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 21.sp),
            child: Text(
              '\$ $amount',
              style: TextStyle(
                  color: AppColor.kWhitColor,
                  fontSize: 15.sp,
                  letterSpacing: 1.6,
                  fontWeight: FontWeight.w600),
            ),
          )
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
  const CustomTextFormField({
    super.key,
    required this.textEditingController,
    required this.hintText,
    required this.textInputType,
    required this.maxLine,
    required this.maxlength,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      controller: textEditingController,
      maxLines: maxLine,
      maxLength: maxlength,
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

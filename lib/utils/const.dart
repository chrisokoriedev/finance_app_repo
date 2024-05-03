import 'package:expense_app/model/create_expense.dart';
import 'package:expense_app/utils/string_app.dart';
import 'package:expense_app/utils/text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'colors.dart';

List<String> expenseListType = [
  AppString.income,
  AppString.expenses,
  AppString.debt
];
List<String> expenseSubListType = [
  '..',
  'Transportation',
  'Housing',
  'Food',
  'Data',
  'Clothing'
];

launchEmail() async {
  const email = 'okoriec01@gmail.com';
  const subject = "App Feedback";
  const body = 'Type here...';

  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: email,
    queryParameters: {
      'subject': subject,
      'body': body,
    },
  );
  await launchUrl(emailLaunchUri);
}

launchDonation() async =>
    await launchUrl(Uri.parse('https://justpaga.me/ChrisIuil'));
launchPortFolio() async =>
    await launchUrl(Uri.parse('http://chrisdevokorie.unaux.com/'));
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
    final theme = Theme.of(context).colorScheme;
    return Container(
      width: 23.w,
      height: 15.h,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(
        horizontal: 15.sp,
      ),
      decoration: BoxDecoration(
          color: theme.onPrimary,
          borderRadius: BorderRadius.circular(10.sp),
          boxShadow: [
            BoxShadow(
                color: theme.primaryContainer.withOpacity(1.5.sp),
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
          TextWigdet(
              text: '₦$amount',
              maxLine: 1,
              fontSize: 15.sp,
              letterSpacing: 1.6,
              color: theme.primary,
              fontWeight: FontWeight.w600),
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
  final TextEditingController? textEditingController;
  final String hintText;
  final TextInputType textInputType;
  final int maxLine;
  final int? maxlength;
  final Function(String)? onChanged;
  const CustomTextFormField({
    super.key,
    this.textEditingController,
    required this.hintText,
    required this.textInputType,
    required this.maxLine,
    this.maxlength,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return TextFormField(
      keyboardType: textInputType,
      controller: textEditingController,
      maxLines: maxLine,
      maxLength: maxlength,
      onChanged: onChanged,
      style: TextStyle(
          fontSize: 14.sp, color: theme.primary, fontWeight: FontWeight.w600),
      cursorWidth: 1.w,
      cursorColor: theme.primary,
      cursorRadius: Radius.circular(10.sp),
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        counterText: '',
        fillColor: AppColor.kGreyColor.withOpacity(0.3),
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 14.sp, color: theme.primary),
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
    final theme = Theme.of(context).colorScheme;
    return ListTile(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Gap(1.h),
          // Image.asset(
          //   'assets/gifs/coming_soon.gif',
          //   width: 50.w,
          // ),
          Gap(2.h),
          TextWigdet(
            text: 'No items to display',
            color: theme.primary,
            fontSize: 15.sp,
            letterSpacing: 1.0,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}

String getUserName() {
  String lastName = '';
  var userDetails = FirebaseAuth.instance.currentUser;
  if (userDetails != null && userDetails.displayName != null) {
    List<String> nameParts = userDetails.displayName!.split(' ');
    lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';
  }
  return lastName;
}

Map<String, int> calculateLengths(List<CreateExpenseModel> data) {
  int incomeLength =
      data.where((expense) => expense.expenseType == "Income").length;
  int expenseLength =
      data.where((expense) => expense.expenseType == "Expense").length;
  int debtLength =
      data.where((expense) => expense.expenseType == "Debt").length;
  return {'Income': incomeLength, 'Expense': expenseLength, 'Debt': debtLength};
}

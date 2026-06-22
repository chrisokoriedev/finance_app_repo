import 'package:expense_app/core/model/create_expense.dart';
import 'package:expense_app/core/utils/string_app.dart';
import 'package:expense_app/core/utils/text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:expense_app/core/theme/neu_theme.dart';
import 'package:expense_app/core/widgets/neu.dart';

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

Future<void> launchEmail() async {
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

Future<bool> launchDonation() async =>
    await launchUrl(Uri.parse('https://justpaga.me/ChrisIuil'));
Future<bool> launchPortFolio() async =>
    await launchUrl(Uri.parse('https://chrisokoriedev.vercel.app'));
BorderRadius customBorderRadius(double amount) =>
    BorderRadius.circular(amount.sp);

IconData getCategoryIcon(String category, String type) {
  if (type == "Income") {
    return Icons.account_balance_wallet_outlined;
  }
  final catLower = category.toLowerCase();
  if (catLower.contains("grocer") || catLower.contains("shop")) {
    return Icons.shopping_cart_outlined;
  } else if (catLower.contains("transport") ||
      catLower.contains("gas") ||
      catLower.contains("fuel") ||
      catLower.contains("car")) {
    return Icons.local_gas_station_outlined;
  } else if (catLower.contains("eat") ||
      catLower.contains("cafe") ||
      catLower.contains("coffee") ||
      catLower.contains("restaurant") ||
      catLower.contains("food")) {
    return Icons.coffee_outlined;
  } else if (catLower.contains("house") || catLower.contains("rent")) {
    return Icons.home_outlined;
  } else if (catLower.contains("data") ||
      catLower.contains("wifi") ||
      catLower.contains("phone")) {
    return Icons.wifi;
  } else if (catLower.contains("cloth") || catLower.contains("dress")) {
    return Icons.checkroom_outlined;
  }

  if (type == "Expense") {
    return Icons.north_east;
  }
  return Icons.account_balance_outlined;
}


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
          TextWidget(
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
    final neu = context.neu;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        color: neu.surface,
        borderRadius: BorderRadius.circular(15),
        boxShadow: neu.inset,
      ),
      child: TextFormField(
        keyboardType: textInputType,
        controller: textEditingController,
        maxLines: maxLine,
        maxLength: maxlength,
        onChanged: onChanged,
        style: TextStyle(
            fontSize: 14.sp,
            color: neu.textPrimary,
            fontWeight: FontWeight.w500),
        cursorColor: neu.primary,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          counterText: '',
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 14.sp, color: neu.textSecondary),
          isCollapsed: true,
          contentPadding: EdgeInsets.symmetric(vertical: 1.8.h),
          border: InputBorder.none,
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
    final neu = context.neu;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NeuIconWell(
              icon: Icons.receipt_long_outlined,
              color: neu.primary,
              size: 64,
              radius: 22),
          Gap(2.h),
          TextWidget(
            text: 'Nothing here yet',
            color: neu.textPrimary,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
          ),
          Gap(0.6.h),
          TextWidget(
            text: 'Your transactions will show up here',
            color: neu.textSecondary,
            fontSize: 12.sp,
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

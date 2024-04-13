import 'dart:math';

import 'package:expense_app/utils/colors.dart';
import 'package:expense_app/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:timeago/timeago.dart' as timeago;

class ExpenseListBuilder extends StatelessWidget {
  final List data;
  final bool showDateTIme;
  const ExpenseListBuilder({
    super.key,
    required this.data,
    this.showDateTIme = true,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: data.isNotEmpty ? min(data.length, 5) : 1,
        (context, index) {
          if (data.isEmpty) {
            return const NoDataView();
          }
          var history = data[index];
          Icon iconData;
          if (history.expenseType == "Income") {
            iconData = LineIcon.wallet(
              size: 18.sp,
              color: AppColor.kGreenColor,
            );
          } else if (history.expenseType == "Expense") {
            iconData = LineIcon.alternateWavyMoneyBill(
              size: 18.sp,
              color: AppColor.kredColor,
            );
          } else {
            iconData = LineIcon.alternateWavyMoneyBill(
              size: 18.sp,
              color: AppColor.kBlueColor,
            );
          }
          return ListTile(
            title: Row(
              children: [
                Text(
                  '${history.expenseType}\tfor\t${history.name}',
                  style: TextStyle(
                      color: AppColor.kDarkGreyColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  history.explain,
                  style: TextStyle(
                      color: AppColor.kDarkGreyColor,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600),
                ),
                showDateTIme
                    ? Text(
                        timeago.format(history.dateTime),
                        style: TextStyle(
                            color: AppColor.kGreyColor.shade500,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            leading: iconData,
            trailing: Text(
              history.amount.toString(),
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
            ),
          );
        },
      ),
    );
  }
}

//  background: Container(
//                     color: AppColor.kredColor,
//                     child: Align(
//                       alignment: Alignment.centerRight,
//                       child: Padding(
//                         padding: EdgeInsets.only(right: 16.0.sp),
//                         child: Icon(
//                           Icons.delete,
//                           size: 18.sp,
//                           color: AppColor.kWhitColor,
//                         ),
//                       ),
//                     ),
//                   ),
//                   direction: DismissDirection.endToStart,
//                   confirmDismiss: (direction) async {
//                     bool confirm = await showDialog(
//                       context: context,
//                       builder: (context) => AlertDialog(
//                         surfaceTintColor: AppColor.kBlackColor,
//                         backgroundColor: AppColor.kWhitColor,
//                         title: Text(
//                           'Confirm Delete',
//                           style: TextStyle(
//                               color: AppColor.kBlackColor,
//                               fontSize: 16.sp,
//                               fontWeight: FontWeight.w600),
//                         ),
//                         content: Text(
//                           'Are you sure you want to delete this item?',
//                           style: TextStyle(
//                               color: AppColor.kDarkGreyColor,
//                               fontSize: 15.sp,
//                               fontWeight: FontWeight.w500),
//                         ),
//                         actions: [
//                           TextButton(
//                             onPressed: () => Navigator.pop(context, false),
//                             child: const Text('Cancel'),
//                           ),
//                           TextButton(
//                             onPressed: () => Navigator.pop(context, true),
//                             child: const Text('Delete'),
//                           ),
//                         ],
//                       ),
//                     );
//                     return confirm;
//                   },
//                   onDismissed: (direction) {
//                     history.delete();
//                   },
//                   key: ObjectKey(history),

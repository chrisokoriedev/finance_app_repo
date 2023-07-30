import 'package:expense_app/model/create_expense.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../utils/colors.dart';
import '../HeaderDashboard/header.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<CreateExpenseModel>('data');
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(height: 45.h, child: const DashboardHeader()),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(15.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Transaction History',
                    style: TextStyle(
                        color: AppColor.kBlackColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'See all',
                    style: TextStyle(
                        color: AppColor.kGreyColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              // Container(
              //   color: AppColor.kDarkGreyColor,
              //   child: ValueListenableBuilder(
              //       valueListenable: box.listenable(),
              //       builder: (context, Box<dynamic> box, Widget? child) {
              //         final userList = box.values.toList();
              
              //         if (userList.isEmpty) {
              //           return Text('No users in the box');
              //         } else {
              //           return ListView.builder(
              //             itemCount: userList.length,
              //             itemBuilder: (context, index) {
              //               final user = userList[index];
              //               return ListTile(
              //                 title: Text(
              //                   user.name,
              //                   style: TextStyle(color: AppColor.kBlackColor),
              //                 ),
              //                 subtitle: Text(user.expenseType.toString(),
              //                     style: TextStyle(color: AppColor.kBlackColor)),
              //               );
              //             },
              //           );
              //         }
              //       }),
              // )
            
            
            
            
            ]),
          ),
        ),
      ],
    ));
  }
}

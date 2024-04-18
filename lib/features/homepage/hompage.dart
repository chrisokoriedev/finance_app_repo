import 'dart:math';

import 'package:expense_app/provider/item_provider.dart';
import 'package:expense_app/utils/expense_list_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../utils/colors.dart';
import '../HeaderDashboard/header.dart';

class HomePage extends ConsumerWidget {
  final VoidCallback pageSelected;

  const HomePage({super.key, required this.pageSelected});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemProvider = ref.watch(cloudItemsProvider);

    return itemProvider.when(
        data: (data) => CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(height: 45.h, child: const DashboardHeader()),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Recent History',
                                style: TextStyle(
                                    color: AppColor.kBlackColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                              GestureDetector(
                                onTap: pageSelected,
                                child: Text(
                                  'See all',
                                  style: TextStyle(
                                      color: AppColor.kGreyColor,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ]),
                  ),
                ),
                ExpenseListBuilder(
                    data: data,
                    childCount: data.isNotEmpty ? min(data.length, 6) : 1),
              ],
            ),
        error: (_, __) {
          debugPrint('Eror $__');
          return Text('Error $__');
        },
        loading: () => const Center(child: CircularProgressIndicator()));
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

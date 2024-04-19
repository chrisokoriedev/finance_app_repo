import 'dart:math';

import 'package:expense_app/provider/item_provider.dart';
import 'package:expense_app/utils/expense_list_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../utils/colors.dart';
import '../HeaderDashboard/header.dart';

class HomePage extends ConsumerWidget {
  final PageController pageCntrl;
  final VoidCallback pageSelected;

  const HomePage(this.pageCntrl, {super.key, required this.pageSelected});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemProvider = ref.watch(cloudItemsProvider);

    return RefreshIndicator(
      onRefresh: () => ref.refresh(cloudItemsProvider.future),
      child: itemProvider.when(
          data: (data) => CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(
                        height: 45.h, child: DashboardHeader(pageCntrl)),
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
          loading: () => const Center(child: CircularProgressIndicator())),
    );
  }
}

import 'dart:math';

import 'package:expense_app/provider/item_provider.dart';
import 'package:expense_app/utils/expense_list_builder.dart';
import 'package:expense_app/utils/loading.dart';
import 'package:expense_app/utils/text.dart';
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
    final theme = Theme.of(context).colorScheme;
    return RefreshIndicator(
      onRefresh: () => ref.refresh(cloudItemsProvider.future),
      child: itemProvider.when(
          data: (data) {
            var dataNew = data
              ..sort((a, b) => b.dateTime.compareTo(a.dateTime));
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child:
                      SizedBox(height: 52.h, child: DashboardHeader(pageCntrl)),
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
                              TextWigdet(
                                  text: 'Recent History',
                                  color: theme.primary,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500),
                              GestureDetector(
                                onTap: pageSelected,
                                child: TextWigdet(
                                    text: 'See all',
                                    color: AppColor.kGreyColor,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ]),
                  ),
                ),
                ExpenseListBuilder(
                    data: dataNew,
                    childCount:
                        dataNew.isNotEmpty ? min(dataNew.length, 6) : 1),
              ],
            );
          },
          error: (_, __) {
            debugPrint('Eror $__');
            return Text('Error $__');
          },
          loading: () => const LoadingWidget()),
    );
  }
}

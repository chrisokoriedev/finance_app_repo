import 'dart:math';

import 'package:expense_app/core/provider/item_provider.dart';
import 'package:expense_app/core/theme/neu_theme.dart';
import 'package:expense_app/core/utils/expense_list_builder.dart';
import 'package:expense_app/core/utils/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../HeaderDashboard/header.dart';

class HomePage extends ConsumerWidget {
  final PageController pageCntrl;
  final VoidCallback pageSelected;

  const HomePage(this.pageCntrl, {super.key, required this.pageSelected});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemProvider = ref.watch(cloudItemsProvider);
    final neu = context.neu;
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: RefreshIndicator(
        color: neu.primary,
        backgroundColor: neu.surface,
        onRefresh: () => ref.refresh(cloudItemsProvider.future),
        child: itemProvider.when(
            data: (data) {
              var dataNew = data
                ..sort((a, b) => b.dateTime.compareTo(a.dateTime));
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(child: DashboardHeader(pageCntrl)),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(5.w, 1.h, 5.w, 0.5.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(
                              text: 'Recent',
                              color: neu.textPrimary,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500),
                          GestureDetector(
                            onTap: pageSelected,
                            child: TextWidget(
                                text: 'See all',
                                color: neu.primary,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ExpenseListBuilder(
                      data: dataNew,
                      childCount:
                          dataNew.isNotEmpty ? min(dataNew.length, 6) : 1),
                  const SliverToBoxAdapter(child: Gap(12)),
                ],
              );
            },
            error: (_, __) {
              debugPrint('Eror $__');
              return Center(
                  child: TextWidget(
                      text: 'Something went wrong',
                      color: neu.textSecondary,
                      fontSize: 14.sp));
            },
            loading: () =>
                Center(child: CircularProgressIndicator(color: neu.primary))),
      ),
    );
  }
}

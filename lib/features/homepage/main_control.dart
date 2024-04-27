import 'package:expense_app/features/TransactionList/transaction_list_view.dart';
import 'package:expense_app/features/homepage/hompage.dart';
import 'package:expense_app/features/statistics/statistics.dart';
import 'package:expense_app/provider/item_provider.dart';
import 'package:expense_app/utils/colors.dart';
import 'package:expense_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../Porfile/profile.dart';

final selectedBottomTab = StateProvider.autoDispose<int>((ref) => 0);

class MainControlComponent extends ConsumerWidget {
  const MainControlComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme=Theme.of(context).colorScheme;

    final selectedTab = ref.watch(selectedBottomTab);
    ref.listen(cloudItemsProvider, (previous, next) { 
      next.maybeWhen(
        orElse: () => null,
       
      );
    });

    final PageController pageCntrl = PageController(initialPage: selectedTab);
    pageCntrl.addListener(() {
      ref.read(selectedBottomTab.notifier).state = pageCntrl.page!.round();
    });
    final iconData = [
      LineIcons.home,
      LineIcons.lineChart,
      LineIcons.wallet,
      LineIcons.user,
    ];
    final screenChangeList = [
      HomePage(
        pageCntrl,
        pageSelected: () {
          pageCntrl.jumpToPage(2);
          ref.read(selectedBottomTab.notifier).state = 2;
        },
      ),
      Statistics(pageCntrl),
      TransactionListView(pageCntrl),
      ProfileScreen(pageCntrl),
    ];
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) =>
            ref.read(selectedBottomTab.notifier).state = index,
        controller: pageCntrl,
        children: screenChangeList,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: LineIcon.plus(
          color: AppColor.kWhitColor,
          size: 18.sp,
        ),
        onPressed: () => context.push(AppRouter.createExpenseView),
      ),
      bottomNavigationBar: BottomAppBar(
        color: theme.primaryContainer.withOpacity(1.0.sp),
        height: 8.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            iconData.length,
            (index) => GestureDetector(
              onTap: () {
                pageCntrl.jumpToPage(index);
                ref.read(selectedBottomTab.notifier).state = index;
              },
              child: Container(
                width: 20.w,
                height: 25.h,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selectedTab == index
                        ? AppColor.kGreyColor.withOpacity(0.3)
                        : Colors.transparent),
                child: LineIcon(
                  iconData[index],
                  color: selectedTab == index
                      ? AppColor.kWhitColor
                      : AppColor.kGreyColor,
                  size: selectedTab == index ? 20.sp : 18.sp,
                ),
              ),
            ),
          )..insert(2, Gap(2.w)),
        ),
      ),
    );
  }
}

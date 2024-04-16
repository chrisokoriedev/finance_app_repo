import 'package:expense_app/features/TransactionList/transaction_list_view.dart';
import 'package:expense_app/features/homepage/hompage.dart';
import 'package:expense_app/features/statistics/statistics.dart';
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

final selectedBottomTab = StateProvider<int>((ref) => 0);

class MainControlComponent extends ConsumerWidget {
  const MainControlComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(selectedBottomTab);

    final PageController pageController =
        PageController(initialPage: selectedTab);
    final iconData = [
      LineIcons.home,
      LineIcons.lineChart,
      LineIcons.wallet,
      LineIcons.user,
    ];
    final screenChangeList = [
      HomePage(
        pageSelected: () {
          pageController.jumpToPage(2);
          ref.read(selectedBottomTab.notifier).state = 2;
        },
      ),
      Statistics(pageController),
      TransactionListView(pageController),
      ProfileScreen(pageController),
    ];
    return Scaffold(
      body: PageView(
        onPageChanged: (index) =>
            ref.read(selectedBottomTab.notifier).state = index,
        controller: pageController,
        children: screenChangeList,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.kDarkGreyColor,
        child: LineIcon.plus(
          color: AppColor.kWhitColor,
          size: 18.sp,
        ),
        onPressed: () => context.push(AppRouter.createExpenseView),
      ),
      bottomNavigationBar: BottomAppBar(
        color: AppColor.kBlackColor,
        height: 8.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            iconData.length,
            (index) => GestureDetector(
              onTap: () {
                pageController.jumpToPage(index);
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

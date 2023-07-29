import 'package:expense_app/features/homepage/hompage.dart';
import 'package:expense_app/features/statistics/statistics.dart';
import 'package:expense_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

final selectedBottomTab = StateProvider<int>((ref) => 0);

class BottomComponent extends ConsumerWidget {
  const BottomComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(selectedBottomTab);
    final iconData = [
      LineIcons.home,
      LineIcons.lineChart,
      LineIcons.wallet,
      LineIcons.user,
    ];
    final screenChangeList = [
      const HomePage(),
      const Statistics(),
      Container(),
      Container()
    ];
    return Scaffold(
      body: screenChangeList[selectedTab],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.kGreyColor,
        child: LineIcon.plus(
          color: AppColor.kWhitColor,
          size: 18.sp,
        ),
        onPressed: () {},
      ),
      bottomNavigationBar: BottomAppBar(
        color: AppColor.kBlackColor,
        height: 8.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            iconData.length,
            (index) => GestureDetector(
              onTap: () => ref.read(selectedBottomTab.notifier).state = index,
              child: LineIcon(
                iconData[index],
                color: selectedTab == index
                    ? AppColor.kWhitColor
                    : AppColor.kGreyColor,
                size: selectedTab == index ? 19.sp : 18.sp,
              ),
            ),
          )..insert(2, Gap(5.w)),
        ),
      ),
    );
  }
}

import 'package:expense_app/features/Profile/profile.dart';
import 'package:expense_app/features/TransactionList/transaction_list_view.dart';
import 'package:expense_app/features/homepage/homepage.dart';
import 'package:expense_app/features/statistics/statistics.dart';
import 'package:expense_app/core/provider/item_provider.dart';
import 'package:expense_app/core/utils/colors.dart';
import 'package:expense_app/core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vibration/vibration.dart';

final selectedBottomTab = StateProvider.autoDispose<int>((ref) => 0);

class MainControlComponent extends HookConsumerWidget {
  const MainControlComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).colorScheme;
    final selectedTab = ref.watch(selectedBottomTab);
    ref.listen(cloudItemsProvider, (previous, next) {
      next.maybeWhen(
        orElse: () => null,
      );
    });

    // usePageController keeps a single controller across rebuilds and disposes
    // it automatically, avoiding the leak from rebuilding it every build.
    final pageCntrl =
        usePageController(initialPage: ref.read(selectedBottomTab));
    useEffect(() {
      void listener() {
        final page = pageCntrl.page;
        if (page != null) {
          ref.read(selectedBottomTab.notifier).state = page.round();
        }
      }

      pageCntrl.addListener(listener);
      return () => pageCntrl.removeListener(listener);
    }, [pageCntrl]);
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
      body: Stack(
        children: [
          PageView(
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (index) =>
                ref.read(selectedBottomTab.notifier).state = index,
            controller: pageCntrl,
            children: screenChangeList,
          ),
        ],
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
        height: 8.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            iconData.length,
            (index) => GestureDetector(
              onTap: () {
                Vibration.vibrate(duration: 500, amplitude: 6);
                pageCntrl.jumpToPage(index);
                ref.read(selectedBottomTab.notifier).state = index;
              },
              child: Container(
                width: 20.w,
                height: 25.h,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selectedTab == index
                        ? theme.onPrimaryContainer
                        : Colors.transparent),
                child: LineIcon(
                  iconData[index],
                  color: selectedTab == index
                      ? theme.primary
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

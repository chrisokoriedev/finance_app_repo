import 'package:expense_app/features/Profile/profile.dart';
import 'package:expense_app/features/TransactionList/transaction_list_view.dart';
import 'package:expense_app/features/homepage/homepage.dart';
import 'package:expense_app/features/statistics/statistics.dart';
import 'package:expense_app/core/provider/item_provider.dart';
import 'package:expense_app/core/theme/neu_theme.dart';
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
    final neu = context.neu;
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
      backgroundColor: neu.surface,
      body: SafeArea(
        child: Stack(
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: neu.primary,
        elevation: 0,
        highlightElevation: 0,
        shape: const CircleBorder(),
        child: LineIcon.plus(
          color: neu.surface,
          size: 20.sp,
        ),
        onPressed: () => context.push(AppRouter.createExpenseView),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 9.h,
        color: neu.surface,
        elevation: 0,
        surfaceTintColor: neu.surface,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            iconData.length,
            (index) {
              final isActive = selectedTab == index;
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Vibration.vibrate(duration: 500, amplitude: 6);
                  pageCntrl.jumpToPage(index);
                  ref.read(selectedBottomTab.notifier).state = index;
                },
                child: Container(
                  padding: EdgeInsets.all(isActive ? 2.5.w : 0),
                  decoration: isActive
                      ? BoxDecoration(
                          shape: BoxShape.circle,
                          color: neu.surface,
                          boxShadow: neu.inset)
                      : null,
                  child: LineIcon(
                    iconData[index],
                    color: isActive ? neu.primary : neu.textSecondary,
                    size: isActive ? 20.sp : 19.sp,
                  ),
                ),
              );
            },
          )..insert(2, Gap(8.w)),
        ),
      ),
    );
  }
}

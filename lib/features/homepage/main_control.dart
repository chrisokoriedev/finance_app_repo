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
import 'package:go_router/go_router.dart';
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
      extendBody: true,
      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index) =>
              ref.read(selectedBottomTab.notifier).state = index,
          controller: pageCntrl,
          children: screenChangeList,
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        padding: EdgeInsets.fromLTRB(16.sp, 0, 16.sp, 20.sp),
        child: Container(
          height: 8.h,
          decoration: BoxDecoration(
            color: neu.surface,
            borderRadius: BorderRadius.circular(30.sp),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.35),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(
                  ref, pageCntrl, 0, LineIcons.home, selectedTab, neu),
              _buildNavItem(
                  ref, pageCntrl, 1, LineIcons.pieChart, selectedTab, neu),
              GestureDetector(
                onTap: () {
                  try {
                    Vibration.vibrate(duration: 40, amplitude: 10);
                  } catch (_) {}
                  context.push(AppRouter.createExpenseView);
                },
                child: Container(
                  width: 12.w,
                  height: 12.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: neu.primary,
                  ),
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 21.sp,
                  ),
                ),
              ),
              _buildNavItem(
                  ref, pageCntrl, 2, LineIcons.wallet, selectedTab, neu),
              _buildNavItem(
                  ref, pageCntrl, 3, LineIcons.user, selectedTab, neu),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(WidgetRef ref, PageController pageCntrl, int index,
      IconData icon, int selectedTab, NeuColors neu) {
    final isActive = selectedTab == index;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        try {
          Vibration.vibrate(duration: 40, amplitude: 6);
        } catch (_) {}
        pageCntrl.jumpToPage(index);
        ref.read(selectedBottomTab.notifier).state = index;
      },
      child: Container(
        width: 12.w,
        height: 12.w,
        alignment: Alignment.center,
        child: Icon(
          icon,
          color: isActive ? neu.primary : neu.textSecondary,
          size: 20.sp,
        ),
      ),
    );
  }
}

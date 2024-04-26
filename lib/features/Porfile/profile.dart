import 'package:expense_app/notifer/auth_notifer.dart';
import 'package:expense_app/model/create_expense.dart';
import 'package:expense_app/provider/firebase.dart';
import 'package:expense_app/provider/item_provider.dart';
import 'package:expense_app/state/auth.dart';
import 'package:expense_app/utils/colors.dart';
import 'package:expense_app/utils/loading.dart';
import 'package:expense_app/utils/routes.dart';
import 'package:expense_app/utils/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:expense_app/utils/string_app.dart';

import 'bottomsheet/setting_and_support.dart';

class ProfileScreen extends HookConsumerWidget {
  final PageController pageController;

  const ProfileScreen(this.pageController, {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firebaseAuth = ref.watch(firebaseAuthProvider);
    final itemProvider = ref.watch(cloudItemsProvider);
    final authState = ref.watch(authNotifierProvider);
    ref.listen(authNotifierProvider, (previous, next) {
      next.maybeWhen(
        orElse: () => null,
        failed: (message) {
          EasyLoading.showError(message!);
        },
        success: (message) async {
          EasyLoading.showSuccess(message!);
          context.pushReplacement(AppRouter.authScreen);
        },
      );
    });

    return Stack(
      fit: StackFit.expand,
      children: [
        PopScope(
            canPop: false,
            onPopInvoked: (value) => pageController.jumpToPage(0),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 5.sp)
                  .copyWith(top: 30.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20.w,
                    child: UserAvatar(firebaseAuth: firebaseAuth),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        firebaseAuth.currentUser?.displayName ?? "",
                        style: TextStyle(
                            fontSize: 16.sp,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.w600),
                      ),
                      Gap(5.w),
                      Text(
                        firebaseAuth.currentUser?.email ?? "",
                        style: TextStyle(
                            fontSize: 16.sp,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Gap(2.h),
                  itemProvider.when(
                    data: (data) {
                      Map<String, int> lengths = calculateLengths(data);

                      return SizedBox(
                        width: double.infinity,
                        height: 25.h,
                        child: SfCircularChart(
                          margin: EdgeInsets.zero,
                          series: <CircularSeries>[
                            DoughnutSeries<MapEntry<String, int>, String>(
                              dataSource: lengths.entries.toList(),
                              xValueMapper: (entry, _) => entry.key,
                              yValueMapper: (entry, _) => entry.value,
                              dataLabelMapper: (entry, _) =>
                                  '${entry.key}: ${entry.value}',
                              dataLabelSettings:
                                  const DataLabelSettings(isVisible: true),
                            ),
                          ],
                          legend: const Legend(isVisible: true),
                        ),
                      );
                    },
                    error: (_, __) => Text('error$__'),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                  ),
                  Gap(1.h),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      children: [
                        CustomButton(
                          icons: LineIcons.barChart,
                          title: AppString.viewTimeline,
                          press: () => context.push(AppRouter.viewAllExpenses),
                        ),
                        CustomButton(
                          icons: LineIcons.phoenixFramework,
                          title: 'Setting & Support',
                          press: () => showModalBottomSheet(
                              context: context,
                              builder: (_) => const SettingAndSupport()),
                        ),
                        CustomButton(
                          icons: LineIcons.userCircle,
                          title: 'About us',
                          press: () => showModalBottomSheet(
                              context: context,
                              builder: (_) => const CommingSoon()),
                        ),
                        CustomButton(
                          icons: LineIcons.bookReader,
                          title: 'Terms & Condition',
                          press: () => showModalBottomSheet(
                              context: context,
                              builder: (_) => const CommingSoon()),
                        ),
                        CustomButton(
                            icons: LineIcons.doorClosed,
                            title: 'Logout',
                            color: AppColor.kredColor,
                            press: () => ref
                                .read(authNotifierProvider.notifier)
                                .signOutGoogle()),
                      ],
                    ),
                  )
                ],
              ),
            )),
        if (authState == const AuthenticationState.loading())
          const LoadingWidget(),
      ],
    );
  }
}

class CommingSoon extends StatelessWidget {
  const CommingSoon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 20.h,
      child: Center(
          child: Text(
        'Comming soon',
        style: TextStyle(
            fontSize: 20.sp, fontWeight: FontWeight.w600, letterSpacing: 1.4),
      )),
    );
  }
}

class CustomButton extends StatelessWidget {
  final IconData icons;
  final String? title;
  final Color? color;
  final double? margin;
  final Widget? lastWidget;
  final bool? showLastWidget;
  final VoidCallback? press;
  const CustomButton(
      {super.key,
      this.title,
      this.color = AppColor.kDarkGreyColor,
      this.press,
      required this.icons,
      this.margin = 20,
      this.lastWidget,
      this.showLastWidget = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        width: double.infinity,
        alignment: Alignment.centerLeft,
        height: 5.h,
        margin: EdgeInsets.only(bottom: margin!.sp),
        padding: EdgeInsets.symmetric(horizontal: 15.sp),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.sp),
            color: color!.withOpacity(1.0.sp)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                LineIcon(icons),
                Gap(2.w),
                Text(
                  title!,
                  style: TextStyle(fontSize: 15.sp, letterSpacing: 1.5),
                ),
              ],
            ),
            if (showLastWidget ?? false) lastWidget ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

Map<String, int> calculateLengths(List<CreateExpenseModel> data) {
  int incomeLength =
      data.where((expense) => expense.expenseType == "Income").length;
  int expenseLength =
      data.where((expense) => expense.expenseType == "Expense").length;
  int debtLength =
      data.where((expense) => expense.expenseType == "Debt").length;
  return {'Income': incomeLength, 'Expense': expenseLength, 'Debt': debtLength};
}

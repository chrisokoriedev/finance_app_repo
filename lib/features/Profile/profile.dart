import 'package:expense_app/core/provider/app_provider.dart';
import 'package:expense_app/core/provider/firebase.dart';
import 'package:expense_app/core/provider/item_provider.dart';
import 'package:expense_app/core/state/auth.dart';
import 'package:expense_app/core/theme/neu_theme.dart';
import 'package:expense_app/core/utils/colors.dart';
import 'package:expense_app/core/widgets/neu.dart';
import 'package:expense_app/core/utils/const.dart';
import 'package:expense_app/core/utils/loading.dart';
import 'package:expense_app/core/utils/routes.dart';
import 'package:expense_app/core/utils/setting_button.dart';
import 'package:expense_app/core/utils/text.dart';
import 'package:expense_app/core/utils/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:expense_app/core/utils/string_app.dart';

import 'bottomsheet/setting_and_support.dart';

class ProfileScreen extends HookConsumerWidget {
  final PageController pageController;

  const ProfileScreen(this.pageController, {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final neu = context.neu;
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
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: neu.surface,
                      boxShadow: neu.raised,
                    ),
                    child: SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: UserAvatar(firebaseAuth: firebaseAuth),
                    ),
                  ),
                  Gap(1.5.h),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextWidget(
                          text: firebaseAuth.currentUser?.displayName ?? "",
                          color: neu.textPrimary,
                          fontSize: 16.sp,
                          letterSpacing: 1.2,
                          maxLine: 1,
                          fontWeight: FontWeight.w500),
                      Gap(0.4.h),
                      TextWidget(
                          text: firebaseAuth.currentUser?.email ?? "",
                          color: neu.textSecondary,
                          fontSize: 13.sp,
                          maxLine: 1,
                          fontWeight: FontWeight.w400),
                    ],
                  ),
                  Gap(2.h),
                  itemProvider.when(
                    data: (data) {
                      Map<String, int> lengths = calculateLengths(data);

                      return NeuCard(
                        radius: 22,
                        padding: const EdgeInsets.all(12),
                        child: SizedBox(
                          width: double.infinity,
                          height: 22.h,
                          child: SfCircularChart(
                            margin: EdgeInsets.zero,
                            palette: [neu.income, neu.expense, neu.debt],
                            series: <CircularSeries>[
                              DoughnutSeries<MapEntry<String, int>, String>(
                                dataSource: lengths.entries.toList(),
                                xValueMapper: (entry, _) => entry.key,
                                yValueMapper: (entry, _) => entry.value,
                                innerRadius: '65%',
                                dataLabelMapper: (entry, _) =>
                                    '${entry.key}: ${entry.value}',
                                dataLabelSettings: DataLabelSettings(
                                    isVisible: true,
                                    textStyle:
                                        TextStyle(color: neu.textSecondary)),
                              ),
                            ],
                            legend: Legend(
                                isVisible: true,
                                textStyle: TextStyle(color: neu.textPrimary)),
                          ),
                        ),
                      );
                    },
                    error: (_, __) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 3.h),
                      child: TextWidget(
                          text: 'Could not load chart',
                          color: neu.textSecondary,
                          fontSize: 13.sp),
                    ),
                    loading: () => Center(
                        child: CircularProgressIndicator(color: neu.primary)),
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
                            press: () => launchPortFolio()),
                        CustomButton(
                          icons: LineIcons.bookReader,
                          title: 'Terms & Condition',
                          press: () => showModalBottomSheet(
                              context: context,
                              builder: (_) => const ComingSoon()),
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

class ComingSoon extends StatelessWidget {
  const ComingSoon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 20.h,
      child: Center(
        child: TextWidget(
            text: 'Coming soon',
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.4),
      ),
    );
  }
}

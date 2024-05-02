import 'package:expense_app/notifer/auth_notifer.dart';
import 'package:expense_app/provider/firebase.dart';
import 'package:expense_app/provider/item_provider.dart';
import 'package:expense_app/state/auth.dart';
import 'package:expense_app/utils/colors.dart';
import 'package:expense_app/utils/const.dart';
import 'package:expense_app/utils/loading.dart';
import 'package:expense_app/utils/routes.dart';
import 'package:expense_app/utils/setting_button.dart';
import 'package:expense_app/utils/text.dart';
import 'package:expense_app/utils/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
                      TextWigdet(
                          text: firebaseAuth.currentUser?.displayName ?? "",
                          fontSize: 16.sp,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w600),
                      Gap(5.w),
                      TextWigdet(
                          text: firebaseAuth.currentUser?.email ?? "",
                          fontSize: 16.sp,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w600),
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
                          palette: const [
                            AppColor.kGreenColor,
                            AppColor.kredColor,
                            AppColor.kBlueColor
                          ],
                          series: <CircularSeries>[
                            DoughnutSeries<MapEntry<String, int>, String>(
                              dataSource: lengths.entries.toList(),
                              xValueMapper: (entry, _) => entry.key,
                              yValueMapper: (entry, _) => entry.value,
                              dataLabelMapper: (entry, _) =>
                                  '${entry.key}: ${entry.value}',
                              dataLabelSettings: DataLabelSettings(
                                  isVisible: true,
                                  textStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary)),
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
                            press: () => launchPortFolio()),
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
        child: TextWigdet(
            text: 'Comming soon',
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.4),
      ),
    );
  }
}

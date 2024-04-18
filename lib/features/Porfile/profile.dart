import 'package:expense_app/features/auth/notifer/auth_notifer.dart';
import 'package:expense_app/model/create_expense.dart';
import 'package:expense_app/provider/firebase.dart';
import 'package:expense_app/provider/item_provider.dart';
import 'package:expense_app/state/auth.dart';
import 'package:expense_app/utils/colors.dart';
import 'package:expense_app/utils/loading.dart';
import 'package:expense_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
              padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 20.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 15.w,
                    height: 15.h,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(firebaseAuth
                                    .currentUser?.photoURL ??
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWwb7VqZWWn6W92xv34aLhCXSrVGeArGHPhSKh4PysLQ&s'),
                            fit: BoxFit.contain)),
                  ),
                  Text(firebaseAuth.currentUser?.displayName ?? ""),
                  Text(firebaseAuth.currentUser?.email ?? ""),
                  Text(firebaseAuth.currentUser?.phoneNumber ?? ""),
                  itemProvider.when(
                    data: (data) {
                      Map<String, int> lengths = calculateLengths(data);

                      return SizedBox(
                        width: double.infinity,
                        height: 30.h,
                        child: SfCircularChart(
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
                    error: (_, __) => const Text('error '),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                  ),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        const CustomButton(
                          title: 'View all income data',
                        ),
                        const CustomButton(
                          title: 'View all expense data',
                        ),
                        const CustomButton(
                          title: 'View all debt data',
                        ),
                        const CustomButton(
                          title: 'Biometrie',
                        ),
                        CustomButton(
                          title: 'Delete all data',
                          press: () {
                            debugPrint('log out');
                          },
                        ),
                        CustomButton(
                          title: 'Logout',
                          color: AppColor.kredColor,
                          press: () {
                            debugPrint('log out');
                            ref
                                .read(authNotifierProvider.notifier)
                                .signOutGoogle();
                          },
                        ),
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

class CustomButton extends StatelessWidget {
  final String? title;
  final Color? color;
  final VoidCallback? press;
  const CustomButton({
    super.key,
    this.title,
    this.color = AppColor.kDarkGreyColor,
    this.press,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        width: double.infinity,
        alignment: Alignment.centerLeft,
        height: 5.h,
        margin: EdgeInsets.symmetric(vertical: 10.sp),
        padding: EdgeInsets.symmetric(horizontal: 15.sp),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.sp),
            color: color!.withOpacity(1.2.sp)),
        child: Text(title!),
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

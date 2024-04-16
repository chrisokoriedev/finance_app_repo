import 'package:expense_app/model/create_expense.dart';
import 'package:expense_app/provider/firebase.dart';
import 'package:expense_app/provider/item_provider.dart';
import 'package:expense_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProfileScreen extends HookConsumerWidget {
  final PageController pageController;

  const ProfileScreen(this.pageController, {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firebaseAuth = ref.watch(firebaseAuthProvider);
    final itemProvider = ref.watch(itemsProvider);
    Map<String, int> calculateLengths(List<CreateExpenseModel> data) {
      int incomeLength =
          data.where((expense) => expense.expenseType == "Income").length;
      int expenseLength =
          data.where((expense) => expense.expenseType == "Expense").length;
      int debtLength =
          data.where((expense) => expense.expenseType == "Debt").length;
      return {
        'Income': incomeLength,
        'Expense': expenseLength,
        'Debt': debtLength
      };
    }

    return PopScope(
        canPop: false,
        onPopInvoked: (value) => pageController.jumpToPage(0),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 20.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 10.w,
                height: 10.h,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(firebaseAuth
                                .currentUser!.photoURL ??
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWwb7VqZWWn6W92xv34aLhCXSrVGeArGHPhSKh4PysLQ&s'),
                        fit: BoxFit.cover)),
              ),
              Text(firebaseAuth.currentUser!.displayName ?? ""),
              Text(firebaseAuth.currentUser!.email ?? ""),
              Text(firebaseAuth.currentUser!.phoneNumber ?? ""),
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
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
              const CustomButton(
                title: 'View Income',
              ),
              const CustomButton(
                title: 'View Expense',
              ),
              const CustomButton(
                title: 'View Debt',
              ),
              const CustomButton(
                title: 'Biometrice',
              ),
              const CustomButton(
                title: 'Delete all data',
              ),
              const CustomButton(
                title: 'Logout',
              ),
            ],
          ),
        ));
  }
}

class CustomButton extends StatelessWidget {
  final String? title;
  const CustomButton({
    super.key,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      height: 5.h,
      margin: EdgeInsets.symmetric(vertical: 10.sp),
      padding: EdgeInsets.symmetric(horizontal: 15.sp),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
          color: AppColor.kDarkGreyColor.withOpacity(1.sp)),
      child: Text(title!),
    );
  }
}

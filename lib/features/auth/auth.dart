import 'package:expense_app/features/auth/notifer/auth_notifer.dart';
import 'package:expense_app/state/auth.dart';
import 'package:expense_app/utils/colors.dart';
import 'package:expense_app/utils/loading.dart';
import 'package:expense_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icon.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AuthScreen extends HookConsumerWidget {
  const AuthScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    ref.listen(authNotifierProvider, (previous, next) {
      next.maybeWhen(
        orElse: () => null,
        authenticated: (user) async {
          EasyLoading.showError('Am in');
          context.push(AppRouter.mainControl);
        },
        unauthenticated: (message) {
          EasyLoading.showError(message!);
        },
      );
    });
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            child: Container(
              width: 100.w,
              height: 70.h,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                  image: AssetImage('assets/bg.jpg'),
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              child: Container(
                width: 100.w,
                height: 30.h,
                decoration: BoxDecoration(
                    color: AppColor.kDarkGreyColor,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20.sp))),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Expense Tracker',
                        style: TextStyle(
                            color: AppColor.kWhitColor, fontSize: 18.sp),
                      ),
                      Gap(2.h),
                      GestureDetector(
                        onTap: () => ref
                            .read(authNotifierProvider.notifier)
                            .continueWithGoogle(),
                        child: Container(
                          width: 45.w,
                          padding: EdgeInsets.symmetric(vertical: 6.sp),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColor.kWhitColor, width: 0.4.w),
                              borderRadius: BorderRadius.circular(10.sp)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LineIcon.googlePlay(
                                  color: AppColor.kWhitColor, size: 19.sp),
                              Gap(2.w),
                              Text(
                                'Continue with google',
                                style: TextStyle(
                                    color: AppColor.kWhitColor,
                                    fontSize: 16.sp),
                              ),
                            ],
                          ),
                        ),
                      )
                    ]),
              )),
          if (authState == const AuthenticationState.loading())
            const LoadingWidget(),
        ],
      ),
    );
  }
}



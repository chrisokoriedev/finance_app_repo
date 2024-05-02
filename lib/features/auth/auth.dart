import 'package:cached_network_image/cached_network_image.dart';
import 'package:expense_app/notifer/auth_notifer.dart';
import 'package:expense_app/provider/item_provider.dart';
import 'package:expense_app/state/auth.dart';
import 'package:expense_app/utils/colors.dart';
import 'package:expense_app/utils/loading.dart';
import 'package:expense_app/utils/routes.dart';
import 'package:expense_app/utils/string_app.dart';
import 'package:expense_app/utils/text.dart';
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
    final imageUrlAsync = ref.watch(imageProvider);
    ref.listen(authNotifierProvider, (previous, next) {
      next.maybeWhen(
        orElse: () => null,
        authenticated: (user) async {
          EasyLoading.showSuccess('Am in');
          context.pushReplacement(AppRouter.mainControl);
        },
        unauthenticated: (message) {
          EasyLoading.showError(message!);
        },
      );
    });
    return Scaffold(
      backgroundColor: AppColor.kDarkGreyColor,
      body: Stack(
        children: [
          Positioned(
            child: Center(
              child: imageUrlAsync.when(
                data: (imageUrl) {
                  return CachedNetworkImage(
                      width: 100.w,
                      height: 100.h,
                      fit: BoxFit.cover,
                      imageUrl: imageUrl,
                      placeholder: (BuildContext context, String url) =>
                          const Center(
                              child: CircularProgressIndicator.adaptive()),
                      errorWidget:
                          (BuildContext context, String url, dynamic error) =>
                              LineIcon.fighterJet(size: 20.sp));
                },
                loading: () => TextWigdet(
                    text: 'Nora', color: AppColor.kWhitColor, fontSize: 20.sp),
                error: (error, stackTrace) => Center(
                    child: TextWigdet(
                        text: error.toString(),
                        color: AppColor.kWhitColor,
                        fontSize: 15.sp)),
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              child: Container(
                width: 100.w,
                height: 25.h,
                decoration: BoxDecoration(
                    color: AppColor.kDarkGreyColor,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20.sp))),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppString.appName,
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

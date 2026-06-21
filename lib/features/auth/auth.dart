import 'package:cached_network_image/cached_network_image.dart';
import 'package:expense_app/core/provider/app_provider.dart';
import 'package:expense_app/core/provider/item_provider.dart';
import 'package:expense_app/core/state/auth.dart';
import 'package:expense_app/core/utils/colors.dart';
import 'package:expense_app/core/utils/loading.dart';
import 'package:expense_app/core/utils/routes.dart';
import 'package:expense_app/core/utils/string_app.dart';
import 'package:expense_app/core/utils/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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

    // Form and input hooks
    final isLogin = useState(true);
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final isPasswordVisible = useState(false);
    final formKey = useMemoized(() => GlobalKey<FormState>());

    ref.listen(authNotifierProvider, (previous, next) {
      next.maybeWhen(
        orElse: () => null,
        authenticated: (user) async {
          EasyLoading.showSuccess('Logged in successfully');
          context.pushReplacement(AppRouter.mainControl);
        },
        unauthenticated: (message) {
          EasyLoading.showError(message ?? 'Authentication failed');
        },
      );
    });

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColor.kDarkGreyColor,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
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
              loading: () => Center(
                child: TextWidget(
                    text: 'Nora', color: AppColor.kWhitColor, fontSize: 20.sp),
              ),
              error: (error, stackTrace) => Center(
                  child: TextWidget(
                      text: error.toString(),
                      color: AppColor.kWhitColor,
                      fontSize: 15.sp)),
            ),
          ),

          // Authentication Panel
          Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Container(
                width: 100.w,
                padding: EdgeInsets.only(
                  left: 6.w,
                  right: 6.w,
                  top: 3.h,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 4.h,
                ),
                decoration: BoxDecoration(
                    color: AppColor.kDarkGreyColor.withOpacity(0.95),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20.sp))),
                child: Form(
                  key: formKey,
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Text(
                      AppString.appName,
                      style: TextStyle(
                          color: AppColor.kWhitColor,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    Gap(1.h),
                    Text(
                      isLogin.value
                          ? 'Sign in to your account'
                          : 'Create a new account',
                      style: TextStyle(
                          color: AppColor.kGreyColor, fontSize: 14.sp),
                    ),
                    Gap(3.h),

                    // Email Input
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: AppColor.kWhitColor),
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(
                            color: AppColor.kWhitColor.withOpacity(0.5),
                            fontSize: 15.sp),
                        prefixIcon: Icon(Icons.mail_outline,
                            color: AppColor.kWhitColor.withOpacity(0.7)),
                        filled: true,
                        fillColor: AppColor.kGreyColor.withOpacity(0.1),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 1.5.h),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.sp),
                          borderSide: BorderSide(
                              color: AppColor.kWhitColor.withOpacity(0.2),
                              width: 0.2.w),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.sp),
                          borderSide: BorderSide(
                              color: AppColor.kWhitColor.withOpacity(0.2),
                              width: 0.2.w),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.sp),
                          borderSide: BorderSide(
                              color: AppColor.kWhitColor, width: 0.4.w),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.sp),
                          borderSide: BorderSide(
                              color: AppColor.kredColor, width: 0.4.w),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.sp),
                          borderSide: BorderSide(
                              color: AppColor.kredColor, width: 0.4.w),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value.trim())) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    Gap(2.h),

                    // Password Input
                    TextFormField(
                      controller: passwordController,
                      obscureText: !isPasswordVisible.value,
                      style: const TextStyle(color: AppColor.kWhitColor),
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(
                            color: AppColor.kWhitColor.withOpacity(0.5),
                            fontSize: 15.sp),
                        prefixIcon: Icon(Icons.lock_outline,
                            color: AppColor.kWhitColor.withOpacity(0.7)),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordVisible.value
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: AppColor.kWhitColor.withOpacity(0.7),
                          ),
                          onPressed: () => isPasswordVisible.value =
                              !isPasswordVisible.value,
                        ),
                        filled: true,
                        fillColor: AppColor.kGreyColor.withOpacity(0.1),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 1.5.h),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.sp),
                          borderSide: BorderSide(
                              color: AppColor.kWhitColor.withOpacity(0.2),
                              width: 0.2.w),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.sp),
                          borderSide: BorderSide(
                              color: AppColor.kWhitColor.withOpacity(0.2),
                              width: 0.2.w),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.sp),
                          borderSide: BorderSide(
                              color: AppColor.kWhitColor, width: 0.4.w),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.sp),
                          borderSide: BorderSide(
                              color: AppColor.kredColor, width: 0.4.w),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.sp),
                          borderSide: BorderSide(
                              color: AppColor.kredColor, width: 0.4.w),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    Gap(3.h),

                    // Submit Button
                    GestureDetector(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          if (isLogin.value) {
                            ref
                                .read(authNotifierProvider.notifier)
                                .signInWithEmailAndPassword(
                                  emailController.text,
                                  passwordController.text,
                                );
                          } else {
                            ref
                                .read(authNotifierProvider.notifier)
                                .signUpWithEmailAndPassword(
                                  emailController.text,
                                  passwordController.text,
                                );
                          }
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 14.sp),
                        decoration: BoxDecoration(
                            color: AppColor.kWhitColor,
                            borderRadius: BorderRadius.circular(10.sp)),
                        child: Center(
                          child: Text(
                            isLogin.value ? 'Sign In' : 'Create Account',
                            style: TextStyle(
                                color: AppColor.kBlackColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp),
                          ),
                        ),
                      ),
                    ),
                    Gap(2.h),

                    // Mode Toggle
                    TextButton(
                      onPressed: () => isLogin.value = !isLogin.value,
                      child: Text(
                        isLogin.value
                            ? "Don't have an account? Sign Up"
                            : "Already have an account? Sign In",
                        style: TextStyle(
                            color: AppColor.kWhitColor.withOpacity(0.8),
                            fontSize: 14.sp),
                      ),
                    ),

                    Row(
                      children: [
                        Expanded(
                            child: Divider(
                                color: AppColor.kWhitColor.withOpacity(0.2))),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: Text('OR',
                              style: TextStyle(
                                  color: AppColor.kWhitColor.withOpacity(0.5),
                                  fontSize: 13.sp)),
                        ),
                        Expanded(
                            child: Divider(
                                color: AppColor.kWhitColor.withOpacity(0.2))),
                      ],
                    ),
                    Gap(2.h),

                    // Google Login Button
                    GestureDetector(
                      onTap: () => ref
                          .read(authNotifierProvider.notifier)
                          .continueWithGoogle(),
                      child: Container(
                        width: 60.w,
                        padding: EdgeInsets.symmetric(vertical: 8.sp),
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
                                  color: AppColor.kWhitColor, fontSize: 15.sp),
                            ),
                          ],
                        ),
                      ),
                    )
                  ]),
                ),
              ),
            ),
          ),

          if (authState == const AuthenticationState.loading())
            const LoadingWidget(),
        ],
      ),
    );
  }
}

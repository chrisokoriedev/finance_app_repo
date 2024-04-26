import 'package:expense_app/features/Porfile/bottomsheet/setting_and_support.dart';
import 'package:expense_app/notifer/auth_notifer.dart';
import 'package:expense_app/provider/firebase.dart';
import 'package:expense_app/utils/colors.dart';
import 'package:expense_app/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DeleteUserAccount extends HookConsumerWidget {
  const DeleteUserAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String emailText = '';
    final firebaseProvider = ref.watch(firebaseAuthProvider);
    final emailValidation = ref.watch(emailValidationProvider);
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 20.sp)
          .copyWith(bottom: MediaQuery.of(context).viewInsets.bottom + 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Delete User Account',
              style: TextStyle(fontSize: 16.sp, color: AppColor.kBlackColor)),
          Gap(2.h),
          CustomTextFormField(
              hintText: 'Enter current email account',
              textInputType: TextInputType.text,
              maxLine: 1,
              onChanged: (value) {
                emailText = value;
                ref.read(emailValidationProvider.notifier).state =
                    emailText == firebaseProvider.currentUser!.email;
              }),
          Gap(2.h),
          ElevatedButton(
              style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(
                    Size(double.maxFinite, 2.h),
                  ),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: customBorderRadius(10))),
                  backgroundColor: MaterialStateColor.resolveWith((states) =>
                      emailValidation
                          ? AppColor.kGreenColor.shade300
                          : AppColor.kredColor.shade300)),
              onPressed: emailValidation
                  ? () {
                      context.pop();
                      context.pop();
                      ref
                          .read(authNotifierProvider.notifier)
                          .deleteUserAccount();
                    }
                  : null,
              child: Text('Delete Account',
                  style:
                      TextStyle(fontSize: 14.sp, color: AppColor.kWhitColor))),
        ],
      ),
    );
  }
}

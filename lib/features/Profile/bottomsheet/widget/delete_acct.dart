import 'package:expense_app/features/Profile/bottomsheet/setting_and_support.dart';
import 'package:expense_app/core/provider/app_provider.dart';
import 'package:expense_app/core/provider/firebase.dart';
import 'package:expense_app/core/theme/neu_theme.dart';
import 'package:expense_app/core/utils/const.dart';
import 'package:expense_app/core/utils/text.dart';
import 'package:expense_app/core/widgets/neu.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DeleteUserAccount extends HookConsumerWidget {
  const DeleteUserAccount({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => _ConfirmEmailSheet(
        title: 'Delete account',
        action: 'Delete account',
        onConfirm: () {
          context.pop();
          context.pop();
          ref.read(authNotifierProvider.notifier).deleteUserAccount();
        },
      );
}

class ClearUserData extends HookConsumerWidget {
  const ClearUserData({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => _ConfirmEmailSheet(
        title: 'Clear all data',
        action: 'Clear data',
        onConfirm: () {
          context.pop();
          context.pop();
          ref.read(createExpenseNotifierProvider.notifier).deleteUserRecord();
        },
      );
}

class _ConfirmEmailSheet extends HookConsumerWidget {
  final String title;
  final String action;
  final VoidCallback onConfirm;
  const _ConfirmEmailSheet({
    required this.title,
    required this.action,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final neu = context.neu;
    final firebaseProvider = ref.watch(firebaseAuthProvider);
    final emailValidation = ref.watch(emailValidationProvider);
    String emailText = '';
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h)
          .copyWith(bottom: MediaQuery.of(context).viewInsets.bottom + 4.h),
      decoration: BoxDecoration(
        color: neu.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(
          top: BorderSide(color: neu.primary, width: 3),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                text: title,
                color: neu.textPrimary,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
              IconButton(
                icon: Icon(Icons.close, color: neu.textSecondary, size: 18.sp),
                onPressed: () => Navigator.pop(context),
              )
            ],
          ),
          Gap(1.h),
          TextWidget(
              text: 'Confirm your email to continue',
              color: neu.textSecondary,
              fontSize: 12.sp),
          Gap(2.5.h),
          CustomTextFormField(
            hintText: 'Enter your email',
            textInputType: TextInputType.emailAddress,
            maxLine: 1,
            onChanged: (value) {
              emailText = value;
              ref.read(emailValidationProvider.notifier).state =
                  emailText == firebaseProvider.currentUser!.email;
            },
          ),
          Gap(2.5.h),
          SizedBox(
            width: double.infinity,
            child: NeuButton(
              filled: emailValidation,
              color: emailValidation ? neu.expense : neu.surface,
              onTap: emailValidation ? onConfirm : null,
              child: TextWidget(
                  text: action,
                  fontSize: 14.5.sp,
                  fontWeight: FontWeight.w600,
                  color: emailValidation ? Colors.white : neu.textSecondary),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:gap/gap.dart';
import 'package:line_icons/line_icon.dart';

import '../../domain/enums.dart';
import '../../domain/result.dart';
import '../../providers/expense_providers.dart';
import '../../providers/auth_providers.dart' as auth_providers;
import '../../state/auth.dart';
import '../../utils/text.dart';
import '../../utils/user_avatar.dart';

/// Modern dashboard header with improved performance and design
class ModernDashboardHeader extends ConsumerWidget {
  final PageController pageController;

  const ModernDashboardHeader({
    super.key,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).colorScheme;
    final authAsync = ref.watch(auth_providers.authNotifierProvider);
    final summaryAsync = ref.watch(expenseSummaryNotifierProvider());

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.primaryContainer.withOpacity(0.8),
            theme.primaryContainer.withOpacity(0.6),
          ],
        ),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(25.sp),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with greeting and profile
          _buildHeader(context, theme, authAsync, ref), 
          Gap(3.h),
          
          // Balance card
          _buildBalanceCard(context, theme, summaryAsync),
          Gap(2.h),
          
          // Expense type cards
          _buildExpenseTypeCards(context, theme, summaryAsync),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ColorScheme theme, AsyncValue<Result<AuthenticationState>> authAsync, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Greeting and user info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: _getGreeting(),
                color: theme.onPrimaryContainer,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              Gap(0.5.h),
              authAsync.when(
                data: (result) {
                  if (result.isSuccess) {
                    final authState = result.data!;
                    return authState.whenOrNull(
                      authenticated: (user, loginTime) => TextWidget(
                        text: _getUserName(user.displayName ?? 'User'),
                        color: theme.onPrimaryContainer,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      initial: () => TextWidget(
                        text: 'Welcome!',
                        color: theme.onPrimaryContainer,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ) ?? TextWidget(
                      text: 'Welcome!',
                      color: theme.onPrimaryContainer,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    );
                  } else {
                    return TextWidget(
                      text: 'Welcome!',
                      color: theme.onPrimaryContainer,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    );
                  }
                },
                loading: () => TextWidget(
                  text: 'Loading...',
                  color: theme.onPrimaryContainer,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
                error: (error, stack) => TextWidget(
                  text: 'Welcome!',
                  color: theme.onPrimaryContainer,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        
        // Profile avatar
        GestureDetector(
          onTap: () => pageController.jumpToPage(3),
          child: Container(
            width: 12.w,
            height: 12.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: theme.onPrimaryContainer,
                width: 2,
              ),
            ),
            child: ClipOval(
              child: authAsync.when(
                data: (result) {
                  if (result.isSuccess) {
                    final authState = result.data!;
                    return authState.whenOrNull(
                      authenticated: (user, loginTime) =>                       UserAvatar(
                        firebaseAuth: ref.read(auth_providers.firebaseAuthProvider),
                      ),
                      initial: () => Icon(
                        Icons.person,
                        color: theme.onPrimaryContainer,
                        size: 6.w,
                      ),
                    );
                  } else {
                    return Icon(
                      Icons.person,
                      color: theme.onPrimaryContainer,
                      size: 6.w,
                    );
                  }
                },
                loading: () => CircularProgressIndicator(
                  color: theme.onPrimaryContainer,
                  strokeWidth: 2,
                ),
                error: (error, stack) => Icon(
                  Icons.person,
                  color: theme.onPrimaryContainer,
                  size: 6.w,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBalanceCard(BuildContext context, ColorScheme theme, AsyncValue<Result<Map<String, double>>> summaryAsync) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: theme.surface,
        borderRadius: BorderRadius.circular(15.sp),
        boxShadow: [
          BoxShadow(
            color: theme.shadow.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                text: 'Total Balance',
                color: theme.onSurface,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              LineIcon.horizontalEllipsis(
                color: theme.onSurface,
                size: 16.sp,
              ),
            ],
          ),
          Gap(1.h),
          summaryAsync.when(
            data: (result) {
              if (result.isSuccess) {
                final summary = result.data!;
                final totalIncome = summary['Income'] ?? 0;
                final totalExpense = summary['Expense'] ?? 0;
                final totalDebt = summary['Debt'] ?? 0;
                final balance = totalIncome - totalExpense - totalDebt;
                
                return TextWidget(
                  text: '₦${balance.toStringAsFixed(2)}',
                  color: balance >= 0 ? Colors.green : Colors.red,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                );
              } else {
                return TextWidget(
                  text: '₦0.00',
                  color: theme.onSurface,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                );
              }
            },
            loading: () => TextWidget(
              text: '₦0.00',
              color: theme.onSurface,
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
            ),
            error: (error, stack) => TextWidget(
              text: '₦0.00',
              color: theme.onSurface,
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseTypeCards(BuildContext context, ColorScheme theme, AsyncValue<Result<Map<String, double>>> summaryAsync) {
    return Row(
      children: [
        Expanded(
          child: _buildExpenseTypeCard(
            context,
            theme,
            'Income',
            Icons.trending_up,
            Colors.green,
            summaryAsync,
            'Income',
          ),
        ),
        Gap(2.w),
        Expanded(
          child: _buildExpenseTypeCard(
            context,
            theme,
            'Expense',
            Icons.trending_down,
            Colors.red,
            summaryAsync,
            'Expense',
          ),
        ),
        Gap(2.w),
        Expanded(
          child: _buildExpenseTypeCard(
            context,
            theme,
            'Debt',
            Icons.analytics,
            Colors.blue,
            summaryAsync,
            'Debt',
          ),
        ),
      ],
    );
  }

  Widget _buildExpenseTypeCard(
    BuildContext context,
    ColorScheme theme,
    String title,
    IconData icon,
    Color color,
    AsyncValue<Result<Map<String, double>>> summaryAsync,
    String summaryKey,
  ) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: theme.surface,
        borderRadius: BorderRadius.circular(12.sp),
        boxShadow: [
          BoxShadow(
            color: theme.shadow.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(6.sp),
            ),
            child: Icon(
              icon,
              color: color,
              size: 4.w,
            ),
          ),
          Gap(1.h),
          summaryAsync.when(
            data: (result) {
              if (result.isSuccess) {
                final amount = result.data![summaryKey] ?? 0;
                return TextWidget(
                  text: '₦${amount.toStringAsFixed(0)}',
                  color: theme.onSurface,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                );
              } else {
                return TextWidget(
                  text: '₦0',
                  color: theme.onSurface,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                );
              }
            },
            loading: () => TextWidget(
              text: '₦0',
              color: theme.onSurface,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
            error: (error, stack) => TextWidget(
              text: '₦0',
              color: theme.onSurface,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Gap(0.5.h),
          TextWidget(
            text: title,
            color: color.withOpacity(0.8),
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }

  String _getGreeting() {
    final greeting = Greeting.getCurrent();
    return greeting.displayName;
  }

  String _getUserName(String displayName) {
    if (displayName.isEmpty) return 'User';
    
    final nameParts = displayName.split(' ');
    if (nameParts.length > 1) {
      return nameParts.sublist(1).join(' ');
    }
    return nameParts.first;
  }
}

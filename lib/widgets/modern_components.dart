import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:gap/gap.dart';
import '../utils/text.dart';
import '../domain/enums.dart';

/// Modern loading indicator with animations
class ModernLoadingIndicator extends StatefulWidget {
  final String? message;
  final double size;
  final Color? color;

  const ModernLoadingIndicator({
    super.key,
    this.message,
    this.size = 50,
    this.color,
  });

  @override
  State<ModernLoadingIndicator> createState() => _ModernLoadingIndicatorState();
}

class _ModernLoadingIndicatorState extends State<ModernLoadingIndicator>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: SweepGradient(
                  colors: [
                    (widget.color ?? theme.primary).withOpacity(0.1),
                    widget.color ?? theme.primary,
                    (widget.color ?? theme.primary).withOpacity(0.1),
                  ],
                  startAngle: _animation.value * 2 * 3.14159,
                ),
              ),
              child: Center(
                child: Container(
                  width: widget.size * 0.7,
                  height: widget.size * 0.7,
                  decoration: BoxDecoration(
                    color: theme.surface,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.account_balance_wallet,
                    color: widget.color ?? theme.primary,
                    size: widget.size * 0.4,
                  ),
                ),
              ),
            );
          },
        ),
        if (widget.message != null) ...[
          Gap(2.h),
          TextWidget(
            text: widget.message!,
            color: theme.onSurface,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ],
      ],
    );
  }
}

/// Modern skeleton loading widget
class ModernSkeleton extends StatefulWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  const ModernSkeleton({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
  });

  @override
  State<ModernSkeleton> createState() => _ModernSkeletonState();
}

class _ModernSkeletonState extends State<ModernSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(begin: -1, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: theme.surface,
            borderRadius: widget.borderRadius ?? BorderRadius.circular(8.sp),
          ),
          child: ClipRRect(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(8.sp),
            child: ShaderMask(
              shaderCallback: (bounds) {
                return LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    theme.surface,
                    theme.surface.withOpacity(0.5), 
                    theme.surface,
                  ],
                  stops: [
                    _animation.value - 0.3,
                    _animation.value,
                    _animation.value + 0.3,
                  ],
                ).createShader(bounds);
              },
              child: Container(
                color: theme.surface,
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Modern expense card with animations
class ModernExpenseCard extends StatefulWidget {
  final String title;
  final double amount;
  final ExpenseType type;
  final String description;
  final DateTime date;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const ModernExpenseCard({
    super.key,
    required this.title,
    required this.amount,
    required this.type,
    required this.description,
    required this.date,
    this.onTap,
    this.onDelete,
  });

  @override
  State<ModernExpenseCard> createState() => _ModernExpenseCardState();
}

class _ModernExpenseCardState extends State<ModernExpenseCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _fadeAnimation = Tween<double>(begin: 1, end: 0.8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: GestureDetector(
              onTapDown: (_) => _controller.forward(),
              onTapUp: (_) {
                _controller.reverse();
                widget.onTap?.call();
              },
              onTapCancel: () => _controller.reverse(),
              child: Container(
                margin: EdgeInsets.only(bottom: 2.h),
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: theme.surface,
                  borderRadius: BorderRadius.circular(12.sp),
                  boxShadow: [
                    BoxShadow(
                      color: theme.shadow.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Type indicator
                    Container(
                      width: 12.w,
                      height: 12.w,
                      decoration: BoxDecoration(
                        color: widget.type.color.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8.sp),
                      ),
                      child: Center(
                        child: Text(
                          widget.type.emoji,
                          style: TextStyle(fontSize: 6.w),
                        ),
                      ),
                    ),
                    Gap(3.w),
                    
                    // Content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TextWidget(
                                  text: widget.title,
                                  color: theme.onSurface,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  maxLine: 1,
                                ),
                              ),
                              TextWidget(
                                text: '₦${widget.amount.toStringAsFixed(2)}',
                                color: widget.type.color,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ],
                          ),
                          Gap(0.5.h),
                          TextWidget(
                            text: widget.description,
                            color: theme.onSurface.withOpacity(0.7),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            maxLine: 2,
                          ),
                          Gap(0.5.h),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 4.w,
                                color: theme.onSurface.withOpacity(0.5),
                              ),
                              Gap(1.w),
                              TextWidget(
                                text: _formatDate(widget.date),
                                color: theme.onSurface.withOpacity(0.5),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              const Spacer(),
                              TextWidget(
                                text: widget.type.displayName,
                                color: widget.type.color,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    // Delete button
                    if (widget.onDelete != null) ...[
                      Gap(2.w),
                      GestureDetector(
                        onTap: widget.onDelete,
                        child: Container(
                          padding: EdgeInsets.all(2.w),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6.sp),
                          ),
                          child: Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                            size: 5.w,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;
    
    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Yesterday';
    } else if (difference < 7) {
      return '$difference days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}

/// Modern floating action button with animations
class ModernFloatingActionButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final String? tooltip;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const ModernFloatingActionButton({
    super.key,
    this.onPressed,
    this.icon = Icons.add,
    this.tooltip,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  State<ModernFloatingActionButton> createState() => _ModernFloatingActionButtonState();
}

class _ModernFloatingActionButtonState extends State<ModernFloatingActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1, end: 0.9).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _rotationAnimation = Tween<double>(begin: 0, end: 0.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Transform.rotate(
            angle: _rotationAnimation.value,
            child: FloatingActionButton(
              onPressed: () {
                _controller.forward().then((_) {
                  _controller.reverse();
                  widget.onPressed?.call();
                });
              },
              backgroundColor: widget.backgroundColor ?? theme.primary,
              foregroundColor: widget.foregroundColor ?? theme.onPrimary,
              tooltip: widget.tooltip,
              child: Icon(widget.icon),
            ),
          ),
        );
      },
    );
  }
}

/// Modern empty state widget
class ModernEmptyState extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback? onAction;
  final String? actionText;

  const ModernEmptyState({
    super.key,
    required this.title,
    required this.description,
    this.icon = Icons.inbox_outlined,
    this.onAction,
    this.actionText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    
    return Center(
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                color: theme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 10.w,
                color: theme.primary,
              ),
            ),
            Gap(4.h),
             TextWidget(
               text: title,
               color: theme.onSurface,
               fontSize: 18.sp,
               fontWeight: FontWeight.w600,
               textAlign: TextAlign.center,
             ),
             Gap(2.h),
             TextWidget(
               text: description,
               color: theme.onSurface.withOpacity(0.7),
               fontSize: 14.sp,
               fontWeight: FontWeight.w400,
               textAlign: TextAlign.center,
             ),
            if (onAction != null && actionText != null) ...[
              Gap(4.h),
              ElevatedButton(
                onPressed: onAction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primary,
                  foregroundColor: theme.onPrimary,
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.sp),
                  ),
                ),
                child: TextWidget(
                  text: actionText!,
                  color: theme.onPrimary,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

import 'package:expense_app/core/theme/neu_theme.dart';
import 'package:flutter/material.dart';

/// A raised (extruded) neumorphic surface.
class NeuCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  final Color? color;
  final VoidCallback? onTap;

  const NeuCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.radius = 24,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final neu = context.neu;
    final box = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? neu.surface,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: neu.raised,
      ),
      child: child,
    );
    if (onTap == null) return box;
    return GestureDetector(onTap: onTap, child: box);
  }
}

/// An inset (pressed-in) neumorphic surface — fields, tracks, wells.
class NeuWell extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;

  const NeuWell({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(14),
    this.radius = 15,
  });

  @override
  Widget build(BuildContext context) {
    final neu = context.neu;
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: neu.surface,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: neu.inset,
      ),
      child: child,
    );
  }
}

/// A small color-tinted icon well (flat, lively) used for categories/stats.
class NeuIconWell extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;
  final double radius;

  const NeuIconWell({
    super.key,
    required this.icon,
    required this.color,
    this.size = 42,
    this.radius = 14,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withOpacity(0.16),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Icon(icon, color: color, size: size * 0.46),
    );
  }
}

/// A small tinted status/streak pill: icon + label in one accent color.
class NeuPill extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const NeuPill({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 14),
          const SizedBox(width: 6),
          Text(label,
              style: TextStyle(
                  color: color, fontSize: 11, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

/// An inset segmented control: the track is pressed in, the active segment is
/// a raised pill. [activeColor] tints the active label (defaults to primary).
class NeuSegmented extends StatelessWidget {
  final List<String> segments;
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final Color? activeColor;

  const NeuSegmented({
    super.key,
    required this.segments,
    required this.selectedIndex,
    required this.onChanged,
    this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    final neu = context.neu;
    final active = activeColor ?? neu.primary;
    return NeuWell(
      padding: const EdgeInsets.all(5),
      radius: 16,
      child: Row(
        children: List.generate(segments.length, (i) {
          final isActive = i == selectedIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(i),
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 9),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isActive ? neu.surface : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: isActive ? neu.raised : null,
                ),
                child: Text(
                  segments[i],
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: isActive ? FontWeight.w500 : FontWeight.w400,
                    color: isActive ? active : neu.textSecondary,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

/// A raised neumorphic button. [filled] paints the [color] as the background
/// (for the primary call-to-action); otherwise it sits on the surface.
class NeuButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget child;
  final Color? color;
  final bool filled;
  final double radius;
  final EdgeInsetsGeometry padding;

  const NeuButton({
    super.key,
    required this.child,
    this.onTap,
    this.color,
    this.filled = false,
    this.radius = 16,
    this.padding = const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
  });

  @override
  Widget build(BuildContext context) {
    final neu = context.neu;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: filled ? (color ?? neu.primary) : neu.surface,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: neu.raised,
        ),
        child: child,
      ),
    );
  }
}

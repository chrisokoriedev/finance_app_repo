import 'package:flutter/material.dart';

/// Neumorphic design tokens for the app, exposed as a [ThemeExtension] so the
/// same widgets adapt to light and dark mode. Read via `context.neu`.
@immutable
class NeuColors extends ThemeExtension<NeuColors> {
  final Color surface;
  final Color shadowDark;
  final Color shadowLight;
  final Color textPrimary;
  final Color textSecondary;

  /// Primary brand / actions / positive (income). Teal.
  final Color primary;

  /// Personality accent — streaks, goals, milestones. Amber.
  final Color accent;

  final Color income;
  final Color expense;
  final Color debt;

  const NeuColors({
    required this.surface,
    required this.shadowDark,
    required this.shadowLight,
    required this.textPrimary,
    required this.textSecondary,
    required this.primary,
    required this.accent,
    required this.income,
    required this.expense,
    required this.debt,
  });

  /// Raised (extruded) elevation — soft modern drop shadow.
  List<BoxShadow> get raised => [
        BoxShadow(
            color: shadowDark.withOpacity(0.4),
            offset: const Offset(0, 6),
            blurRadius: 16),
      ];

  /// Inset (pressed-in) elevation, using inner blur for the dual shadow.
  List<BoxShadow> get inset => [
        BoxShadow(
            color: shadowDark,
            offset: const Offset(2, 2),
            blurRadius: 4,
            blurStyle: BlurStyle.inner),
      ];

  /// Faint tinted fill for colored icon wells.
  Color tint(Color c) => c.withOpacity(0.16);

  static const NeuColors dark = NeuColors(
    surface: Color(0xFF202328), // Sleek slightly lighter card surface
    shadowDark: Color(0xFF0F1113), // Deep dark shadow for contrast
    shadowLight: Color(0xFF2E323A),
    textPrimary: Color(0xFFECEEF2),
    textSecondary: Color(0xFF8A909F),
    primary: Color(0xFF60D3A8), // Elegant mint/teal green
    accent: Color(0xFFECAE5C), // Warm gold/amber
    income: Color(0xFF60D3A8),
    expense: Color(0xFFDE7D6B), // Soft coral/red
    debt: Color(0xFF7D99D6), // Slate blue
  );

  static const NeuColors light = NeuColors(
    surface: Color(0xFFE8EBF0),
    shadowDark: Color(0xFFC4C8D0),
    shadowLight: Color(0xFFFFFFFF),
    textPrimary: Color(0xFF2A2D34),
    textSecondary: Color(0xFF6E727C),
    primary: Color(0xFF2BA597),
    accent: Color(0xFFC4881C),
    income: Color(0xFF2BA597),
    expense: Color(0xFFCB5B5B),
    debt: Color(0xFF4F79C7),
  );

  @override
  NeuColors copyWith({
    Color? surface,
    Color? shadowDark,
    Color? shadowLight,
    Color? textPrimary,
    Color? textSecondary,
    Color? primary,
    Color? accent,
    Color? income,
    Color? expense,
    Color? debt,
  }) {
    return NeuColors(
      surface: surface ?? this.surface,
      shadowDark: shadowDark ?? this.shadowDark,
      shadowLight: shadowLight ?? this.shadowLight,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      primary: primary ?? this.primary,
      accent: accent ?? this.accent,
      income: income ?? this.income,
      expense: expense ?? this.expense,
      debt: debt ?? this.debt,
    );
  }

  @override
  NeuColors lerp(ThemeExtension<NeuColors>? other, double t) {
    if (other is! NeuColors) return this;
    return NeuColors(
      surface: Color.lerp(surface, other.surface, t)!,
      shadowDark: Color.lerp(shadowDark, other.shadowDark, t)!,
      shadowLight: Color.lerp(shadowLight, other.shadowLight, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      income: Color.lerp(income, other.income, t)!,
      expense: Color.lerp(expense, other.expense, t)!,
      debt: Color.lerp(debt, other.debt, t)!,
    );
  }
}

/// Ergonomic access to the neumorphic tokens: `context.neu.primary`.
extension NeuContext on BuildContext {
  NeuColors get neu => Theme.of(this).extension<NeuColors>() ?? NeuColors.dark;
}

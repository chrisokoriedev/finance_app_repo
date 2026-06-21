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

  /// Raised (extruded) elevation — light source top-left.
  List<BoxShadow> get raised => [
        BoxShadow(
            color: shadowDark, offset: const Offset(5, 5), blurRadius: 12),
        BoxShadow(
            color: shadowLight, offset: const Offset(-5, -5), blurRadius: 12),
      ];

  /// Inset (pressed-in) elevation, using inner blur for the dual shadow.
  List<BoxShadow> get inset => [
        BoxShadow(
            color: shadowDark,
            offset: const Offset(3, 3),
            blurRadius: 6,
            blurStyle: BlurStyle.inner),
        BoxShadow(
            color: shadowLight,
            offset: const Offset(-3, -3),
            blurRadius: 6,
            blurStyle: BlurStyle.inner),
      ];

  /// Faint tinted fill for colored icon wells.
  Color tint(Color c) => c.withOpacity(0.16);

  static const NeuColors dark = NeuColors(
    surface: Color(0xFF24262B),
    shadowDark: Color(0xFF191A1E),
    shadowLight: Color(0xFF2F3138),
    textPrimary: Color(0xFFECEEF2),
    textSecondary: Color(0xFF93969F),
    primary: Color(0xFF4FC4B0),
    accent: Color(0xFFE8B15A),
    income: Color(0xFF4FC4B0),
    expense: Color(0xFFE58A8A),
    debt: Color(0xFF8AA8E6),
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
  NeuColors get neu =>
      Theme.of(this).extension<NeuColors>() ?? NeuColors.dark;
}

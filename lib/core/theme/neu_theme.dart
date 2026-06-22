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

  static const NeuColors limeBlack = NeuColors(
    surface: Color(0xFF121212),
    shadowDark: Color(0xFF000000),
    shadowLight: Color(0xFF262626),
    textPrimary: Color(0xFFFFFFFF),
    textSecondary: Color(0xFFA3A3A3),
    primary: Color(0xFFBEF532),
    accent: Color(0xFFBEF532),
    income: Color(0xFFBEF532),
    expense: Color(0xFFDE7D6B),
    debt: Color(0xFF7D99D6),
  );

  static const NeuColors mintCarbon = NeuColors(
    surface: Color(0xFF171F20),
    shadowDark: Color(0xFF070A0B),
    shadowLight: Color(0xFF253132),
    textPrimary: Color(0xFFFFFFFF),
    textSecondary: Color(0xFF8CA5A7),
    primary: Color(0xFF54E6D4),
    accent: Color(0xFF54E6D4),
    income: Color(0xFF54E6D4),
    expense: Color(0xFFDE7D6B),
    debt: Color(0xFF7D99D6),
  );

  static const NeuColors goldBlack = NeuColors(
    surface: Color(0xFF081424),
    shadowDark: Color(0xFF000206),
    shadowLight: Color(0xFF10243C),
    textPrimary: Color(0xFFFFFFFF),
    textSecondary: Color(0xFFA1B2C6),
    primary: Color(0xFFF5CE0A),
    accent: Color(0xFFF5CE0A),
    income: Color(0xFFF5CE0A),
    expense: Color(0xFFDE7D6B),
    debt: Color(0xFF7D99D6),
  );

  static const NeuColors plumMilk = NeuColors(
    surface: Color(0xFF492442),
    shadowDark: Color(0xFF210C1D),
    shadowLight: Color(0xFF5D3355),
    textPrimary: Color(0xFFFFF3E6),
    textSecondary: Color(0xFFD4C4B5),
    primary: Color(0xFFFFF3E6),
    accent: Color(0xFFFFF3E6),
    income: Color(0xFFFFF3E6),
    expense: Color(0xFFDE7D6B),
    debt: Color(0xFF7D99D6),
  );

  static const NeuColors indigoGhost = NeuColors(
    surface: Color(0xFF34258C),
    shadowDark: Color(0xFF140B4B),
    shadowLight: Color(0xFF4838A6),
    textPrimary: Color(0xFFF7F7FF),
    textSecondary: Color(0xFFAEA6E6),
    primary: Color(0xFFF7F7FF),
    accent: Color(0xFFFFD700),
    income: Color(0xFF00F2FE),
    expense: Color(0xFFDE7D6B),
    debt: Color(0xFFFFD700),
  );

  static const NeuColors aureolinBistre = NeuColors(
    surface: Color(0xFF331F0A),
    shadowDark: Color(0xFF120901),
    shadowLight: Color(0xFF4A2F14),
    textPrimary: Color(0xFFFFFFFF),
    textSecondary: Color(0xFFC4A78A),
    primary: Color(0xFFFAE311),
    accent: Color(0xFFFAE311),
    income: Color(0xFFFAE311),
    expense: Color(0xFFDE7D6B),
    debt: Color(0xFF7D99D6),
  );

  static const NeuColors gambogePenn = NeuColors(
    surface: Color(0xFF131952),
    shadowDark: Color(0xFF03051F),
    shadowLight: Color(0xFF20276E),
    textPrimary: Color(0xFFF7F7FF),
    textSecondary: Color(0xFF8E95C7),
    primary: Color(0xFFE59500),
    accent: Color(0xFFFAE311),
    income: Color(0xFFE59500),
    expense: Color(0xFFDE7D6B),
    debt: Color(0xFF7D99D6),
  );

  static const NeuColors wineSand = NeuColors(
    surface: Color(0xFF910D27),
    shadowDark: Color(0xFF4D000B),
    shadowLight: Color(0xFFB01D3A),
    textPrimary: Color(0xFFF5EBD0),
    textSecondary: Color(0xFFD6C8A6),
    primary: Color(0xFFF5EBD0),
    accent: Color(0xFFE59500),
    income: Color(0xFFF5EBD0),
    expense: Color(0xFFFFA39E),
    debt: Color(0xFFE59500),
  );

  static const NeuColors cyberCharcoal = NeuColors(
    surface: Color(0xFF16161C),
    shadowDark: Color(0xFF07070A),
    shadowLight: Color(0xFF22222B),
    textPrimary: Color(0xFFFFFFFF),
    textSecondary: Color(0xFF8A909F),
    primary: Color(0xFFF1FF0A),
    accent: Color(0xFFFAE311),
    income: Color(0xFFF1FF0A),
    expense: Color(0xFFDE7D6B),
    debt: Color(0xFF7D99D6),
  );

  static const NeuColors dark = cyberCharcoal;
  static const NeuColors light = cyberCharcoal;

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

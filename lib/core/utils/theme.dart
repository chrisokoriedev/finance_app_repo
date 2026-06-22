import 'package:expense_app/core/theme/neu_theme.dart';
import 'package:expense_app/core/utils/string_app.dart';
import 'package:flutter/material.dart';

// Helper method to retrieve a theme configuration by its string key
ThemeData getThemeData(String themeName) {
  switch (themeName) {
    case AppString.themeLimeBlack:
      return limeBlackTheme;
    case AppString.themeMintCarbon:
      return mintCarbonTheme;
    case AppString.themeGoldBlack:
      return goldBlackTheme;
    case AppString.themePlumMilk:
      return plumMilkTheme;
    case AppString.themeIndigoGhost:
      return indigoGhostTheme;
    case AppString.themeAureolinBistre:
      return aureolinBistreTheme;
    case AppString.themeGambogePenn:
      return gambogePennTheme;
    case AppString.themeWineSand:
      return wineSandTheme;
    case AppString.themeCyberCharcoal:
      return cyberCharcoalTheme;
    default:
      return cyberCharcoalTheme;
  }
}

// Fallback legacy themes to avoid compilation errors elsewhere
ThemeData lightTheme = cyberCharcoalTheme;
ThemeData darkTheme = cyberCharcoalTheme;

final ThemeData limeBlackTheme = ThemeData(
  extensions: const [NeuColors.limeBlack],
  appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF000000), elevation: 0),
  bottomAppBarTheme: const BottomAppBarThemeData(color: Color(0xFF000000)),
  scaffoldBackgroundColor: const Color(0xFF000000),
  bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Color(0xFF000000)),
  colorScheme: ColorScheme.fromSeed(
    primary: const Color(0xFFBEF532),
    onPrimary: const Color(0xFF000000),
    seedColor: const Color(0xFFBEF532),
    brightness: Brightness.dark,
    primaryContainer: const Color(0xFF121212),
    shadow: const Color(0xFF000000),
    onPrimaryContainer: const Color(0xFF121212),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF17191C),
  ),
);

final ThemeData mintCarbonTheme = ThemeData(
  extensions: const [NeuColors.mintCarbon],
  appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF101516), elevation: 0),
  bottomAppBarTheme: const BottomAppBarThemeData(color: Color(0xFF101516)),
  scaffoldBackgroundColor: const Color(0xFF101516),
  bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Color(0xFF101516)),
  colorScheme: ColorScheme.fromSeed(
    primary: const Color(0xFF54E6D4),
    onPrimary: const Color(0xFF101516),
    seedColor: const Color(0xFF54E6D4),
    brightness: Brightness.dark,
    primaryContainer: const Color(0xFF171F20),
    shadow: const Color(0xFF070A0B),
    onPrimaryContainer: const Color(0xFF171F20),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF17191C),
  ),
);

final ThemeData goldBlackTheme = ThemeData(
  extensions: const [NeuColors.goldBlack],
  appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF000812), elevation: 0),
  bottomAppBarTheme: const BottomAppBarThemeData(color: Color(0xFF000812)),
  scaffoldBackgroundColor: const Color(0xFF000812),
  bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Color(0xFF000812)),
  colorScheme: ColorScheme.fromSeed(
    primary: const Color(0xFFF5CE0A),
    onPrimary: const Color(0xFF000812),
    seedColor: const Color(0xFFF5CE0A),
    brightness: Brightness.dark,
    primaryContainer: const Color(0xFF081424),
    shadow: const Color(0xFF000206),
    onPrimaryContainer: const Color(0xFF081424),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF17191C),
  ),
);

final ThemeData plumMilkTheme = ThemeData(
  extensions: const [NeuColors.plumMilk],
  appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF381932), elevation: 0),
  bottomAppBarTheme: const BottomAppBarThemeData(color: Color(0xFF381932)),
  scaffoldBackgroundColor: const Color(0xFF381932),
  bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Color(0xFF381932)),
  colorScheme: ColorScheme.fromSeed(
    primary: const Color(0xFFFFF3E6),
    onPrimary: const Color(0xFF381932),
    seedColor: const Color(0xFFFFF3E6),
    brightness: Brightness.dark,
    primaryContainer: const Color(0xFF492442),
    shadow: const Color(0xFF210C1D),
    onPrimaryContainer: const Color(0xFF492442),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF17191C),
  ),
);

final ThemeData indigoGhostTheme = ThemeData(
  extensions: const [NeuColors.indigoGhost],
  appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF27187E), elevation: 0),
  bottomAppBarTheme: const BottomAppBarThemeData(color: Color(0xFF27187E)),
  scaffoldBackgroundColor: const Color(0xFF27187E),
  bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Color(0xFF27187E)),
  colorScheme: ColorScheme.fromSeed(
    primary: const Color(0xFFF7F7FF),
    onPrimary: const Color(0xFF27187E),
    seedColor: const Color(0xFF27187E),
    brightness: Brightness.dark,
    primaryContainer: const Color(0xFF34258C),
    shadow: const Color(0xFF140B4B),
    onPrimaryContainer: const Color(0xFF34258C),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF17191C),
  ),
);

final ThemeData aureolinBistreTheme = ThemeData(
  extensions: const [NeuColors.aureolinBistre],
  appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF251605), elevation: 0),
  bottomAppBarTheme: const BottomAppBarThemeData(color: Color(0xFF251605)),
  scaffoldBackgroundColor: const Color(0xFF251605),
  bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Color(0xFF251605)),
  colorScheme: ColorScheme.fromSeed(
    primary: const Color(0xFFFAE311),
    onPrimary: const Color(0xFF251605),
    seedColor: const Color(0xFFFAE311),
    brightness: Brightness.dark,
    primaryContainer: const Color(0xFF331F0A),
    shadow: const Color(0xFF120901),
    onPrimaryContainer: const Color(0xFF331F0A),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF17191C),
  ),
);

final ThemeData gambogePennTheme = ThemeData(
  extensions: const [NeuColors.gambogePenn],
  appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF0A1045), elevation: 0),
  bottomAppBarTheme: const BottomAppBarThemeData(color: Color(0xFF0A1045)),
  scaffoldBackgroundColor: const Color(0xFF0A1045),
  bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Color(0xFF0A1045)),
  colorScheme: ColorScheme.fromSeed(
    primary: const Color(0xFFE59500),
    onPrimary: const Color(0xFF0A1045),
    seedColor: const Color(0xFF0A1045),
    brightness: Brightness.dark,
    primaryContainer: const Color(0xFF131952),
    shadow: const Color(0xFF03051F),
    onPrimaryContainer: const Color(0xFF131952),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF17191C),
  ),
);

final ThemeData wineSandTheme = ThemeData(
  extensions: const [NeuColors.wineSand],
  appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF7F011F), elevation: 0),
  bottomAppBarTheme: const BottomAppBarThemeData(color: Color(0xFF7F011F)),
  scaffoldBackgroundColor: const Color(0xFF7F011F),
  bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Color(0xFF7F011F)),
  colorScheme: ColorScheme.fromSeed(
    primary: const Color(0xFFF5EBD0),
    onPrimary: const Color(0xFF7F011F),
    seedColor: const Color(0xFF7F011F),
    brightness: Brightness.dark,
    primaryContainer: const Color(0xFF910D27),
    shadow: const Color(0xFF4D000B),
    onPrimaryContainer: const Color(0xFF910D27),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF17191C),
  ),
);

final ThemeData cyberCharcoalTheme = ThemeData(
  extensions: const [NeuColors.cyberCharcoal],
  appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF0D0D11), elevation: 0),
  bottomAppBarTheme: const BottomAppBarThemeData(color: Color(0xFF0D0D11)),
  scaffoldBackgroundColor: const Color(0xFF0D0D11),
  bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Color(0xFF0D0D11)),
  colorScheme: ColorScheme.fromSeed(
    primary: const Color(0xFFF1FF0A),
    onPrimary: const Color(0xFF0D0D11),
    seedColor: const Color(0xFF0D0D11),
    brightness: Brightness.dark,
    primaryContainer: const Color(0xFF16161C),
    shadow: const Color(0xFF07070A),
    onPrimaryContainer: const Color(0xFF16161C),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF17191C),
  ),
);

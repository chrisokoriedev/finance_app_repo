import 'package:expense_app/core/theme/neu_theme.dart';
import 'package:expense_app/core/provider/theme.dart';
import 'package:expense_app/core/utils/string_app.dart';
import 'package:expense_app/core/utils/text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:gap/gap.dart';

class ThemeSelectionScreen extends HookConsumerWidget {
  const ThemeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final neu = context.neu;
    final activeThemeKey = ref.watch(themeProvider);

    // Color definitions matching the 9 NeuColors mapping
    final List<ThemeOption> themes = [
      const ThemeOption(
        key: AppString.themeLimeBlack,
        name: AppString.nameLimeBlack,
        scaffoldBg: Color(0xFF000000),
        cardSurface: Color(0xFF121212),
        primary: Color(0xFFBEF532),
        textPrimary: Color(0xFFFFFFFF),
        textSecondary: Color(0xFFA3A3A3),
        shadowDark: Color(0xFF000000),
        shadowLight: Color(0xFF262626),
      ),
      const ThemeOption(
        key: AppString.themeMintCarbon,
        name: AppString.nameMintCarbon,
        scaffoldBg: Color(0xFF101516),
        cardSurface: Color(0xFF171F20),
        primary: Color(0xFF54E6D4),
        textPrimary: Color(0xFFFFFFFF),
        textSecondary: Color(0xFF8CA5A7),
        shadowDark: Color(0xFF070A0B),
        shadowLight: Color(0xFF253132),
      ),
      const ThemeOption(
        key: AppString.themeGoldBlack,
        name: AppString.nameGoldBlack,
        scaffoldBg: Color(0xFF000812),
        cardSurface: Color(0xFF081424),
        primary: Color(0xFFF5CE0A),
        textPrimary: Color(0xFFFFFFFF),
        textSecondary: Color(0xFFA1B2C6),
        shadowDark: Color(0xFF000206),
        shadowLight: Color(0xFF10243C),
      ),
      const ThemeOption(
        key: AppString.themePlumMilk,
        name: AppString.namePlumMilk,
        scaffoldBg: Color(0xFF381932),
        cardSurface: Color(0xFF492442),
        primary: Color(0xFFFFF3E6),
        textPrimary: Color(0xFFFFF3E6),
        textSecondary: Color(0xFFD4C4B5),
        shadowDark: Color(0xFF210C1D),
        shadowLight: Color(0xFF5D3355),
      ),
      const ThemeOption(
        key: AppString.themeIndigoGhost,
        name: AppString.nameIndigoGhost,
        scaffoldBg: Color(0xFF27187E),
        cardSurface: Color(0xFF34258C),
        primary: Color(0xFFF7F7FF),
        textPrimary: Color(0xFFF7F7FF),
        textSecondary: Color(0xFFAEA6E6),
        shadowDark: Color(0xFF140B4B),
        shadowLight: Color(0xFF4838A6),
      ),
      const ThemeOption(
        key: AppString.themeAureolinBistre,
        name: AppString.nameAureolinBistre,
        scaffoldBg: Color(0xFF251605),
        cardSurface: Color(0xFF331F0A),
        primary: Color(0xFFFAE311),
        textPrimary: Color(0xFFFFFFFF),
        textSecondary: Color(0xFFC4A78A),
        shadowDark: Color(0xFF120901),
        shadowLight: Color(0xFF4A2F14),
      ),
      const ThemeOption(
        key: AppString.themeGambogePenn,
        name: AppString.nameGambogePenn,
        scaffoldBg: Color(0xFF0A1045),
        cardSurface: Color(0xFF131952),
        primary: Color(0xFFE59500),
        textPrimary: Color(0xFFF7F7FF),
        textSecondary: Color(0xFF8E95C7),
        shadowDark: Color(0xFF03051F),
        shadowLight: Color(0xFF20276E),
      ),
      const ThemeOption(
        key: AppString.themeWineSand,
        name: AppString.nameWineSand,
        scaffoldBg: Color(0xFF7F011F),
        cardSurface: Color(0xFF910D27),
        primary: Color(0xFFF5EBD0),
        textPrimary: Color(0xFFF5EBD0),
        textSecondary: Color(0xFFD6C8A6),
        shadowDark: Color(0xFF4D000B),
        shadowLight: Color(0xFFB01D3A),
      ),
      const ThemeOption(
        key: AppString.themeCyberCharcoal,
        name: AppString.nameCyberCharcoal,
        scaffoldBg: Color(0xFF0D0D11),
        cardSurface: Color(0xFF16161C),
        primary: Color(0xFFF1FF0A),
        textPrimary: Color(0xFFFFFFFF),
        textSecondary: Color(0xFF8A909F),
        shadowDark: Color(0xFF07070A),
        shadowLight: Color(0xFF22222B),
      ),
    ];

    return Scaffold(
      backgroundColor: neu.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: neu.textPrimary, size: 18.sp),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: TextWidget(
          text: 'App Theme',
          color: neu.textPrimary,
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 10.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: 'Choose your color style',
                    color: neu.textPrimary,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  Gap(4.sp),
                  TextWidget(
                    text: 'Select a custom palette to personalize your neumorphic workspace.',
                    color: neu.textSecondary,
                    fontSize: 13.sp,
                    maxLine: 2,
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
                itemCount: themes.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15.sp,
                  mainAxisSpacing: 15.sp,
                  childAspectRatio: 0.85,
                ),
                itemBuilder: (context, index) {
                  final themeOption = themes[index];
                  final isSelected = activeThemeKey == themeOption.key;

                  return GestureDetector(
                    onTap: () async {
                      ref.read(themeProvider.notifier).state = themeOption.key;
                      await ref.read(themeStateNofiter.notifier).switchTheme(themeOption.key);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      padding: EdgeInsets.all(12.sp),
                      decoration: BoxDecoration(
                        color: themeOption.cardSurface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? themeOption.primary : Colors.transparent,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: themeOption.shadowDark.withOpacity(isSelected ? 0.6 : 0.4),
                            offset: const Offset(0, 6),
                            blurRadius: 14,
                          ),
                          BoxShadow(
                            color: themeOption.shadowLight.withOpacity(isSelected ? 0.15 : 0.08),
                            offset: const Offset(-2, -2),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Small Color Bubbles Preview
                              Row(
                                children: [
                                  _colorBubble(themeOption.scaffoldBg),
                                  Gap(4.sp),
                                  _colorBubble(themeOption.cardSurface),
                                  Gap(4.sp),
                                  _colorBubble(themeOption.primary),
                                ],
                              ),
                              if (isSelected)
                                Icon(
                                  LineIcons.checkCircle,
                                  color: themeOption.primary,
                                  size: 18.sp,
                                )
                              else
                                Icon(
                                  LineIcons.circle,
                                  color: themeOption.textSecondary.withOpacity(0.4),
                                  size: 18.sp,
                                ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                text: themeOption.name,
                                color: themeOption.textPrimary,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              Gap(2.sp),
                              TextWidget(
                                text: 'Contrast Palette',
                                color: themeOption.textSecondary,
                                fontSize: 11.sp,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _colorBubble(Color color) {
    return Container(
      width: 14.sp,
      height: 14.sp,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white24,
          width: 1,
        ),
      ),
    );
  }
}

class ThemeOption {
  final String key;
  final String name;
  final Color scaffoldBg;
  final Color cardSurface;
  final Color primary;
  final Color textPrimary;
  final Color textSecondary;
  final Color shadowDark;
  final Color shadowLight;

  const ThemeOption({
    required this.key,
    required this.name,
    required this.scaffoldBg,
    required this.cardSurface,
    required this.primary,
    required this.textPrimary,
    required this.textSecondary,
    required this.shadowDark,
    required this.shadowLight,
  });
}

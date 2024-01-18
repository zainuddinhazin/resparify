import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color primary = Color(0xFF3AAFFF);
  static const Color secondary = Color(0xFFA55FEF);
  static const Color tertiary = Color(0xFFFF8811);
  static const Color quaternary = Color(0xFFFDDF50);

  static const Color dprimary = Color(0xFF3a8eff);
  static const Color dsecondary = Color(0xFF8d5fef);
  static const Color dtertiary = Color(0xFFff6011);
  static const Color dquaternary = Color(0xFFfdc250);

  static const Color primaryText = Color(0xFF14181b);
  static const Color secondaryText = Color(0xFF57636c);

  static const Color primaryBackground = Color(0xFFf1f4f8);

  static const Color success = Color(0xFF249689);
  static const Color error = Color(0xFFff5963);
  static const Color warning = Color(0xFFf9cf58);
  static const Color info = Color(0xFFffffff);

  static const String primaryFont = 'AveriaSerifLibre';
  static const String secondaryFont = 'Nunito';

  static const TextTheme textTheme = TextTheme(
    displayLarge: displayLarge,
    displayMedium: displayMedium,
    displaySmall: displaySmall,
    headlineLarge: headlineLarge,
    headlineMedium: headlineMedium,
    headlineSmall: headlineSmall,
    titleLarge: titleLarge,
    titleMedium: titleMedium,
    titleSmall: titleSmall,
    labelLarge: labelLarge,
    labelMedium: labelMedium,
    labelSmall: labelSmall,
    bodyLarge: bodyLarge,
    bodyMedium: bodyMedium,
    bodySmall: bodySmall,
  );

  static const TextStyle displayLarge = TextStyle(
    fontSize: 64,
    fontWeight: FontWeight.normal,
    color: primaryText,
    fontFamily: AppTheme.primaryFont,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 44,
    fontWeight: FontWeight.normal,
    color: primaryText,
    fontFamily: AppTheme.primaryFont,
  );

  static const TextStyle displaySmall = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w600,
    color: primaryText,
    fontFamily: AppTheme.primaryFont,
  );

  static const TextStyle headlineLarge = TextStyle(
    fontSize: 31,
    fontWeight: FontWeight.w600,
    color: primaryText,
    fontFamily: AppTheme.primaryFont,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.normal,
    color: primaryText,
    fontFamily: AppTheme.primaryFont,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: primaryText,
    fontFamily: AppTheme.primaryFont,
  );

  static const TextStyle titleLarge = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    color: primaryText,
    fontFamily: AppTheme.primaryFont,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: info,
    fontFamily: secondaryFont,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: info,
    fontFamily: secondaryFont,
  );

  static const TextStyle labelLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: secondaryText,
    fontFamily: secondaryFont,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: secondaryText,
    fontFamily: secondaryFont,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: secondaryText,
    fontFamily: secondaryFont,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: primaryText,
    fontFamily: secondaryFont,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: primaryText,
    fontFamily: secondaryFont,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: primaryText,
    fontFamily: secondaryFont,
  );
}

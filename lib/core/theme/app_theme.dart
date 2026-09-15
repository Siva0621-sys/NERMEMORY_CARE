import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class AppTheme {
  AppTheme._();

  /// Standard Calming Healthcare Light Theme
  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.light(
      primary: AppConstants.primaryTeal,
      onPrimary: Colors.white,
      primaryContainer: AppConstants.primaryTealLight,
      onPrimaryContainer: AppConstants.primaryTealDark,
      secondary: const Color(0xFFD4A373), // Warm Sand
      onSecondary: Colors.white,
      secondaryContainer: AppConstants.secondaryCream,
      onSecondaryContainer: AppConstants.neutralTextDark,
      tertiary: AppConstants.accentGreen,
      onTertiary: Colors.white,
      tertiaryContainer: AppConstants.accentGreenLight,
      surface: Colors.white,
      onSurface: AppConstants.neutralTextDark,
      surfaceContainerHighest: AppConstants.secondaryCream,
      outline: AppConstants.cardBorderColor,
      error: const Color(0xFFC62828),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppConstants.secondaryCream,
      fontFamily: null, // Clean default system sans-serif
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: AppConstants.neutralTextDark,
        elevation: 0,
        centerTitle: false,
        scrolledUnderElevation: 1,
        titleTextStyle: TextStyle(
          color: AppConstants.neutralTextDark,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.2,
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.cardRadius),
          side: const BorderSide(
            color: AppConstants.cardBorderColor,
            width: 1.2,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConstants.primaryTeal,
          foregroundColor: Colors.white,
          minimumSize: const Size(64, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
          ),
          elevation: 0,
          textStyle: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppConstants.primaryTeal,
          minimumSize: const Size(64, 50),
          side: const BorderSide(color: AppConstants.primaryTeal, width: 1.8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppConstants.primaryTeal,
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
          borderSide: const BorderSide(color: AppConstants.cardBorderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
          borderSide: const BorderSide(color: AppConstants.cardBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
          borderSide: const BorderSide(
            color: AppConstants.primaryTeal,
            width: 2,
          ),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: AppConstants.primaryTealLight,
        elevation: 3,
        height: 70,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppConstants.primaryTealDark,
            );
          }
          return const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppConstants.neutralTextMuted,
          );
        }),
      ),
    );
  }

  /// High Contrast Theme for Elderly & Low Vision Accessibility
  static ThemeData get highContrastTheme {
    final colorScheme = const ColorScheme.dark(
      primary: AppConstants.highContrastYellow,
      onPrimary: Colors.black,
      primaryContainer: Color(0xFF332B00),
      onPrimaryContainer: AppConstants.highContrastYellow,
      secondary: AppConstants.highContrastWhite,
      onSecondary: Colors.black,
      surface: AppConstants.highContrastSurface,
      onSurface: AppConstants.highContrastWhite,
      outline: AppConstants.highContrastYellow,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppConstants.highContrastBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        foregroundColor: AppConstants.highContrastYellow,
        elevation: 1,
        titleTextStyle: TextStyle(
          color: AppConstants.highContrastYellow,
          fontSize: 22,
          fontWeight: FontWeight.w800,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppConstants.highContrastSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.cardRadius),
          side: const BorderSide(
            color: AppConstants.highContrastYellow,
            width: 2,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConstants.highContrastYellow,
          foregroundColor: Colors.black,
          minimumSize: const Size(64, 58),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
          ),
          textStyle: const TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}

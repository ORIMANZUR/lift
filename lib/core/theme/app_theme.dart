import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors
  static const Color scaffoldBackground = Color(0xFF000000); // Pitch black for OLED feel
  static const Color surface = Color(0xFF141414);
  static const Color primary = Color(0xFF2997FF); // Apple-like Blue
  static const Color success = Color(0xFF30D158); // Apple-like Green
  static const Color alert = Color(0xFFFF453A); // Apple-like Red
  static const Color calm = Color(0xFF636366); // Subdued text/icon color

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF2997FF), Color(0xFF007AFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Modern Text Styles (Inter)
  static TextTheme textTheme = TextTheme(
    displayLarge: GoogleFonts.inter(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: Colors.white,
      letterSpacing: -0.5,
    ),
    displayMedium: GoogleFonts.inter(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: Colors.white,
      letterSpacing: -0.5,
    ),
    bodyLarge: GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.white.withValues(alpha: 0.9),
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.white.withValues(alpha: 0.7),
    ),
    labelSmall: GoogleFonts.inter(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: Colors.white.withValues(alpha: 0.5),
      letterSpacing: 0.5,
    ),
  );

  // Light Theme Colors
  static const Color lightScaffold = Color(0xFFF2F4F6); // Cool Grey
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightTextPrimary = Color(0xFF1D1D1F); // Apple Dark Grey
  static const Color lightTextSecondary = Color(0xFF86868B);

  // Text Styles (Light)
  static TextTheme lightTextTheme = TextTheme(
    displayLarge: GoogleFonts.inter(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: lightTextPrimary,
      letterSpacing: -0.5,
    ),
    displayMedium: GoogleFonts.inter(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: lightTextPrimary,
      letterSpacing: -0.5,
    ),
    bodyLarge: GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: lightTextPrimary.withValues(alpha: 0.9),
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: lightTextPrimary.withValues(alpha: 0.7),
    ),
    labelSmall: GoogleFonts.inter(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: lightTextPrimary.withValues(alpha: 0.5),
      letterSpacing: 0.5,
    ),
  );

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: lightScaffold,
      primaryColor: primary,
      textTheme: lightTextTheme,
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: primary,
        surface: lightSurface,
        error: alert,
        secondary: success,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: scaffoldBackground,
      primaryColor: primary,
      textTheme: textTheme,
      useMaterial3: true,
      colorScheme: const ColorScheme.dark(
        primary: primary,
        surface: surface,
        error: alert,
        secondary: success,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AppTheme {
  // 浅色主题颜色（优化后）
  static const Color lightBackground = Color(0xFFE0E5EC);
  static const Color lightShadowLight = Color(0xFFFFFFFF);
  static const Color lightShadowDark = Color(0xFFA3B1C6);
  static const Color lightText = Color(0xFF2C3E50);
  static const Color lightTextSecondary = Color(0xFF7F8C8D);
  
  // 深色主题颜色（优化后）
  static const Color darkBackground = Color(0xFF2C2F36);
  static const Color darkShadowLight = Color(0xFF3D4149);
  static const Color darkShadowDark = Color(0xFF1A1C20);
  static const Color darkText = Color(0xFFECF0F1);
  static const Color darkTextSecondary = Color(0xFFBDC3C7);
  
  // 强调色（更柔和）
  static const Color accentColor = Color(0xFFE74C3C);
  static const Color accentColorDark = Color(0xFFFF6B6B);
  
  // 浅色主题
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: lightBackground,
    primaryColor: lightBackground,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.w300,
        color: lightText,
        letterSpacing: -1,
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w400,
        color: lightTextSecondary,
        letterSpacing: -0.5,
      ),
      bodyLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: lightText,
      ),
    ),
  );
  
  // 深色主题
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkBackground,
    primaryColor: darkBackground,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.w300,
        color: darkText,
        letterSpacing: -1,
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w400,
        color: darkTextSecondary,
        letterSpacing: -0.5,
      ),
      bodyLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: darkText,
      ),
    ),
  );
}

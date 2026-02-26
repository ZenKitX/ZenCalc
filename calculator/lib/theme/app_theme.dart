import 'package:flutter/material.dart';

class AppTheme {
  // 浅色主题颜色
  static const Color lightBackground = Color(0xFFE0E5EC);
  static const Color lightShadowLight = Color(0xFFFFFFFF);
  static const Color lightShadowDark = Color(0xFFA3B1C6);
  static const Color lightText = Color(0xFF333333);
  static const Color lightTextSecondary = Color(0xFF666666);
  
  // 深色主题颜色
  static const Color darkBackground = Color(0xFF2E3239);
  static const Color darkShadowLight = Color(0xFF3A3F47);
  static const Color darkShadowDark = Color(0xFF1C1E22);
  static const Color darkText = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFCCCCCC);
  
  // 强调色
  static const Color accentColor = Color(0xFFFF6B6B);
  
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
      ),
      displayMedium: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w400,
        color: lightTextSecondary,
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
      ),
      displayMedium: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w400,
        color: darkTextSecondary,
      ),
      bodyLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: darkText,
      ),
    ),
  );
}

import 'package:flutter/material.dart';

class AppTheme {
  // 禅意浅色主题 - 沙石庭院
  static const Color lightBackground = Color(0xFFE8E4DC); // 温暖的沙色
  static const Color lightShadowLight = Color(0xFFF5F2ED); // 浅沙色高光
  static const Color lightShadowDark = Color(0xFFC8C4BC); // 深沙色阴影
  static const Color lightText = Color(0xFF3A3A3A); // 墨色文字
  static const Color lightTextSecondary = Color(0xFF8B8680); // 灰褐色次要文字
  
  // 禅意深色主题 - 夜间竹林
  static const Color darkBackground = Color(0xFF2B2D2A); // 深竹绿灰
  static const Color darkShadowLight = Color(0xFF3A3D38); // 浅竹绿灰
  static const Color darkShadowDark = Color(0xFF1C1E1B); // 深夜色
  static const Color darkText = Color(0xFFE8E4DC); // 月光色文字
  static const Color darkTextSecondary = Color(0xFFA8A49C); // 雾色次要文字
  
  // 禅意强调色 - 竹绿
  static const Color accentColor = Color(0xFF7C9885); // 柔和竹绿
  static const Color accentColorDark = Color(0xFF8FA896); // 浅竹绿
  
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

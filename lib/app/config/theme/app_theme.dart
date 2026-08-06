import 'package:flutter/material.dart';
import 'package:zen_theme_kit/zen_theme_kit.dart';

/// ZenCalc 应用主题配置
///
/// 使用 ZenThemeKit 的预设主题
class AppTheme {
  // 沙石庭院主题（浅色）颜色常量 - 向后兼容
  static const Color lightBackground = Color(0xFFE8E4DC);
  static const Color lightShadowLight = Color(0xFFF5F2ED);
  static const Color lightShadowDark = Color(0xFFC8C4BC);
  static const Color lightText = Color(0xFF3A3A3A);
  static const Color lightTextSecondary = Color(0xFF8B8680);

  // 夜间竹林主题（深色）颜色常量 - 向后兼容
  static const Color darkBackground = Color(0xFF2B2D2A);
  static const Color darkShadowLight = Color(0xFF3A3D38);
  static const Color darkShadowDark = Color(0xFF1C1E1B);
  static const Color darkText = Color(0xFFE8E4DC);
  static const Color darkTextSecondary = Color(0xFFA8A49C);

  // 强调色 - 向后兼容
  static const Color accentColor = Color(0xFF7C9885);
  static const Color accentColorDark = Color(0xFF8FA896);

  // 浅色主题 - 使用 ZenThemeKit 的沙石庭院主题
  static ThemeData lightTheme = SandGardenTheme.themeData();

  // 深色主题 - 使用 ZenThemeKit 的夜间竹林主题
  static ThemeData darkTheme = BambooForestTheme.themeData();
}

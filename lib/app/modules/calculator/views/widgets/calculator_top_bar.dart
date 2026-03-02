import 'package:flutter/material.dart';
import 'package:zen_calc/app/config/theme/app_theme.dart';
import 'package:zen_calc/app/services/haptic_service.dart';

class CalculatorTopBar extends StatelessWidget {
  final bool isScientificMode;
  final VoidCallback onScientificToggle;
  final VoidCallback onSettingsTap;
  final VoidCallback onHistoryTap;
  final VoidCallback onThemeToggle;
  final VoidCallback onConverterTap;
  final bool isDark;

  const CalculatorTopBar({
    super.key,
    required this.isScientificMode,
    required this.onScientificToggle,
    required this.onSettingsTap,
    required this.onHistoryTap,
    required this.onThemeToggle,
    required this.onConverterTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // 设置按钮
        _buildIconButton(
          icon: Icons.tune_outlined,
          onTap: onSettingsTap,
        ),
        
        // 科学模式切换按钮
        GestureDetector(
          onTap: () {
            HapticService.selection();
            onScientificToggle();
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isScientificMode
                  ? (isDark ? AppTheme.accentColorDark : AppTheme.accentColor)
                  : (isDark ? AppTheme.darkBackground : AppTheme.lightBackground),
              borderRadius: BorderRadius.circular(20),
              boxShadow: isScientificMode
                  ? [
                      BoxShadow(
                        color: (isDark ? AppTheme.accentColorDark : AppTheme.accentColor)
                            .withOpacity(0.3),
                        offset: const Offset(0, 2),
                        blurRadius: 8,
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: isDark
                            ? AppTheme.darkShadowDark.withOpacity(0.6)
                            : AppTheme.lightShadowDark.withOpacity(0.4),
                        offset: const Offset(3, 3),
                        blurRadius: 6,
                      ),
                      BoxShadow(
                        color: isDark
                            ? AppTheme.darkShadowLight.withOpacity(0.6)
                            : AppTheme.lightShadowLight,
                        offset: const Offset(-3, -3),
                        blurRadius: 6,
                      ),
                    ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.functions,
                  color: isScientificMode
                      ? Colors.white
                      : (isDark ? AppTheme.darkText : AppTheme.lightText),
                  size: 16,
                ),
                const SizedBox(width: 6),
                Text(
                  isScientificMode ? '科学' : '基础',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: isScientificMode
                        ? Colors.white
                        : (isDark ? AppTheme.darkText : AppTheme.lightText),
                  ),
                ),
              ],
            ),
          ),
        ),
        
        Row(
          children: [
            _buildIconButton(icon: Icons.swap_horiz, onTap: onConverterTap),
            const SizedBox(width: 12),
            _buildIconButton(icon: Icons.history, onTap: onHistoryTap),
            const SizedBox(width: 12),
            _buildThemeButton(),
          ],
        ),
      ],
    );
  }

  Widget _buildIconButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: () {
        HapticService.selection();
        onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? AppTheme.darkShadowDark.withOpacity(0.6)
                  : AppTheme.lightShadowDark.withOpacity(0.4),
              offset: const Offset(3, 3),
              blurRadius: 6,
            ),
            BoxShadow(
              color: isDark
                  ? AppTheme.darkShadowLight.withOpacity(0.6)
                  : AppTheme.lightShadowLight,
              offset: const Offset(-3, -3),
              blurRadius: 6,
            ),
          ],
        ),
        child: Icon(
          icon,
          color: isDark ? AppTheme.darkText : AppTheme.lightText,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildThemeButton() {
    return GestureDetector(
      onTap: () {
        HapticService.selection();
        onThemeToggle();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? AppTheme.darkShadowDark.withOpacity(0.6)
                  : AppTheme.lightShadowDark.withOpacity(0.4),
              offset: const Offset(3, 3),
              blurRadius: 6,
            ),
            BoxShadow(
              color: isDark
                  ? AppTheme.darkShadowLight.withOpacity(0.6)
                  : AppTheme.lightShadowLight,
              offset: const Offset(-3, -3),
              blurRadius: 6,
            ),
          ],
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return RotationTransition(
              turns: animation,
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          child: Icon(
            isDark ? Icons.wb_sunny_outlined : Icons.nightlight_outlined,
            key: ValueKey<bool>(isDark),
            color: isDark ? AppTheme.darkText : AppTheme.lightText,
            size: 20,
          ),
        ),
      ),
    );
  }
}

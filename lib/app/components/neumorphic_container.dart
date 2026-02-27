import 'package:flutter/material.dart';
import 'package:zen_calc/app/config/theme/app_theme.dart';

class NeumorphicContainer extends StatelessWidget {
  final Widget? child;
  final double width;
  final double height;
  final double borderRadius;
  final bool isPressed;
  final VoidCallback? onTap;

  const NeumorphicContainer({
    super.key,
    this.child,
    this.width = 80,
    this.height = 80,
    this.borderRadius = 15,
    this.isPressed = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: isPressed
              ? [
                  // 按下状态：内阴影效果
                  BoxShadow(
                    color: isDark
                        ? AppTheme.darkShadowDark
                        : AppTheme.lightShadowDark,
                    offset: const Offset(4, 4),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    color: isDark
                        ? AppTheme.darkShadowLight
                        : AppTheme.lightShadowLight,
                    offset: const Offset(-4, -4),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ]
              : [
                  // 正常状态：外阴影效果（凸起）
                  BoxShadow(
                    color: isDark
                        ? AppTheme.darkShadowDark
                        : AppTheme.lightShadowDark,
                    offset: const Offset(8, 8),
                    blurRadius: 15,
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    color: isDark
                        ? AppTheme.darkShadowLight
                        : AppTheme.lightShadowLight,
                    offset: const Offset(-8, -8),
                    blurRadius: 15,
                    spreadRadius: 1,
                  ),
                ],
        ),
        child: Center(child: child),
      ),
    );
  }
}

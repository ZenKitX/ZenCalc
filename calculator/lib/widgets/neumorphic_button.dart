import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class NeumorphicButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final Color? textColor;
  final double? fontSize;
  final bool isOperator;

  const NeumorphicButton({
    super.key,
    required this.text,
    required this.onTap,
    this.textColor,
    this.fontSize,
    this.isOperator = false,
  });

  @override
  State<NeumorphicButton> createState() => _NeumorphicButtonState();
}

class _NeumorphicButtonState extends State<NeumorphicButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultTextColor = isDark ? AppTheme.darkText : AppTheme.lightText;
    final textColor = widget.isOperator 
        ? AppTheme.accentColor 
        : (widget.textColor ?? defaultTextColor);

    return GestureDetector(
      onTapDown: (_) {
        setState(() => isPressed = true);
      },
      onTapUp: (_) {
        setState(() => isPressed = false);
        widget.onTap();
      },
      onTapCancel: () {
        setState(() => isPressed = false);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
          borderRadius: BorderRadius.circular(15),
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
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
              fontSize: widget.fontSize ?? 28,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}

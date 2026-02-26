import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class NeumorphicButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final Color? textColor;
  final double? fontSize;
  final bool isOperator;
  final bool isEquals;

  const NeumorphicButton({
    super.key,
    required this.text,
    required this.onTap,
    this.textColor,
    this.fontSize,
    this.isOperator = false,
    this.isEquals = false,
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
    final accentColor = isDark ? AppTheme.accentColorDark : AppTheme.accentColor;
    
    // 等号按钮特殊处理
    final backgroundColor = widget.isEquals
        ? (isDark ? AppTheme.accentColorDark : AppTheme.accentColor)
        : (isDark ? AppTheme.darkBackground : AppTheme.lightBackground);
    
    final textColor = widget.isEquals
        ? Colors.white
        : (widget.isOperator 
            ? (isDark ? AppTheme.darkText : AppTheme.lightText)
            : (widget.textColor ?? defaultTextColor));

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
          color: backgroundColor,
          shape: BoxShape.circle,
          boxShadow: widget.isEquals
              ? [] // 等号按钮不需要阴影
              : (isPressed
                  ? [
                      // 按下状态：内阴影效果（更柔和）
                      BoxShadow(
                        color: isDark
                            ? AppTheme.darkShadowDark.withOpacity(0.5)
                            : AppTheme.lightShadowDark.withOpacity(0.3),
                        offset: const Offset(3, 3),
                        blurRadius: 6,
                        spreadRadius: 0,
                      ),
                      BoxShadow(
                        color: isDark
                            ? AppTheme.darkShadowLight.withOpacity(0.5)
                            : AppTheme.lightShadowLight.withOpacity(0.9),
                        offset: const Offset(-3, -3),
                        blurRadius: 6,
                        spreadRadius: 0,
                      ),
                    ]
                  : [
                      // 正常状态：外阴影效果（更立体）
                      BoxShadow(
                        color: isDark
                            ? AppTheme.darkShadowDark.withOpacity(0.6)
                            : AppTheme.lightShadowDark.withOpacity(0.4),
                        offset: const Offset(6, 6),
                        blurRadius: 12,
                        spreadRadius: 0,
                      ),
                      BoxShadow(
                        color: isDark
                            ? AppTheme.darkShadowLight.withOpacity(0.6)
                            : AppTheme.lightShadowLight.withOpacity(1.0),
                        offset: const Offset(-6, -6),
                        blurRadius: 12,
                        spreadRadius: 0,
                      ),
                    ]),
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

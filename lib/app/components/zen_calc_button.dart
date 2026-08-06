import 'package:flutter/material.dart';
import 'package:zen_ui_kit/zen_ui_kit.dart';
import 'package:zen_theme_kit/zen_theme_kit.dart';
import 'package:feedback_kit/feedback_kit.dart';

/// ZenCalc 计算器按钮
///
/// 基于 ZenButton，添加了触觉反馈和音频反馈
class ZenCalcButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? textColor;
  final double? fontSize;
  final bool isOperator;
  final bool isEquals;

  const ZenCalcButton({
    super.key,
    required this.text,
    required this.onTap,
    this.textColor,
    this.fontSize,
    this.isOperator = false,
    this.isEquals = false,
  });

  void _handleTap() {
    // 触觉反馈
    if (text == 'AC') {
      HapticService.heavy();
      AudioService.playClearSound();
    } else if (isEquals) {
      HapticService.heavy();
      AudioService.playEqualsSound();
    } else if (isOperator) {
      HapticService.medium();
      AudioService.playOperatorSound();
    } else {
      HapticService.light();
      AudioService.playNumberSound();
    }

    onTap();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ZenTheme.of(context);
    final isAccent = isEquals;

    return ZenButton(
      shape: ZenButtonShape.circle,
      style: isAccent ? ZenButtonStyle.accent : ZenButtonStyle.normal,
      backgroundColor: isAccent ? theme.colors.accent : theme.colors.surface,
      textColor:
          textColor ?? (isAccent ? Colors.white : theme.colors.textPrimary),
      shadowLight: isAccent ? null : theme.colors.shadowLight,
      shadowDark: isAccent ? null : theme.colors.shadowDark,
      onTap: _handleTap,
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize ?? 28, fontWeight: FontWeight.w500),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:zen_theme_kit/zen_theme_kit.dart';
import 'package:zen_ui_kit/zen_ui_kit.dart';

/// ZenCalc 计算器显示屏
/// 
/// 基于 ZenDisplay，添加了表达式预览和动画效果
class ZenCalcDisplay extends StatefulWidget {
  final String displayText;
  final String result;
  final bool showResult;

  const ZenCalcDisplay({
    super.key,
    required this.displayText,
    required this.result,
    this.showResult = false,
  });

  @override
  State<ZenCalcDisplay> createState() => _ZenCalcDisplayState();
}

class _ZenCalcDisplayState extends State<ZenCalcDisplay> {
  @override
  Widget build(BuildContext context) {
    final theme = ZenTheme.of(context);
    final shadows = ZenShadows(
      shadowDark: theme.colors.shadowDark,
      shadowLight: theme.colors.shadowLight,
    );
    final hasPreview = widget.result != '0' && !widget.showResult;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: shadows.neumorphicInset,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // 上方文本（输入中显示空，按等号后显示表达式）
          if (widget.showResult)
            Flexible(
              child: SingleChildScrollView(
                reverse: true,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: 1.0,
                  child: Text(
                    widget.displayText,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: theme.colors.textSecondary,
                    ),
                    textAlign: TextAlign.right,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          
          if (widget.showResult) const SizedBox(height: 8),
          
          // 主显示区域
          Flexible(
            child: SingleChildScrollView(
              reverse: true,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.0, 0.1),
                        end: Offset.zero,
                      ).animate(CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeOutCubic,
                      )),
                      child: child,
                    ),
                  );
                },
                child: Row(
                  key: ValueKey<String>('${widget.displayText}_${widget.showResult}'),
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Text(
                        widget.showResult ? widget.result : widget.displayText,
                        style: TextStyle(
                          fontSize: widget.showResult ? 56 : 48,
                          fontWeight: FontWeight.w300,
                          color: theme.colors.textPrimary,
                          height: 1.2,
                        ),
                        textAlign: TextAlign.right,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // 光标（仅在输入时显示）
                    if (!widget.showResult)
                      _BlinkingCursor(theme: theme),
                  ],
                ),
              ),
            ),
          ),
          
          // 预览结果（仅在输入中且有预览时显示）
          if (hasPreview) ...[
            const SizedBox(height: 12),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: 1.0,
              child: Text(
                widget.result,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                  color: theme.colors.textSecondary,
                ),
                textAlign: TextAlign.right,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// 闪烁光标组件
class _BlinkingCursor extends StatefulWidget {
  final ZenThemeData theme;

  const _BlinkingCursor({required this.theme});

  @override
  State<_BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<_BlinkingCursor>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: Container(
        width: 3,
        height: 48,
        margin: const EdgeInsets.only(left: 4, bottom: 4),
        decoration: BoxDecoration(
          color: widget.theme.colors.accent,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

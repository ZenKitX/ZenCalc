import 'package:flutter/material.dart';
import 'package:zen_calc/app/config/theme/app_theme.dart';

class NeumorphicDisplay extends StatefulWidget {
  final String displayText;
  final String result;
  final bool showResult; // 是否显示结果（按等号后）

  const NeumorphicDisplay({
    super.key,
    required this.displayText,
    required this.result,
    this.showResult = false,
  });

  @override
  State<NeumorphicDisplay> createState() => _NeumorphicDisplayState();
}

class _NeumorphicDisplayState extends State<NeumorphicDisplay> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hasPreview = widget.result != '0' && !widget.showResult;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? AppTheme.darkShadowDark.withOpacity(0.5)
                : AppTheme.lightShadowDark.withOpacity(0.3),
            offset: const Offset(3, 3),
            blurRadius: 8,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: isDark
                ? AppTheme.darkShadowLight.withOpacity(0.5)
                : AppTheme.lightShadowLight.withOpacity(0.9),
            offset: const Offset(-3, -3),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
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
                      fontSize: 24,
                      color: isDark 
                          ? AppTheme.darkTextSecondary 
                          : AppTheme.lightTextSecondary,
                      fontWeight: FontWeight.w300,
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
                          color: isDark ? AppTheme.darkText : AppTheme.lightText,
                          height: 1.2,
                        ),
                        textAlign: TextAlign.right,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // 光标（仅在输入时显示）
                    if (!widget.showResult)
                      _BlinkingCursor(isDark: isDark),
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
                  color: isDark 
                      ? AppTheme.darkTextSecondary 
                      : AppTheme.lightTextSecondary,
                  fontWeight: FontWeight.w300,
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

// 闪烁光标组件
class _BlinkingCursor extends StatefulWidget {
  final bool isDark;

  const _BlinkingCursor({required this.isDark});

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
          color: widget.isDark 
              ? AppTheme.accentColorDark 
              : AppTheme.accentColor,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

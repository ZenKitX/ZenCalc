import 'package:flutter/material.dart';
import 'package:zen_calc/app/config/theme/app_theme.dart';

class NeumorphicDisplay extends StatefulWidget {
  final String displayText;
  final String result;

  const NeumorphicDisplay({
    super.key,
    required this.displayText,
    required this.result,
  });

  @override
  State<NeumorphicDisplay> createState() => _NeumorphicDisplayState();
}

class _NeumorphicDisplayState extends State<NeumorphicDisplay> {
  String _previousResult = '';

  @override
  void didUpdateWidget(NeumorphicDisplay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.result != widget.result) {
      _previousResult = oldWidget.result;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          // 内阴影效果（凹陷）- 更柔和
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
          // 输入显示 - 带淡入动画
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
                child: Text(
                  widget.displayText,
                  key: ValueKey<String>(widget.displayText),
                  style: Theme.of(context).textTheme.displayMedium,
                  textAlign: TextAlign.right,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // 结果显示 - 带淡入淡出动画
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.95, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    ),
                  ),
                  child: child,
                ),
              );
            },
            child: Text(
              widget.result,
              key: ValueKey<String>(widget.result),
              style: Theme.of(context).textTheme.displayLarge,
              textAlign: TextAlign.right,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

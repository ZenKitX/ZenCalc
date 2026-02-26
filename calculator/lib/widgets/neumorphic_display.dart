import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class NeumorphicDisplay extends StatelessWidget {
  final String displayText;
  final String result;

  const NeumorphicDisplay({
    super.key,
    required this.displayText,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          // 内阴影效果（凹陷）
          BoxShadow(
            color: isDark
                ? AppTheme.darkShadowDark
                : AppTheme.lightShadowDark,
            offset: const Offset(4, 4),
            blurRadius: 10,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: isDark
                ? AppTheme.darkShadowLight
                : AppTheme.lightShadowLight,
            offset: const Offset(-4, -4),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // 输入显示
          Text(
            displayText,
            style: Theme.of(context).textTheme.displayMedium,
            textAlign: TextAlign.right,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          // 结果显示
          Text(
            result,
            style: Theme.of(context).textTheme.displayLarge,
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}

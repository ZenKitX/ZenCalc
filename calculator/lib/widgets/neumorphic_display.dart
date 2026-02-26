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
          // 输入显示
          Flexible(
            child: SingleChildScrollView(
              reverse: true,
              child: Text(
                displayText,
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.right,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // 结果显示
          Text(
            result,
            style: Theme.of(context).textTheme.displayLarge,
            textAlign: TextAlign.right,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

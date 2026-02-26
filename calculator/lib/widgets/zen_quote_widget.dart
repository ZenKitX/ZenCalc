import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../services/zen_quote_service.dart';

class ZenQuoteWidget extends StatefulWidget {
  final ZenQuote quote;
  final VoidCallback onDismiss;
  
  const ZenQuoteWidget({
    super.key,
    required this.quote,
    required this.onDismiss,
  });

  @override
  State<ZenQuoteWidget> createState() => _ZenQuoteWidgetState();
}

class _ZenQuoteWidgetState extends State<ZenQuoteWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));
    
    _controller.forward();
    
    // 3秒后自动消失
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _dismiss();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _dismiss() async {
    await _controller.reverse();
    widget.onDismiss();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return GestureDetector(
      onTap: _dismiss,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: BoxDecoration(
              color: isDark 
                  ? AppTheme.darkBackground.withOpacity(0.95)
                  : AppTheme.lightBackground.withOpacity(0.95),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? AppTheme.darkShadowDark.withOpacity(0.6)
                      : AppTheme.lightShadowDark.withOpacity(0.4),
                  offset: const Offset(4, 4),
                  blurRadius: 12,
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: isDark
                      ? AppTheme.darkShadowLight.withOpacity(0.6)
                      : AppTheme.lightShadowLight.withOpacity(0.9),
                  offset: const Offset(-4, -4),
                  blurRadius: 12,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Row(
              children: [
                // 禅意图标
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isDark ? AppTheme.accentColorDark.withOpacity(0.2) : AppTheme.accentColor.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.spa_outlined,
                    color: isDark ? AppTheme.accentColorDark : AppTheme.accentColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                
                // 禅语文本
                Expanded(
                  child: Text(
                    widget.quote.text,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: isDark ? AppTheme.darkText : AppTheme.lightText,
                      height: 1.5,
                      letterSpacing: 0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                
                const SizedBox(width: 16),
                
                // 关闭按钮
                GestureDetector(
                  onTap: _dismiss,
                  child: Icon(
                    Icons.close,
                    color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

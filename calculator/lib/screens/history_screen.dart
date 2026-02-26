import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/calculation_history.dart';
import '../services/history_service.dart';
import '../services/haptic_service.dart';

class HistoryScreen extends StatefulWidget {
  final Function(String) onSelectHistory;
  
  const HistoryScreen({
    super.key,
    required this.onSelectHistory,
  });

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final history = HistoryService.history;
    final stats = HistoryService.getStatistics();
    
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      body: SafeArea(
        child: Column(
          children: [
            // 顶部栏
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // 返回按钮
                  GestureDetector(
                    onTap: () {
                      HapticService.selection();
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: isDark
                                ? AppTheme.darkShadowDark.withOpacity(0.6)
                                : AppTheme.lightShadowDark.withOpacity(0.4),
                            offset: const Offset(3, 3),
                            blurRadius: 6,
                          ),
                          BoxShadow(
                            color: isDark
                                ? AppTheme.darkShadowLight.withOpacity(0.6)
                                : AppTheme.lightShadowLight,
                            offset: const Offset(-3, -3),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: isDark ? AppTheme.darkText : AppTheme.lightText,
                        size: 20,
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: 16),
                  
                  // 标题
                  Expanded(
                    child: Text(
                      '计算历史',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: isDark ? AppTheme.darkText : AppTheme.lightText,
                      ),
                    ),
                  ),
                  
                  // 清除按钮
                  if (history.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        HapticService.medium();
                        _showClearConfirmDialog(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: isDark
                                  ? AppTheme.darkShadowDark.withOpacity(0.6)
                                  : AppTheme.lightShadowDark.withOpacity(0.4),
                              offset: const Offset(3, 3),
                              blurRadius: 6,
                            ),
                            BoxShadow(
                              color: isDark
                                  ? AppTheme.darkShadowLight.withOpacity(0.6)
                                  : AppTheme.lightShadowLight,
                              offset: const Offset(-3, -3),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.delete_outline,
                          color: isDark ? AppTheme.darkText : AppTheme.lightText,
                          size: 20,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            
            // 统计信息
            if (history.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: isDark
                            ? AppTheme.darkShadowDark.withOpacity(0.5)
                            : AppTheme.lightShadowDark.withOpacity(0.3),
                        offset: const Offset(3, 3),
                        blurRadius: 8,
                      ),
                      BoxShadow(
                        color: isDark
                            ? AppTheme.darkShadowLight.withOpacity(0.5)
                            : AppTheme.lightShadowLight,
                        offset: const Offset(-3, -3),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem('总计', stats['total'].toString(), isDark),
                      _buildStatItem('今日', stats['today'].toString(), isDark),
                      _buildStatItem('本周', stats['thisWeek'].toString(), isDark),
                    ],
                  ),
                ),
              ),
            
            const SizedBox(height: 16),
            
            // 历史记录列表
            Expanded(
              child: history.isEmpty
                  ? _buildEmptyState(isDark)
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: history.length,
                      itemBuilder: (context, index) {
                        return _buildHistoryItem(
                          context,
                          history[index],
                          index,
                          isDark,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildStatItem(String label, String value, bool isDark) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: isDark ? AppTheme.accentColorDark : AppTheme.accentColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
          ),
        ),
      ],
    );
  }
  
  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 64,
            color: isDark 
                ? AppTheme.darkTextSecondary.withOpacity(0.5)
                : AppTheme.lightTextSecondary.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            '暂无历史记录',
            style: TextStyle(
              fontSize: 16,
              color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '开始计算，记录将自动保存',
            style: TextStyle(
              fontSize: 14,
              color: isDark 
                  ? AppTheme.darkTextSecondary.withOpacity(0.7)
                  : AppTheme.lightTextSecondary.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildHistoryItem(
    BuildContext context,
    CalculationHistory item,
    int index,
    bool isDark,
  ) {
    return Dismissible(
      key: Key('${item.timestamp.millisecondsSinceEpoch}'),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        HapticService.light();
        setState(() {
          HistoryService.deleteHistory(index);
        });
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.8),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: GestureDetector(
        onTap: () {
          HapticService.light();
          widget.onSelectHistory(item.result);
          Navigator.pop(context);
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? AppTheme.darkShadowDark.withOpacity(0.5)
                    : AppTheme.lightShadowDark.withOpacity(0.3),
                offset: const Offset(3, 3),
                blurRadius: 6,
              ),
              BoxShadow(
                color: isDark
                    ? AppTheme.darkShadowLight.withOpacity(0.5)
                    : AppTheme.lightShadowLight,
                offset: const Offset(-3, -3),
                blurRadius: 6,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 表达式
              Text(
                item.displayExpression,
                style: TextStyle(
                  fontSize: 16,
                  color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                ),
              ),
              const SizedBox(height: 8),
              
              // 结果和时间
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '= ${item.displayResult}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: isDark ? AppTheme.darkText : AppTheme.lightText,
                    ),
                  ),
                  Text(
                    item.formattedTime,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark 
                          ? AppTheme.darkTextSecondary.withOpacity(0.7)
                          : AppTheme.lightTextSecondary.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  void _showClearConfirmDialog(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? AppTheme.darkShadowDark.withOpacity(0.6)
                      : AppTheme.lightShadowDark.withOpacity(0.4),
                  offset: const Offset(6, 6),
                  blurRadius: 12,
                ),
                BoxShadow(
                  color: isDark
                      ? AppTheme.darkShadowLight.withOpacity(0.6)
                      : AppTheme.lightShadowLight,
                  offset: const Offset(-6, -6),
                  blurRadius: 12,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  size: 48,
                  color: isDark ? AppTheme.accentColorDark : AppTheme.accentColor,
                ),
                const SizedBox(height: 16),
                Text(
                  '清除所有历史记录？',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: isDark ? AppTheme.darkText : AppTheme.lightText,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '此操作无法撤销',
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          HapticService.selection();
                          Navigator.pop(context);
                        },
                        child: Text(
                          '取消',
                          style: TextStyle(
                            fontSize: 16,
                            color: isDark ? AppTheme.darkText : AppTheme.lightText,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          HapticService.heavy();
                          await HistoryService.clearHistory();
                          if (context.mounted) {
                            Navigator.pop(context);
                            setState(() {});
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDark ? AppTheme.accentColorDark : AppTheme.accentColor,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          '清除',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

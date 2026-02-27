import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zen_calc/app/data/models/calculation_history.dart';

class HistoryService {
  static const String _historyKey = 'calculation_history';
  static const int _maxHistoryItems = 100; // 最多保存100条记录
  
  static List<CalculationHistory> _history = [];
  
  // 获取历史记录
  static List<CalculationHistory> get history => List.unmodifiable(_history);
  
  // 添加历史记录
  static Future<void> addHistory(String expression, String result) async {
    // 跳过错误结果
    if (result == 'Error') return;
    
    // 跳过简单的单数字（没有运算符）
    if (!_hasOperator(expression)) return;
    
    final newHistory = CalculationHistory(
      expression: expression,
      result: result,
      timestamp: DateTime.now(),
    );
    
    // 添加到列表开头
    _history.insert(0, newHistory);
    
    // 限制历史记录数量
    if (_history.length > _maxHistoryItems) {
      _history = _history.sublist(0, _maxHistoryItems);
    }
    
    // 保存到本地
    await _saveToLocal();
  }
  
  // 清除所有历史记录
  static Future<void> clearHistory() async {
    _history.clear();
    await _saveToLocal();
  }
  
  // 删除单条历史记录
  static Future<void> deleteHistory(int index) async {
    if (index >= 0 && index < _history.length) {
      _history.removeAt(index);
      await _saveToLocal();
    }
  }
  
  // 从本地加载历史记录
  static Future<void> loadFromLocal() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? historyJson = prefs.getString(_historyKey);
      
      if (historyJson != null) {
        final List<dynamic> decoded = json.decode(historyJson);
        _history = decoded
            .map((item) => CalculationHistory.fromJson(item))
            .toList();
      }
    } catch (e) {
      // 如果加载失败，使用空列表
      _history = [];
    }
  }
  
  // 保存到本地
  static Future<void> _saveToLocal() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<Map<String, dynamic>> historyJson = 
          _history.map((item) => item.toJson()).toList();
      await prefs.setString(_historyKey, json.encode(historyJson));
    } catch (e) {
      // 静默失败
    }
  }
  
  // 检查表达式是否包含运算符
  static bool _hasOperator(String expression) {
    return expression.contains('+') ||
           expression.contains('-') ||
           expression.contains('×') ||
           expression.contains('÷') ||
           expression.contains('%');
  }
  
  // 获取统计信息
  static Map<String, dynamic> getStatistics() {
    if (_history.isEmpty) {
      return {
        'total': 0,
        'today': 0,
        'thisWeek': 0,
      };
    }
    
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final weekAgo = now.subtract(const Duration(days: 7));
    
    int todayCount = 0;
    int weekCount = 0;
    
    for (var item in _history) {
      if (item.timestamp.isAfter(today)) {
        todayCount++;
      }
      if (item.timestamp.isAfter(weekAgo)) {
        weekCount++;
      }
    }
    
    return {
      'total': _history.length,
      'today': todayCount,
      'thisWeek': weekCount,
    };
  }
}

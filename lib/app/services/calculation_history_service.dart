import 'package:history_kit/history_kit.dart';
import 'package:zen_calc/app/data/models/calculation_history.dart';

/// Adapter service for calculator-specific history management using HistoryKit
class CalculationHistoryService {
  static final _historyService = HistoryService(
    storageKey: 'calculation_history',
    maxItems: 100,
  );
  
  /// Get all calculation history
  static List<CalculationHistory> get history {
    return _historyService.items
        .map((item) => CalculationHistory(
              expression: item.title,
              result: item.subtitle ?? '',
              timestamp: item.timestamp,
            ))
        .toList();
  }
  
  /// Add a calculation to history
  static Future<void> addHistory(String expression, String result) async {
    // Skip error results
    if (result == 'Error') return;
    
    // Skip simple single numbers (no operators)
    if (!_hasOperator(expression)) return;
    
    final item = HistoryItem(
      title: expression,
      subtitle: result,
      metadata: {
        'type': 'calculation',
      },
    );
    
    await _historyService.add(item);
  }
  
  /// Clear all history
  static Future<void> clearHistory() async {
    await _historyService.clear();
  }
  
  /// Delete history at index
  static Future<void> deleteHistory(int index) async {
    await _historyService.removeAt(index);
  }
  
  /// Load history from local storage
  static Future<void> loadFromLocal() async {
    await _historyService.load();
  }
  
  /// Get statistics
  static Map<String, dynamic> getStatistics() {
    final stats = _historyService.getStatistics();
    return {
      'total': stats['total'],
      'today': stats['today'],
      'thisWeek': stats['thisWeek'],
    };
  }
  
  /// Check if expression contains operators
  static bool _hasOperator(String expression) {
    return expression.contains('+') ||
           expression.contains('-') ||
           expression.contains('×') ||
           expression.contains('÷') ||
           expression.contains('%');
  }
}

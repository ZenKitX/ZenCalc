class CalculationHistory {
  final String expression;
  final String result;
  final DateTime timestamp;
  
  CalculationHistory({
    required this.expression,
    required this.result,
    required this.timestamp,
  });
  
  // 格式化显示
  String get displayExpression => expression;
  String get displayResult => result;
  
  // 格式化时间
  String get formattedTime {
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    
    if (difference.inMinutes < 1) {
      return '刚刚';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}分钟前';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}小时前';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}天前';
    } else {
      return '${timestamp.month}月${timestamp.day}日';
    }
  }
  
  // 转换为 JSON
  Map<String, dynamic> toJson() {
    return {
      'expression': expression,
      'result': result,
      'timestamp': timestamp.toIso8601String(),
    };
  }
  
  // 从 JSON 创建
  factory CalculationHistory.fromJson(Map<String, dynamic> json) {
    return CalculationHistory(
      expression: json['expression'],
      result: json['result'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}

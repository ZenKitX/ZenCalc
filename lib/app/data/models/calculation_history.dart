/// 历史记录条目（HistoryKit HistoryItem 的视图映射）
///
/// 数据源单一：持久化与统计由 HistoryKit 的 HistoryService 负责，
/// 本模型仅承载计算器场景所需的展示字段。
class CalculationHistory {
  final String expression;
  final String result;
  final DateTime timestamp;

  CalculationHistory({
    required this.expression,
    required this.result,
    required this.timestamp,
  });
}

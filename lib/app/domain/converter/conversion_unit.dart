/// 单位模型
class ConversionUnit {
  final String id;
  final String name;
  final String symbol;
  final double toBaseRatio; // 转换到基准单位的比率

  const ConversionUnit({
    required this.id,
    required this.name,
    required this.symbol,
    required this.toBaseRatio,
  });
}

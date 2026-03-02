import '../models/conversion_unit.dart';

/// 换算逻辑工具类
class ConversionLogic {
  /// 基本单位换算
  static double convert({
    required double value,
    required ConversionUnit fromUnit,
    required ConversionUnit toUnit,
  }) {
    // 先转换到基准单位，再转换到目标单位
    final baseValue = value * fromUnit.toBaseRatio;
    return baseValue / toUnit.toBaseRatio;
  }

  /// 温度换算（特殊处理）
  static double convertTemperature({
    required double value,
    required String fromUnitId,
    required String toUnitId,
  }) {
    if (fromUnitId == toUnitId) return value;

    // 先转换到摄氏度
    double celsius;
    switch (fromUnitId) {
      case 'celsius':
        celsius = value;
        break;
      case 'fahrenheit':
        celsius = (value - 32) * 5 / 9;
        break;
      case 'kelvin':
        celsius = value - 273.15;
        break;
      default:
        celsius = value;
    }

    // 再从摄氏度转换到目标单位
    switch (toUnitId) {
      case 'celsius':
        return celsius;
      case 'fahrenheit':
        return celsius * 9 / 5 + 32;
      case 'kelvin':
        return celsius + 273.15;
      default:
        return celsius;
    }
  }

  /// 进制转换（特殊处理）
  static String convertNumberSystem({
    required String value,
    required String fromUnitId,
    required String toUnitId,
  }) {
    if (fromUnitId == toUnitId) return value;

    try {
      // 获取进制基数
      int fromBase = _getBase(fromUnitId);
      int toBase = _getBase(toUnitId);

      // 先转换为十进制
      int decimalValue = int.parse(value, radix: fromBase);

      // 再转换为目标进制
      return decimalValue.toRadixString(toBase).toUpperCase();
    } catch (e) {
      return '';
    }
  }

  /// 获取进制基数
  static int _getBase(String unitId) {
    switch (unitId) {
      case 'binary':
        return 2;
      case 'octal':
        return 8;
      case 'decimal':
        return 10;
      case 'hexadecimal':
        return 16;
      default:
        return 10;
    }
  }

  /// 验证进制输入
  static bool isValidNumberSystemInput(String value, String unitId) {
    if (value.isEmpty) return true;

    try {
      int base = _getBase(unitId);
      int.parse(value, radix: base);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// 格式化显示结果
  static String formatResult(double value) {
    if (value.abs() < 0.0001 && value != 0) {
      return value.toStringAsExponential(6);
    }
    
    // 移除尾部的零
    String result = value.toStringAsFixed(8);
    result = result.replaceAll(RegExp(r'\.?0+$'), '');
    
    return result;
  }
}

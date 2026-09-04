import 'package:flutter_test/flutter_test.dart';
import 'package:zen_calc/app/domain/converter/conversion_logic.dart';
import 'package:zen_calc/app/domain/converter/conversion_unit.dart';

void main() {
  group('ConversionLogic Tests', () {
    test('基本单位换算 - 米到千米', () {
      const fromUnit = ConversionUnit(
        id: 'meter',
        name: '米',
        symbol: 'm',
        toBaseRatio: 1.0,
      );
      const toUnit = ConversionUnit(
        id: 'kilometer',
        name: '千米',
        symbol: 'km',
        toBaseRatio: 1000.0,
      );

      final result = ConversionLogic.convert(
        value: 1000,
        fromUnit: fromUnit,
        toUnit: toUnit,
      );

      expect(result, equals(1.0));
    });

    test('基本单位换算 - 千克到克', () {
      const fromUnit = ConversionUnit(
        id: 'kilogram',
        name: '千克',
        symbol: 'kg',
        toBaseRatio: 1.0,
      );
      const toUnit = ConversionUnit(
        id: 'gram',
        name: '克',
        symbol: 'g',
        toBaseRatio: 0.001,
      );

      final result = ConversionLogic.convert(
        value: 1,
        fromUnit: fromUnit,
        toUnit: toUnit,
      );

      expect(result, equals(1000.0));
    });

    test('温度换算 - 摄氏度到华氏度', () {
      final result = ConversionLogic.convertTemperature(
        value: 0,
        fromUnitId: 'celsius',
        toUnitId: 'fahrenheit',
      );

      expect(result, equals(32.0));
    });

    test('温度换算 - 华氏度到摄氏度', () {
      final result = ConversionLogic.convertTemperature(
        value: 32,
        fromUnitId: 'fahrenheit',
        toUnitId: 'celsius',
      );

      expect(result, equals(0.0));
    });

    test('温度换算 - 摄氏度到开尔文', () {
      final result = ConversionLogic.convertTemperature(
        value: 0,
        fromUnitId: 'celsius',
        toUnitId: 'kelvin',
      );

      expect(result, equals(273.15));
    });

    test('进制转换 - 十进制到二进制', () {
      final result = ConversionLogic.convertNumberSystem(
        value: '10',
        fromUnitId: 'decimal',
        toUnitId: 'binary',
      );

      expect(result, equals('1010'));
    });

    test('进制转换 - 二进制到十进制', () {
      final result = ConversionLogic.convertNumberSystem(
        value: '1010',
        fromUnitId: 'binary',
        toUnitId: 'decimal',
      );

      expect(result, equals('10'));
    });

    test('进制转换 - 十进制到十六进制', () {
      final result = ConversionLogic.convertNumberSystem(
        value: '255',
        fromUnitId: 'decimal',
        toUnitId: 'hexadecimal',
      );

      expect(result, equals('FF'));
    });

    test('进制转换 - 十六进制到十进制', () {
      final result = ConversionLogic.convertNumberSystem(
        value: 'FF',
        fromUnitId: 'hexadecimal',
        toUnitId: 'decimal',
      );

      expect(result, equals('255'));
    });

    test('进制输入验证 - 二进制合法输入', () {
      final result = ConversionLogic.isValidNumberSystemInput('1010', 'binary');
      expect(result, isTrue);
    });

    test('进制输入验证 - 二进制非法输入', () {
      final result = ConversionLogic.isValidNumberSystemInput('1012', 'binary');
      expect(result, isFalse);
    });

    test('进制输入验证 - 十六进制合法输入', () {
      final result = ConversionLogic.isValidNumberSystemInput(
        '1A2F',
        'hexadecimal',
      );
      expect(result, isTrue);
    });

    test('进制输入验证 - 十六进制非法输入', () {
      final result = ConversionLogic.isValidNumberSystemInput(
        '1G2F',
        'hexadecimal',
      );
      expect(result, isFalse);
    });

    test('格式化结果 - 移除尾部零', () {
      final result = ConversionLogic.formatResult(1.50000000);
      expect(result, equals('1.5'));
    });

    test('格式化结果 - 整数', () {
      final result = ConversionLogic.formatResult(100.0);
      expect(result, equals('100'));
    });

    test('格式化结果 - 科学计数法', () {
      final result = ConversionLogic.formatResult(0.00001);
      expect(result, contains('e'));
    });

    test('基本单位换算 - 千米到米（反向）', () {
      const fromUnit = ConversionUnit(
        id: 'kilometer',
        name: '千米',
        symbol: 'km',
        toBaseRatio: 1000.0,
      );
      const toUnit = ConversionUnit(
        id: 'meter',
        name: '米',
        symbol: 'm',
        toBaseRatio: 1.0,
      );

      final result = ConversionLogic.convert(
        value: 2.5,
        fromUnit: fromUnit,
        toUnit: toUnit,
      );

      expect(result, closeTo(2500.0, 1e-9));
    });

    test('基本单位换算 - 同单位直接返回', () {
      const unit = ConversionUnit(
        id: 'meter',
        name: '米',
        symbol: 'm',
        toBaseRatio: 1.0,
      );

      final result = ConversionLogic.convert(
        value: 42,
        fromUnit: unit,
        toUnit: unit,
      );

      expect(result, 42.0);
    });

    test('温度换算 - 开尔文到摄氏度', () {
      final result = ConversionLogic.convertTemperature(
        value: 273.15,
        fromUnitId: 'kelvin',
        toUnitId: 'celsius',
      );

      expect(result, closeTo(0.0, 1e-9));
    });

    test('温度换算 - 华氏度到开尔文', () {
      final result = ConversionLogic.convertTemperature(
        value: 32,
        fromUnitId: 'fahrenheit',
        toUnitId: 'kelvin',
      );

      expect(result, closeTo(273.15, 1e-9));
    });

    test('温度换算 - 同单位直接返回', () {
      final result = ConversionLogic.convertTemperature(
        value: 100,
        fromUnitId: 'celsius',
        toUnitId: 'celsius',
      );

      expect(result, 100.0);
    });

    test('温度换算 - 未知单位按摄氏度处理', () {
      final result = ConversionLogic.convertTemperature(
        value: 25,
        fromUnitId: 'unknown',
        toUnitId: 'celsius',
      );

      expect(result, 25.0);
    });

    test('进制转换 - 十进制到八进制', () {
      final result = ConversionLogic.convertNumberSystem(
        value: '8',
        fromUnitId: 'decimal',
        toUnitId: 'octal',
      );

      expect(result, equals('10'));
    });

    test('进制转换 - 二进制到十六进制', () {
      final result = ConversionLogic.convertNumberSystem(
        value: '11111111',
        fromUnitId: 'binary',
        toUnitId: 'hexadecimal',
      );

      expect(result, equals('FF'));
    });

    test('进制转换 - 同单位直接返回', () {
      final result = ConversionLogic.convertNumberSystem(
        value: '1010',
        fromUnitId: 'binary',
        toUnitId: 'binary',
      );

      expect(result, equals('1010'));
    });

    test('进制转换 - 非法输入返回空字符串', () {
      final result = ConversionLogic.convertNumberSystem(
        value: 'XYZ',
        fromUnitId: 'hexadecimal',
        toUnitId: 'decimal',
      );

      expect(result, equals(''));
    });

    test('进制输入验证 - 八进制合法输入', () {
      final result = ConversionLogic.isValidNumberSystemInput('777', 'octal');
      expect(result, isTrue);
    });

    test('进制输入验证 - 八进制非法输入', () {
      final result = ConversionLogic.isValidNumberSystemInput('789', 'octal');
      expect(result, isFalse);
    });

    test('进制输入验证 - 空字符串视为合法', () {
      final result = ConversionLogic.isValidNumberSystemInput('', 'binary');
      expect(result, isTrue);
    });

    test('格式化结果 - 负数', () {
      final result = ConversionLogic.formatResult(-1.5);
      expect(result, equals('-1.5'));
    });

    test('格式化结果 - 零', () {
      final result = ConversionLogic.formatResult(0.0);
      expect(result, equals('0'));
    });

    test('格式化结果 - 多位小数', () {
      final result = ConversionLogic.formatResult(3.1415926535);
      expect(result, equals('3.14159265'));
    });

    test('格式化结果 - 极小值使用科学计数法', () {
      expect(ConversionLogic.formatResult(0.00001), equals('1.000000e-5'));
      expect(ConversionLogic.formatResult(-0.0000001), equals('-1.000000e-7'));
    });

    test('往返换算一致：米 → 千米 → 米', () {
      const meter = ConversionUnit(
        id: 'meter',
        name: '米',
        symbol: 'm',
        toBaseRatio: 1.0,
      );
      const kilometer = ConversionUnit(
        id: 'kilometer',
        name: '千米',
        symbol: 'km',
        toBaseRatio: 1000.0,
      );

      const original = 1234.5;
      final km = ConversionLogic.convert(
        value: original,
        fromUnit: meter,
        toUnit: kilometer,
      );
      final back = ConversionLogic.convert(
        value: km,
        fromUnit: kilometer,
        toUnit: meter,
      );

      expect(back, closeTo(original, 1e-9));
    });

    test('温度换算往返一致：摄氏 → 华氏 → 摄氏', () {
      const original = 37.5;
      final f = ConversionLogic.convertTemperature(
        value: original,
        fromUnitId: 'celsius',
        toUnitId: 'fahrenheit',
      );
      final back = ConversionLogic.convertTemperature(
        value: f,
        fromUnitId: 'fahrenheit',
        toUnitId: 'celsius',
      );

      expect(back, closeTo(original, 1e-9));
    });
  });
}

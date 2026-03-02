import 'package:flutter_test/flutter_test.dart';
import 'package:zen_calc/app/modules/converter/utils/conversion_logic.dart';
import 'package:zen_calc/app/modules/converter/models/conversion_unit.dart';

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
      final result = ConversionLogic.isValidNumberSystemInput('1A2F', 'hexadecimal');
      expect(result, isTrue);
    });

    test('进制输入验证 - 十六进制非法输入', () {
      final result = ConversionLogic.isValidNumberSystemInput('1G2F', 'hexadecimal');
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
  });
}

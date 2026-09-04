import 'package:flutter_test/flutter_test.dart';
import 'package:zen_calc/app/domain/converter/conversion_data.dart';

void main() {
  group('ConversionData 完整性测试', () {
    test('包含所有 9 个换算类别', () {
      expect(ConversionData.categories.length, 9);
      expect(
        ConversionData.categories.map((c) => c.id).toSet(),
        {
          'length',
          'area',
          'weight',
          'temperature',
          'volume',
          'speed',
          'pressure',
          'power',
          'number_system',
        },
      );
    });

    test('每个类别至少包含 2 个单位且 id 唯一', () {
      for (final category in ConversionData.categories) {
        expect(
          category.units.length,
          greaterThanOrEqualTo(2),
          reason: '类别 ${category.name} 单位数过少',
        );
        final ids = category.units.map((u) => u.id).toSet();
        expect(ids.length, category.units.length,
            reason: '类别 ${category.name} 存在重复单位 id');
      }
    });

    test('所有单位均含非空名称与符号', () {
      for (final category in ConversionData.categories) {
        for (final unit in category.units) {
          expect(unit.name.isNotEmpty, isTrue,
              reason: '${category.name} 中存在空名称单位');
          expect(unit.symbol.isNotEmpty, isTrue,
              reason: '${category.name} 中存在空符号单位');
        }
      }
    });

    test('特殊类别标记正确（温度/进制）', () {
      final special = ConversionData.categories
          .where((c) => c.isSpecial)
          .map((c) => c.id)
          .toSet();
      expect(special, {'temperature', 'number_system'});
    });

    test('基准单位 toBaseRatio 为 1.0（温度除外）', () {
      for (final category in ConversionData.categories) {
        if (category.isSpecial) continue;
        // 每类首个单位即基准单位
        expect(category.units.first.toBaseRatio, 1.0,
            reason: '类别 ${category.name} 基准单位比率不为 1');
      }
    });

    test('温度单位包含摄氏度/华氏度/开尔文', () {
      final tempIds = ConversionData.categories
          .firstWhere((c) => c.id == 'temperature')
          .units
          .map((u) => u.id)
          .toSet();
      expect(tempIds, {'celsius', 'fahrenheit', 'kelvin'});
    });

    test('进制单位包含二/八/十/十六进制', () {
      final nsIds = ConversionData.categories
          .firstWhere((c) => c.id == 'number_system')
          .units
          .map((u) => u.id)
          .toSet();
      expect(nsIds, {'binary', 'octal', 'decimal', 'hexadecimal'});
    });

    test('长度单位换算比率合理', () {
      final lengthUnits = ConversionData.lengthUnits;
      final meter = lengthUnits.firstWhere((u) => u.id == 'meter');
      final km = lengthUnits.firstWhere((u) => u.id == 'kilometer');
      final cm = lengthUnits.firstWhere((u) => u.id == 'centimeter');
      expect(meter.toBaseRatio, 1.0);
      expect(km.toBaseRatio, 1000.0);
      expect(cm.toBaseRatio, 0.01);
    });

    test('重量单位换算比率合理', () {
      final weightUnits = ConversionData.weightUnits;
      final kg = weightUnits.firstWhere((u) => u.id == 'kilogram');
      final ton = weightUnits.firstWhere((u) => u.id == 'ton');
      final jin = weightUnits.firstWhere((u) => u.id == 'jin');
      expect(kg.toBaseRatio, 1.0);
      expect(ton.toBaseRatio, 1000.0);
      expect(jin.toBaseRatio, 0.5);
    });
  });
}

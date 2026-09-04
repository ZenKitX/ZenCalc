import 'package:flutter_test/flutter_test.dart';
import 'package:zen_calc/app/modules/history/views/history_time_formatter.dart';

void main() {
  group('formatHistoryTime', () {
    test('一分钟内显示刚刚', () {
      final now = DateTime.now();
      expect(formatHistoryTime(now), '刚刚');
      expect(formatHistoryTime(now.subtract(const Duration(seconds: 30))), '刚刚');
    });

    test('一小时内显示分钟前', () {
      final time = DateTime.now().subtract(const Duration(minutes: 5));
      expect(formatHistoryTime(time), '5分钟前');
    });

    test('一天内显示小时前', () {
      final time = DateTime.now().subtract(const Duration(hours: 3));
      expect(formatHistoryTime(time), '3小时前');
    });

    test('一周内显示天前', () {
      final time = DateTime.now().subtract(const Duration(days: 2));
      expect(formatHistoryTime(time), '2天前');
    });

    test('超过一周显示月日', () {
      final time = DateTime.now().subtract(const Duration(days: 30));
      expect(formatHistoryTime(time), '${time.month}月${time.day}日');
    });
  });
}

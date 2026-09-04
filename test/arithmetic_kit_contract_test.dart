import 'package:arithmetic_kit/arithmetic_kit.dart';
import 'package:flutter_test/flutter_test.dart';

/// ArithmeticKit 输出契约测试
///
/// 锁定 arithmetic_kit 0.3.0（commit 9d0e075）的关键行为。
/// 应用层的错误处理（`result == 'Error'`）、整数无小数点、
/// 最多 8 位小数去尾零等逻辑均依赖这些契约。
/// 升级依赖 commit hash 时，此测试可捕获行为漂移。
///
/// 注意：包 README 中的 `sin(π/2)` / `log(100)` / `sqrt(16)` 示例
/// 与实际实现不符——科学函数只接受紧邻的数字参数（如 `sin30`），
/// 不支持函数级括号语法。以下用例按实际行为记录。
void main() {
  group('BasicCalculator 契约', () {
    test('运算符优先级：乘除先于加减', () {
      expect(BasicCalculator.calculate('2+3×4'), '14');
      expect(BasicCalculator.calculate('10-6÷2+3×4'), '19');
    });

    test('整数结果不含小数点', () {
      expect(BasicCalculator.calculate('2+3'), '5');
      expect(BasicCalculator.calculate('10÷2'), '5');
    });

    test('小数结果最多 8 位且去除尾零', () {
      expect(BasicCalculator.calculate('10÷4'), '2.5');
      expect(BasicCalculator.calculate('0.1+0.2'), '0.3');
    });

    test('取模运算', () {
      expect(BasicCalculator.calculate('5%3'), '2');
      expect(BasicCalculator.calculate('10%3'), '1');
    });

    test('空表达式与 0 均返回 0', () {
      expect(BasicCalculator.calculate(''), '0');
      expect(BasicCalculator.calculate('0'), '0');
    });

    test('除零返回 Error（应用层据此跳过历史记录）', () {
      expect(BasicCalculator.calculate('1÷0'), 'Error');
    });

    test('尾随运算符被静默截断而非报错（应用层预览前会自行移除尾运算符）', () {
      expect(BasicCalculator.calculate('2+'), '2');
    });
  });

  group('ScientificCalculator 契约', () {
    test('三角函数接受紧邻数字参数（弧度制）', () {
      expect(ScientificCalculator.calculate('cos0'), '1');
      expect(ScientificCalculator.calculate('sin0'), '0');
      expect(ScientificCalculator.calculate('tan0'), '0');
    });

    test('对数函数接受紧邻数字参数', () {
      expect(ScientificCalculator.calculate('log100'), '2');
      expect(ScientificCalculator.calculate('lne'), '1');
    });

    test('幂与开方接受紧邻数字参数', () {
      expect(ScientificCalculator.calculate('2^8'), '256');
      expect(ScientificCalculator.calculate('sqrt16'), '4');
    });

    test('函数级括号语法不被支持（与 README 示例不符，按实际行为记录）', () {
      expect(ScientificCalculator.calculate('sin(30)'), 'Error');
      expect(ScientificCalculator.calculate('sqrt(16)'), 'Error');
    });

    test('常量参与运算并按 8 位小数格式化', () {
      expect(ScientificCalculator.calculate('π×2'), '6.28318531');
    });

    test('无穷与非数值结果返回 Error', () {
      expect(ScientificCalculator.calculate('1÷0'), 'Error');
      expect(ScientificCalculator.calculate('log0'), 'Error');
    });
  });

  group('BasicCalculator.isValidInput 契约', () {
    test('当前数字已有小数点时禁止再输入小数点', () {
      expect(BasicCalculator.isValidInput('3.14', '.'), isFalse);
      expect(BasicCalculator.isValidInput('1', '.'), isTrue);
    });

    test('空表达式或 0 时接受任意输入', () {
      expect(BasicCalculator.isValidInput('', '5'), isTrue);
      expect(BasicCalculator.isValidInput('0', '5'), isTrue);
    });
  });
}

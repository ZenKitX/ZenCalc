import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:zen_calc/main.dart';

void main() {
  setUp(() {
    // 提供内存版 SharedPreferences，避免依赖真实平台通道
    SharedPreferences.setMockInitialValues({});
  });

  /// 显示屏的光标动画是无限循环的，不能使用 pumpAndSettle，
  /// 统一用固定时长的 pump 推进动画帧。
  /// 连续两次 pump 可让 400ms 的 AnimatedSwitcher 切换动画完整结束，
  /// 避免中途帧命中测试失败。
  Future<void> pumpFrame(WidgetTester tester) async {
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump(const Duration(milliseconds: 400));
  }

  testWidgets('Calculator basic input & equals', (tester) async {
    await tester.pumpWidget(const MyApp());
    await pumpFrame(tester);

    // 初始显示 0
    expect(find.text('0'), findsWidgets);

    // 输入 1 + 2 =
    await tester.tap(find.text('1'));
    await pumpFrame(tester);
    await tester.tap(find.text('+'));
    await pumpFrame(tester);
    await tester.tap(find.text('2'));
    await pumpFrame(tester);
    await tester.tap(find.text('='));
    await pumpFrame(tester);

    // 结果 3 显示在显示屏
    expect(find.text('3'), findsWidgets);
  });

  testWidgets('Scientific mode toggle and angle mode switch', (tester) async {
    await tester.pumpWidget(const MyApp());
    await pumpFrame(tester);

    // 切换到科学模式（初始显示“基础”按钮）
    await tester.tap(find.text('基础'));
    await pumpFrame(tester);
    expect(find.text('RAD'), findsOneWidget);

    // 点击 RAD 切换到 DEG
    await tester.tap(find.text('RAD'));
    await pumpFrame(tester);
    expect(find.text('DEG'), findsOneWidget);

    // 再切回 RAD
    await tester.tap(find.text('DEG'));
    await pumpFrame(tester);
    expect(find.text('RAD'), findsOneWidget);

    // 第一行不再有旧的 deg 按钮（已改名 ANS，避免与 DEG 标识语义冲突）
    expect(find.text('ANS'), findsOneWidget);
    expect(find.text('deg'), findsNothing);

    // 切回基础模式
    await tester.tap(find.text('科学'));
    await pumpFrame(tester);
    expect(find.text('基础'), findsOneWidget);
  });

  testWidgets('DEG mode converts trig functions to degree', (tester) async {
    await tester.pumpWidget(const MyApp());
    await pumpFrame(tester);

    // 切换到科学模式
    await tester.tap(find.text('基础'));
    await pumpFrame(tester);
    expect(find.text('RAD'), findsOneWidget);

    // RAD（弧度）模式：sin(30) = sin(30 rad) ≈ -0.98803162
    await tester.tap(find.text('sin'));
    await pumpFrame(tester);
    await tester.tap(find.text('3'));
    await pumpFrame(tester);
    await tester.tap(find.text('0'));
    await pumpFrame(tester);
    await tester.tap(find.text('='));
    await pumpFrame(tester);
    expect(find.text('-0.98803162'), findsOneWidget);

    // 清空并切换到 DEG（角度）模式
    await tester.tap(find.text('AC'));
    await pumpFrame(tester);
    await tester.tap(find.text('RAD'));
    await pumpFrame(tester);
    expect(find.text('DEG'), findsOneWidget);

    // DEG 模式：sin(30°) = 0.5
    await tester.tap(find.text('sin'));
    await pumpFrame(tester);
    await tester.tap(find.text('3'));
    await pumpFrame(tester);
    await tester.tap(find.text('0'));
    await pumpFrame(tester);
    await tester.tap(find.text('='));
    await pumpFrame(tester);
    expect(find.text('0.5'), findsOneWidget);
  });

  testWidgets('Clear button resets display', (tester) async {
    await tester.pumpWidget(const MyApp());
    await pumpFrame(tester);

    await tester.tap(find.text('7'));
    await pumpFrame(tester);
    await tester.tap(find.text('AC'));
    await pumpFrame(tester);

    expect(find.text('0'), findsWidgets);
  });
}

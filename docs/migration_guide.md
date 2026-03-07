# Migration Guide: 从内部逻辑到 ArithmeticKit

## 概述

本指南帮助开发者将代码从旧的内部计算逻辑迁移到新的 ArithmeticKit package。

## 快速迁移

### 步骤 1: 更新依赖

在 `pubspec.yaml` 中添加:

```yaml
dependencies:
  arithmetic_kit:
    path: packages/ArithmeticKit
```

运行:
```bash
flutter pub get
```

### 步骤 2: 更新 Import

**旧代码**:
```dart
import 'package:zen_calc/app/utils/calculator_logic.dart';
import 'package:zen_calc/app/utils/scientific_calculator_logic.dart';
```

**新代码**:
```dart
import 'package:arithmetic_kit/arithmetic_kit.dart';
```

### 步骤 3: 更新 API 调用

#### 基础计算器

**旧代码**:
```dart
String result = CalculatorLogic.calculate('2+3×4');
bool isValid = CalculatorLogic.isValidInput('3.14', '.');
```

**新代码**:
```dart
String result = BasicCalculator.calculate('2+3×4');
bool isValid = BasicCalculator.isValidInput('3.14', '.');
```

#### 科学计算器

**旧代码**:
```dart
String result = ScientificCalculatorLogic.calculate('sin(π/2)');
```

**新代码**:
```dart
String result = ScientificCalculator.calculate('sin(π/2)');
```

## API 对照表

| 旧 API | 新 API | 说明 |
|--------|--------|------|
| `CalculatorLogic.calculate()` | `BasicCalculator.calculate()` | 基础计算 |
| `CalculatorLogic.isValidInput()` | `BasicCalculator.isValidInput()` | 输入验证 |
| `ScientificCalculatorLogic.calculate()` | `ScientificCalculator.calculate()` | 科学计算 |

## 功能对比

### 基础计算器

✅ 所有功能保持不变:
- 加减乘除
- 取模运算
- 运算符优先级
- 输入验证
- 结果格式化

### 科学计算器

✅ 所有功能保持不变:
- 三角函数 (sin, cos, tan, asin, acos, atan)
- 对数函数 (log, ln)
- 幂运算 (^, x², e^, 10^)
- 平方根 (sqrt)
- 常数 (π, e)
- 括号支持

## 常见问题

### Q: 为什么要迁移？

A: 
- 更好的代码组织
- 可以在其他项目中复用
- 独立的测试和文档
- 更清晰的职责分离

### Q: 迁移会影响性能吗？

A: 不会。底层逻辑完全相同，只是组织方式不同。

### Q: 需要修改 UI 代码吗？

A: 不需要。只需要更新 import 和类名，功能完全兼容。

### Q: 如果遇到问题怎么办？

A: 
1. 检查 import 是否正确
2. 确认类名是否更新 (CalculatorLogic → BasicCalculator)
3. 运行 `flutter pub get` 确保依赖已安装
4. 查看 `packages/ArithmeticKit/README.md` 获取详细文档

## 完整示例

### 迁移前

```dart
import 'package:flutter/material.dart';
import 'package:zen_calc/app/utils/calculator_logic.dart';
import 'package:zen_calc/app/utils/scientific_calculator_logic.dart';

class CalculatorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 基础计算
    String basicResult = CalculatorLogic.calculate('2+3');
    
    // 科学计算
    String sciResult = ScientificCalculatorLogic.calculate('sin(π/2)');
    
    // 输入验证
    bool isValid = CalculatorLogic.isValidInput('3.14', '.');
    
    return Text('Results: $basicResult, $sciResult');
  }
}
```

### 迁移后

```dart
import 'package:flutter/material.dart';
import 'package:arithmetic_kit/arithmetic_kit.dart';

class CalculatorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 基础计算
    String basicResult = BasicCalculator.calculate('2+3');
    
    // 科学计算
    String sciResult = ScientificCalculator.calculate('sin(π/2)');
    
    // 输入验证
    bool isValid = BasicCalculator.isValidInput('3.14', '.');
    
    return Text('Results: $basicResult, $sciResult');
  }
}
```

## 验证迁移

运行以下命令确保迁移成功:

```bash
# 分析代码
flutter analyze

# 运行测试
flutter test

# 编译应用
flutter build apk --debug
```

## 回滚

如果需要回滚到旧版本:

1. 恢复 `lib/app/utils/calculator_logic.dart`
2. 恢复 `lib/app/utils/scientific_calculator_logic.dart`
3. 更新 import 和 API 调用
4. 从 `pubspec.yaml` 移除 `arithmetic_kit` 依赖

## 支持

如有问题，请查看:
- [ArithmeticKit README](../packages/ArithmeticKit/README.md)
- [Package Refactoring Summary](./package_refactoring_summary.md)

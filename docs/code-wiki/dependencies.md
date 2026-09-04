# 依赖关系

## 技术栈与环境要求

| 类别 | 技术 |
|------|------|
| 框架 | Flutter 3.41+（Dart 3.11+） |
| 状态管理 & 路由 | **GetX**（`get: ^4.6.6`） |
| 本地存储 | **shared_preferences**（`^2.2.0`） |
| 领域逻辑包 | ArithmeticKit / ConversionKit / ZenUIKit / ZenThemeKit / ZenQuoteKit / FeedbackKit / HistoryKit |
| UI 依赖 | 零第三方 UI 依赖，Neumorphic 效果由自研包实现 |
| 构建工具 | flutter_launcher_icons（应用图标生成）、CNB 流水线（CI/CD） |

环境：`shared_preferences` 需在 iOS 编译时通过 `--no-tree-shake-icons` 等处理，见各平台工程配置。

## 外部 / 第三方依赖（pubspec.yaml）

| 依赖 | 版本 | 用途 |
|------|------|------|
| cupertino_icons | ^1.0.8 | iOS 风格图标 |
| get | ^4.6.6 | 状态管理 + 路由 |
| shared_preferences | ^2.2.0 | 本地持久化 |
| flutter_lints（dev） | ^6.0.0 | 静态分析 |
| flutter_launcher_icons（dev） | ^0.13.1 | 应用图标生成 |

## 内部 Git 领域包（team 自研）

| 包 | Git 仓库 | 使用位置 |
|----|---------|---------|
| arithmetic_kit | ZenKitX/ArithmeticKit | 计算逻辑（Basic/ScientificCalculator） |
| conversion_kit | ZenKitX/ConversionKit | ⚠️ 未启用（换算用本地实现） |
| zen_ui_kit | ZenKitX/ZenUIKit | ZenButton/ZenDisplay 组件 |
| zen_theme_kit | ZenKitX/ZenThemeKit | ZenTheme/SandGarden/BambooForest 主题 |
| zen_quote_kit | ZenKitX/ZenQuoteKit | ZenQuoteService/ZenQuoteWidget |
| feedback_kit | ZenKitX/FeedbackKit | HapticService/AudioService |
| history_kit | ZenKitX/HistoryKit | HistoryService/HistoryItem |

**本地开发切换**：`pubspec_local.yaml` 提供 `path:` 依赖版本，便于本地调试这些包（切换方式为改 pubspec 依赖声明）。

## 依赖方向

模块依赖图与数据流见 [architecture.md](architecture.md)。核心方向：
- 主应用（lib/）→ 独立领域包（ArithmeticKit、ZenUIKit、ZenThemeKit、ZenQuoteKit、FeedbackKit、HistoryKit）。
- ConversionKit 未启用，换算模块使用应用内本地实现。
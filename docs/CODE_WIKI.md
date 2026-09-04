# ZenCalc 代码 Wiki（Code Wiki）

> 本文档是对 ZenCalc 项目的结构化代码说明，涵盖整体架构、模块职责、关键类与函数、依赖关系、数据流与运行方式。用于帮助开发者快速理解代码库。

---

## 1. 项目概览

**ZenCalc（禅意计算器）** 是一个融合禅意美学的 Flutter 计算器应用，采用 **Neumorphic（拟物）** 设计风格，提供宁静、专注的计算体验。

- **项目定位**：跨平台（Android / iOS / Web / Windows / macOS / Linux）计算器应用
- **运行目标**：1.0.8（+build 9）
- **MIT 开源协议**
- **仓库**：`https://github.com/ZenKitX/ZenCalc`（镜像源：cnb.cool）

核心功能：
| 功能 | 版本 | 说明 |
|------|------|------|
| 基础四则运算 | v1.0.0 | +、-、×、÷，连续计算，退格删除 |
| 科学计算 | v1.0.3 | 三角函数、对数、幂、括号、常数、RAD/DEG 角度模式 |
| 单位换算 | v1.0.5 | 9 大类别、60+ 单位、实时换算、进制转换 |
| 历史记录 | v1.0.0 | 自动保存、统计、滑动删除、点击复用 |
| 禅意特性 | v1.0.0 | 触觉反馈、音效框架、禅语、深浅主题 |

---

## 2. 技术栈与环境要求

| 类别 | 技术 |
|------|------|
| 框架 | Flutter 3.41+（Dart 3.11+） |
| 状态管理 & 路由 | **GetX**（`get: ^4.6.6`） |
| 本地存储 | **shared_preferences**（`^2.2.0`） |
| 领域逻辑包 | ArithmeticKit / ConversionKit / ZenUIKit / ZenThemeKit / ZenQuoteKit / FeedbackKit / HistoryKit |
| UI 依赖 | 零第三方 UI 依赖，Neumorphic 效果由自研包实现 |
| 构建工具 | flutter_launcher_icons（应用图标生成）、CNB 流水线（CI/CD） |

环境：`shared_preferences` 需在 iOS 编译时通过 `--no-tree-shake-icons` 等处理，见各平台工程配置。

---

## 3. 整体架构

ZenCalc 采用 **分层的模块化架构**，核心业务逻辑被抽取为独立 Dart 包，主应用负责 UI 与模块编排。

### 3.1 分层结构

```
┌─────────────────────────────────────────────────────┐
│                 主应用 lib/ (ZenCalc)                │
│  ┌───────────────────────────────────────────────┐  │
│  │  UI Layer（视图 / 组件）                       │  │
│  │  Calculator ・ Converter ・ History ・ 通用组件  │  │
│  └───────────────────────────────────────────────┘  │
│  ┌───────────────────────────────────────────────┐  │
│  │  Business Layer（服务 / 控制器 / 适配器）       │  │
│  │  CalculationHistoryService・ZenSettingsService │  │
│  └───────────────────────────────────────────────┘  │
│  ┌───────────────────────────────────────────────┐  │
│  │  Data Layer（模型 / 路由 / 主题配置）           │  │
│  │  CalculationHistory・AppPages・AppTheme        │  │
│  └───────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────┘
        │ 依赖
┌───────▼─────────────────────────────────────────┐
│           独立领域包（Git 依赖）                  │
│  ArithmeticKit  计算逻辑（基础+科学）             │
│  ConversionKit  单位换算（独立维护，未启用）       │
│  ZenUIKit       Neumorphic UI 组件库             │
│  ZenThemeKit    主题预设（沙石庭院/夜间竹林）      │
│  ZenQuoteKit    禅语服务（中/英/日）              │
│  FeedbackKit    触觉 + 音频反馈                  │
│  HistoryKit     历史记录通用管理                  │
└──────────────────────────────────────────────────┘
```

### 3.2 包集成决策（重要）

根据 `docs/INTEGRATION_STATUS.md`：
- **已集成（6/7）**：ArithmeticKit、ZenUIKit、ZenThemeKit、ZenQuoteKit、FeedbackKit、HistoryKit。
- **独立维护（1/7）**：ConversionKit **未集成**——单位换算模块 `lib/app/modules/converter/` 继续使用本地实现，因为本地实现功能完整、测试通过，迁移收益低。

> ⚠️ **注意**：判断代码时勿混淆——换算模块的 `ConversionLogic`/`ConversionData` 是**应用内本地实现**，不依赖 ConversionKit 包。

---

## 4. 目录结构

```
lib/
├── main.dart                          # 应用入口（ZenTheme + GetMaterialApp）
└── app/
    ├── components/                    # 通用组件
    │   ├── zen_calc_button.dart       # 计算器按钮（封装 ZenButton + 反馈）
    │   └── zen_calc_display.dart      # 计算器显示屏（含预览 + 光标动画）
    ├── config/theme/
    │   ├── app_theme.dart             # 主题入口（深浅主题 ThemeData）
    │   └── zen_calc_colors.dart       # 颜色配置（沙石庭院/夜间竹林）
    ├── data/models/
    │   └── calculation_history.dart   # 计算历史领域模型
    ├── modules/
    │   ├── calculator/                # 计算器模块（基础 + 科学）
    │   │   └── views/
    │   │       ├── calculator_view.dart        # 核心计算逻辑（StatefulWidget）
    │   │       ├── calculator_getx_view.dart   # GetX 路由视图适配器
    │   │       └── widgets/
    │   │           ├── calculator_top_bar.dart          # 顶部工具栏
    │   │           ├── basic_button_grid.dart           # 基础按钮网格
    │   │           └── scientific_button_grid.dart      # 科学按钮网格
    │   ├── converter/                 # 单位换算模块（本地实现）
    │   │   ├── controllers/converter_controller.dart
    │   │   ├── models/conversion_category.dart, conversion_unit.dart
    │   │   ├── utils/conversion_data.dart, conversion_logic.dart
    │   │   └── views/converter_view.dart, conversion_detail_view.dart
    │   │       └── widgets/category_card.dart, conversion_keypad.dart, unit_selector.dart
    │   └── history/                   # 历史记录模块
    │       ├── bindings/history_binding.dart
    │       ├── controllers/history_controller.dart
    │       └── views/history_view.dart, history_getx_view.dart
    ├── routes/
    │   ├── app_pages.dart             # GetX 路由表
    │   └── app_routes.dart            # 路由常量
    └── services/
        ├── calculation_history_service.dart   # HistoryKit 适配器
        └── zen_settings_service.dart          # 禅语设置持久化
test/                              # 单元 / Widget 测试
android/ ios/ web/ windows/ macos/ linux/   # 各平台工程
docs/                               # 文档（含本文件）
design/                             # 应用图标设计资源
```

---

## 5. 入口流程与路由

### 5.1 应用启动（`lib/main.dart`）

`main()` → `runApp(MyApp)`。

`MyApp` 是 `StatelessWidget`，构建时：
1. 用 `ZenTheme(data: ZenThemeData.sandGarden())`（来自 ZenThemeKit）包裹整个应用，提供主题上下文。
2. `GetMaterialApp` 配置两种 `ThemeData`（`AppTheme.lightTheme` / `AppTheme.darkTheme`），`themeMode: ThemeMode.system` 跟随系统。
3. 初始路由为 `AppPages.initial`（即 `Routes.calculator`），路由表由 `AppPages.routes` 提供。

### 5.2 路由表（`lib/app/routes/app_pages.dart`）

| 路由 | 页面 | Binding |
|------|------|---------|
| `/calculator`（初始） | `CalculatorView` | 无 |
| `/history` | `HistoryView` | `HistoryBinding` |

`Routes` 抽象类定义公共常量名，`_Paths` 内部类定义实际路径字符串（通过 `part`/`part of` 组合）。

### 5.3 路由使用说明

实际页面导航方式**不统一**，是既有技术债：
- 计算器 → 设置/历史/换算：使用 **Navigator.push**（MaterialPageRoute），未走 GetX 命名路由。
- `HistoryView`（GetX 适配器）通过 `Get.back(result: value)` 返回值；`HistoryScreen`（实际视图）通过 `Navigator.pop`。

---

## 6. 主要模块职责

### 6.1 计算器模块（`modules/calculator`）

**核心文件**：`calculator_view.dart` —— 这是全应用逻辑最密集的文件。

`CalculatorScreen`（StatefulWidget）持有全部计算状态：
| 状态字段 | 类型 | 说明 |
|---------|------|------|
| `displayText` | String | 当前输入表达式 |
| `result` | String | 实时预览 / 最终结果 |
| `shouldResetDisplay` | bool | 按下等号后是否重置显示 |
| `_currentQuote` | ZenQuote? | 当前展示的禅语 |
| `_isScientificMode` | bool | 是否科学模式 |
| `_isInverseMode` | bool | 是否反函数模式 |
| `_isDegreeMode` | bool | 是否角度（DEG）模式 |
| `_lastExpression` | String | 上次计算式（供 ANS 按钮） |
| `_zenQuoteService` | ZenQuoteService | 禅语服务（语言敏感） |

**关键方法与职责**：
| 方法 | 职责 |
|------|------|
| `onButtonPressed(String)` | 统一按核心入口：重置逻辑、初始 0、`00` 处理、运算符去重/替换、`BasicCalculator.isValidInput` 输入校验、追加并实时预览 |
| `_updatePreview()` | 实时计算预览结果（DEG 模式先做角度换算） |
| `onEquals()` | 计算结果、仅此入历史、触发禅语 |
| `onClear()` / `onDelete()` | 清空 / 退格 |
| `_applyDegreeMode(String)` | DEG 模式下将三角函数按 角度×π/180 / 弧度×180/π 换算 |
| `_tryConvertTrig(...)` | 匹配 sin/cos/tan 及反函数并换算参数 |
| `_extractPlainNumber(...)` | 提取纯数字（含负号/小数点/科学计数法） |
| `_findClosingParen(...)` | 找到匹配的右括号 |

**RAD/DEG 模式（v1.0.8 修复）**：ArithmeticKit 内部恒为弧度制。DEG 模式下把正向三角函数参数由角度换算为弧度交给库，把反向函数结果由弧度换算回角度。支持 `sin30` 与 `sin(30)` 两种写法，括号内可含可求值表达式。

**计算逻辑**：委托给 **ArithmeticKit**——
- `BasicCalculator.calculate(expression)`：基础四则运算
- `ScientificCalculator.calculate(expression)`：科学表达式计算

**视图组件**：
- `CalculatorTopBar`：设置、科学/基础切换、换算入口、历史、主题按钮。
- `BasicButtonGrid`：5 行 4 列布局（`AC % ⌫ ÷` / `7 8 9 ×` / `4 5 6 -` / `1 2 3 +` / `00 0 . =`）。
- `ScientificButtonGrid`：7 行 5 列布局（函数按钮 + inv/DEG/ANS 切换）。
- 基础/科学切换使用 `AnimatedSwitcher` + `SizeTransition` + `FadeTransition`（400ms）。

> 说明：`calculator_getx_view.dart` 是历史遗留的 GetX 适配器（v1.0.8 已移除未使用的 Controller），仅作路由页面包装。

### 6.2 单位换算模块（`modules/converter`，本地实现）

**控制器**：`ConverterController`（GetX `GetxController`）承载换算状态：
| 状态 | 说明 |
|------|------|
| `selectedCategory` | 当前选择的类别 |
| `inputValue` / `outputValue` | 输入 / 输出字符串 |
| `fromUnit` / `toUnit` | 输入源 / 输出目标单位 |

**方法**：`selectCategory`、`inputDigit`、`deleteLast`、`clear`、`setFromUnit`、`setToUnit`、`swapUnits`、`_calculate`、`backToCategories`。

**核心逻辑**（`utils/conversion_logic.dart`，纯静态工具类，易测试）：
| 方法 | 职责 |
|------|------|
| `convert(value, fromUnit, toUnit)` | 通用换算：先转基准单位再转目标单位（`value × from.toBaseRatio ÷ to.toBaseRatio`） |
| `convertTemperature(...)` | 温度特殊处理：统一经摄氏度中转 |
| `convertNumberSystem(...)` | 进制转换：先转十进制再转目标进制 |
| `isValidNumberSystemInput(...)` | 进制输入合法性校验 |
| `formatResult(double)` | 结果格式化：去尾零、科学计数法 |

**数据定义**（`utils/conversion_data.dart`）：静态常量定义 9 大类别——长度、面积、重量、温度（特殊）、体积、速度、压强、功率、进制（特殊）。每类含多个 `ConversionUnit`（`id/name/symbol/toBaseRatio`）。

**模型**：
- `ConversionCategory`：`id/name/icon/units/requiresApi/isSpecial`。
- `ConversionUnit`：`id/name/symbol/toBaseRatio`。

**视图**：
- `ConverterView`：类别选择网格；选中类别后切换到 `ConversionDetailView`（同一 `Obx` 内切换）。
- `ConversionDetailView`：输入/输出卡片 + 交换按钮 + 键盘。
- `ConversionKeypad`：普通数字键盘 与 进制专用键盘（含 A–F）。
- `UnitSelector`：底部弹窗选单位。
- `CategoryCard`：类别卡片（带按压缩放动画）。

**技术债提示**：converter 模块的配色使用硬编码的 `Color(0xFF1A1A1A)` / `Color(0xFFE8E4DC)` / `Color(0xFF6B8E23)` 等，未复用协商好的主题常量，与计算器模块的风格存在差异。

### 6.3 历史记录模块（`modules/history`）

- `HistoryScreen`（StatefulWidget）：真实界面。展示统计（总计/今日/本周）、记录列表（`Dismissible` 滑动删除）、清空确认对话框、点击复用。
- `HistoryController`（GetX）+ `HistoryBinding`：GetX 命名路由 `/history` 使用；加载 / 清空历史。
- `HistoryView` / `HistoryGetxView`：适配器，`Get.back(result: value)`。

历史数据来源是 `CalculationHistoryService`（见第 7 节），两者可能不同步（计算器直接读写 service，历史页动态读取）。

---

## 7. 服务层

### 7.1 `CalculationHistoryService`（HistoryKit 适配器）

将通用 `HistoryService`（来自 HistoryKit，storageKey=`calculation_history`，maxItems=100）包装为计算器领域接口：
- `history`（getter）：把 `HistoryItem` 列表映射为 `CalculationHistory`。
- `addHistory(expression, result)`：**跳过**结果为 `Error` 或表达式中不含运算符的记录。
- `clearHistory()`、`deleteHistory(index)`、`loadFromLocal()`。
- `getStatistics()` → `{total, today, thisWeek}`。

### 7.2 `ZenSettingsService`（SharedPreferences 持久化）

管理禅语相关设置，带内存缓存 + 参数校验：
- `get/setZenQuotesEnabled`（默认 `true`）
- `get/setZenQuotesLanguage`（`zh`/`en`/`ja`，默认 `zh`，非法值抛 `ArgumentError`）
- `get/setZenQuotesFrequency`（0.0–1.0，默认 0.3）
- `clearCache()`、`resetToDefaults()`

---

## 8. 通用组件

### 8.1 `ZenCalcButton`（`components/zen_calc_button.dart`）

封装 ZenUIKit 的 `ZenButton`，按下时按按钮类型触发反馈：
| 按钮类型 | 触觉 | 音频 |
|---------|------|------|
| `AC` | `HapticService.heavy()` | `AudioService.playClearSound()` |
| 等号 | `heavy()` | `playEqualsSound()` |
| 运算符 | `medium()` | `playOperatorSound()` |
| 普通 | `light()` | `playNumberSound()` |

等号按钮使用 `ZenButtonStyle.accent` 强调样式并禁用 Neumorphic 阴影。

### 8.2 `ZenCalcDisplay`（`components/zen_calc_display.dart`）

基于 ZenUIKit `ZenDisplay` 的显示屏，含：
- 上方表达式（按等号后显示）、主显示区、实时预览区三层结构。
- `AnimatedSwitcher` + `FadeTransition` + `SlideTransition` 数字切换动画。
- `_BlinkingCursor`（私有组件）：无限循环闪烁光标，使用 `SingleTickerProviderStateMixin`。
- 依赖 **Neumorphic 凹陷阴影**（`shadows.neumorphicInset`）。

> ⚠️ **测试注意**：光标动画无限循环，widget 测试不能用 `pumpAndSettle`，需固定时长 `pump`（见 `test/calculator_view_test.dart`）。

---

## 9. 主题与设计系统

### 9.1 `AppTheme`（`config/theme/app_theme.dart`）

- 定义浅色「沙石庭院」与深色「夜间竹林」的颜色常量（向后兼容）。
- `lightTheme = SandGardenTheme.themeData()`，`darkTheme = BambooForestTheme.themeData()`（来自 ZenThemeKit）。

### 9.2 配色

| 主题 | 背景 | 文字 | 强调 |
|------|------|------|------|
| 浅色（沙石庭院） | `#E8E4DC` | `#3A3A3A` | `#7C9885` |
| 深色（夜间竹林） | `#2B2D2A` | `#E8E4DC` | `#8FA896` |

### 9.3 动画时序
- 按钮按压 150ms、阴影过渡 200ms、数字切换 300–400ms、主题切换 800ms。

---

## 10. 关键数据流

### 10.1 计算流程（等号）

```
按钮点击 → onButtonPressed/onEquals
        → BasicCalculator.isValidInput 校验
        → （DEG？_applyDegreeMode 换算三角函数）
        → BasicCalculator / ScientificCalculator.calculate
        → 返回 String
        → onEquals：result=…，shouldResetDisplay=true
        → （非 Error）CalculationHistoryService.addHistory
        → ZenQuoteService.getQuote(按 context/probability) 触发禅语
        → ZenCalcDisplay 展示
```

### 10.2 实时预览流程

`onButtonPressed` 每次变更 → `_updatePreview()`：
去掉尾部运算符 → DEG 换算 → 计算 → 若结果非 `Error` 且与输入不同则更新 `result`，否则置 `0`。

### 10.3 换算流程

```
输入 → ConverterController.inputDigit
    → ConversionLogic.isValidNumberSystemInput（进制类）
    → _calculate()
    → 温度？ convertTemperature : convert
    → formatResult → outputValue
```

---

## 11. 依赖关系

### 11.1 外部 / 第三方依赖（pubspec.yaml）

| 依赖 | 版本 | 用途 |
|------|------|------|
| cupertino_icons | ^1.0.8 | iOS 风格图标 |
| get | ^4.6.6 | 状态管理 + 路由 |
| shared_preferences | ^2.2.0 | 本地持久化 |
| flutter_lints（dev） | ^6.0.0 | 静态分析 |
| flutter_launcher_icons（dev） | ^0.13.1 | 应用图标生成 |

### 11.2 内部 Git 领域包（team 自研）

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

### 11.3 模块依赖图（主应用内部）

```
main.dart
   ├── ZenThemeKit (ZenTheme)
   └── GetMaterialApp
        └── CalculatorView ──▶ CalculatorScreen
              ├── ArithmeticKit (计算)
              ├── FeedbackKit (反馈)
              ├── ZenQuoteKit (禅语)
              ├── CalculationHistoryService ──▶ HistoryKit
              ├── ZenSettingsService ──▶ shared_preferences
              ├── BasicButtonGrid / ScientificButtonGrid ──▶ ZenCalcButton ──▶ ZenUIKit + FeedbackKit
              └── ZenCalcDisplay ──▶ ZenUIKit + ZenThemeKit
        └── HistoryView ──▶ HistoryScreen ──▶ CalculationHistoryService
        └── ConverterView ──▶ ConverterController ──▶ ConversionLogic/ConversionData（本地）
```

---

## 12. 测试

测试文件位于 `test/`：

| 文件 | 类型 | 覆盖内容 |
|------|------|---------|
| `calculator_view_test.dart` | Widget | 基础输入与等号、科学模式切换、RAD/DEG 角度模式、AC 清零 |
| `converter_test.dart` | 单元 | ConversionLogic：单位/温度/进制/格式化等 30+ 用例 |
| `conversion_data_test.dart` | 单元 | ConversionData 完整性：9 类别、单位非空、特殊标记等 |
| `widget_test.dart` | Widget | 冒烟测试：初始显示 `0` |
| `zen_settings_service_test.dart` | 单元 | ZenSettingsService 逻辑 |

**运行测试**：
```bash
flutter test
```

> ⚠️ Calculator widget 测试用 `pumpFrame`（固定两次 400ms pump）推进动画，不能用 `pumpAndSettle`（光标无限动画）。

---

## 13. 项目运行方式

### 13.1 环境要求
- Flutter SDK **3.41+**、Dart **3.11+**。

### 13.2 获取依赖并运行

```bash
# 1. 克隆
git clone https://cnb.cool/h1s97x/ZenKitX/ZenCalc.git
cd ZenCalc

# 2. 获取依赖（Git 领域包会从 GitHub 拉取）
flutter pub get

# 3. 运行（默认占用格式选择设备）
flutter run

# 4. 指定平台
flutter run -d android   # Android
flutter run -d chrome    # Web
flutter run -d linux     # Linux 桌面
```

### 13.3 构建

```bash
# APK（发布）
flutter build apk --release

# App Bundle（上架 Google Play）
flutter build appbundle --release

# Web
flutter build web --release

# Linux 桌面
flutter build linux --release
```

### 13.4 使用本地领域包开发

将 `pubspec.yaml` 中的 git 依赖切换为 `pubspec_local.yaml` 的 `path:` 形式，链接本地 `packages/` 目录。

---

## 14. CI/CD 与发布

配置文件：`.cnb.yml`（CNB 流水线）。

| 触发 | 阶段动作 |
|------|---------|
| `push` | 同步到 GitHub 镜像 + CI（`flutter pub get` → `flutter analyze` → `flutter test`） |
| `tag_push` | 构建多平台产物（APK/AAB/Web/Linux）+ 创建 Release + 上传附件 |
| `issue.open/reopen` | 自动指派给 h1s97x |
| `pull_request` | 自动指派 reviewer + CI |

**签名**：`tag_push` 时若有 `KEYSTORE_BASE64` 环境变量则注入签名；未配置则使用 debug 签名（详见 `docs/SETUP_SIGNING.md`、`docs/SIGNING.md`）。

---

## 15. 技术债与注意事项

1. **CON002 – 路由不统一**：导航混用 GetX 命名路由与 `Navigator.push`，建议统一。
2. **CON001 – 核心逻辑集中**：`CalculatorScreen` 承载几乎所有计算状态与逻辑，体量较大，建议抽取状态管理与计算逻辑。
3. **风格不统一**：converter 模块使用硬编码颜色，未复用主题常量。
4. **Dead Code**：`calculator_getx_view.dart` 为历史遗留适配器（v1.0.8 已移除未用 Controller）。
5. **音效系统**：`AudioService` 接口就绪但实际音频资源未实现（见 CHANGELOG 已知问题）。
6. **ConversionKit 未集成**：换算模块为本地实现，与生态包存在演进分叉。

---

## 16. 参考文档

- `README.md`：使用说明、功能清单、设计理念
- `docs/INTEGRATION_STATUS.md`：包集成状态与决策
- `docs/package_refactoring_todo.md`：包拆分演进史（7 个领域包）
- `docs/SETUP_SIGNING.md`、`docs/SIGNING.md`：应用签名配置
- `design/icon_philosophy.md`：应用图标设计哲学
- `CHANGELOG.md`：版本演进记录
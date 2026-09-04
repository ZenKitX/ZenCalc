# 架构

## 整体架构

ZenCalc 采用 **分层的模块化架构**，核心业务逻辑被抽取为独立 Dart 包，主应用负责 UI 与模块编排。

### 分层结构

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

## 目录结构

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

## 关键数据流

### 计算流程（等号）

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

### 实时预览流程

`onButtonPressed` 每次变更 → `_updatePreview()`：
去掉尾部运算符 → DEG 换算 → 计算 → 若结果非 `Error` 且与输入不同则更新 `result`，否则置 `0`。

### 换算流程

```
输入 → ConverterController.inputDigit
    → ConversionLogic.isValidNumberSystemInput（进制类）
    → _calculate()
    → 温度？ convertTemperature : convert
    → formatResult → outputValue
```

### 模块依赖图（主应用内部）

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
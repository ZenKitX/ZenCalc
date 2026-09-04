# API 参考

## 入口流程

### 应用启动（`lib/main.dart`）

`main()` → `runApp(MyApp)`。

`MyApp` 是 `StatelessWidget`，构建时：
1. 用 `ZenTheme(data: ZenThemeData.sandGarden())`（来自 ZenThemeKit）包裹整个应用，提供主题上下文。
2. `GetMaterialApp` 配置两种 `ThemeData`（`AppTheme.lightTheme` / `AppTheme.darkTheme`），`themeMode: ThemeMode.system` 跟随系统。
3. 初始路由为 `AppPages.initial`（即 `Routes.calculator`），路由表由 `AppPages.routes` 提供。

## 路由表（`lib/app/routes/app_pages.dart`）

| 路由 | 页面 | Binding |
|------|------|---------|
| `/calculator`（初始） | `CalculatorView` | 无 |
| `/history` | `HistoryView` | `HistoryBinding` |

`Routes` 抽象类定义公共常量名，`_Paths` 内部类定义实际路径字符串（通过 `part`/`part of` 组合）。

### 路由使用说明

实际页面导航方式**不统一**，是既有技术债：
- 计算器 → 设置/历史/换算：使用 **Navigator.push**（MaterialPageRoute），未走 GetX 命名路由。
- `HistoryView`（GetX 适配器）通过 `Get.back(result: value)` 返回值；`HistoryScreen`（实际视图）通过 `Navigator.pop`。

## 数据模型

### `CalculationHistory`（`data/models/calculation_history.dart`）

计算历史领域模型：
- `expression`：输入表达式
- `result`：计算结果
- `timestamp`：计算时间戳

### 换算模块模型（`modules/converter/models/`）

- `ConversionCategory`：`id/name/icon/units/requiresApi/isSpecial`，换算类别定义。
- `ConversionUnit`：`id/name/symbol/toBaseRatio`，单位定义。

## 服务层 API

见 [modules.md](modules.md) 中服务层说明：
- `CalculationHistoryService`：计算历史读写与统计
- `ZenSettingsService`：禅语设置持久化（启用开关、语言、频率）
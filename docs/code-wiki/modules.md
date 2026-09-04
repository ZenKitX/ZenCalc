# 模块职责

## 计算器模块（`modules/calculator`）

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

## 单位换算模块（`modules/converter`，本地实现）

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

> 技术债提示：converter 模块的配色使用硬编码的 `Color(0xFF1A1A1A)` / `Color(0xFFE8E4DC)` / `Color(0xFF6B8E23)` 等，未复用协商好的主题常量，与计算器模块的风格存在差异。

## 历史记录模块（`modules/history`）

- `HistoryScreen`（StatefulWidget）：真实界面。展示统计（总计/今日/本周）、记录列表（`Dismissible` 滑动删除）、清空确认对话框、点击复用。
- `HistoryController`（GetX）+ `HistoryBinding`：GetX 命名路由 `/history` 使用；加载 / 清空历史。
- `HistoryView` / `HistoryGetxView`：适配器，`Get.back(result: value)`。

历史数据来源是 `CalculationHistoryService`（见 API 参考），两者可能不同步（计算器直接读写 service，历史页动态读取）。

## 服务层

### `CalculationHistoryService`（HistoryKit 适配器）

将通用 `HistoryService`（来自 HistoryKit，storageKey=`calculation_history`，maxItems=100）包装为计算器领域接口：
- `history`（getter）：把 `HistoryItem` 列表映射为 `CalculationHistory`。
- `addHistory(expression, result)`：**跳过**结果为 `Error` 或表达式中不含运算符的记录。
- `clearHistory()`、`deleteHistory(index)`、`loadFromLocal()`。
- `getStatistics()` → `{total, today, thisWeek}`。

### `ZenSettingsService`（SharedPreferences 持久化）

管理禅语相关设置，带内存缓存 + 参数校验：
- `get/setZenQuotesEnabled`（默认 `true`）
- `get/setZenQuotesLanguage`（`zh`/`en`/`ja`，默认 `zh`，非法值抛 `ArgumentError`）
- `get/setZenQuotesFrequency`（0.0–1.0，默认 0.3）
- `clearCache()`、`resetToDefaults()`

## 通用组件

### `ZenCalcButton`（`components/zen_calc_button.dart`）

封装 ZenUIKit 的 `ZenButton`，按下时按按钮类型触发反馈：
| 按钮类型 | 触觉 | 音频 |
|---------|------|------|
| `AC` | `HapticService.heavy()` | `AudioService.playClearSound()` |
| 等号 | `heavy()` | `playEqualsSound()` |
| 运算符 | `medium()` | `playOperatorSound()` |
| 普通 | `light()` | `playNumberSound()` |

等号按钮使用 `ZenButtonStyle.accent` 强调样式并禁用 Neumorphic 阴影。

### `ZenCalcDisplay`（`components/zen_calc_display.dart`）

基于 ZenUIKit `ZenDisplay` 的显示屏，含：
- 上方表达式（按等号后显示）、主显示区、实时预览区三层结构。
- `AnimatedSwitcher` + `FadeTransition` + `SlideTransition` 数字切换动画。
- `_BlinkingCursor`（私有组件）：无限循环闪烁光标，使用 `SingleTickerProviderStateMixin`。
- 依赖 **Neumorphic 凹陷阴影**（`shadows.neumorphicInset`）。

> ⚠️ **测试注意**：光标动画无限循环，widget 测试不能用 `pumpAndSettle`，需固定时长 `pump`（见测试文档）。
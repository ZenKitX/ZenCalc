# 设计决策

## 包集成决策（重要）

根据 `docs/INTEGRATION_STATUS.md`：
- **已集成（6/7）**：ArithmeticKit、ZenUIKit、ZenThemeKit、ZenQuoteKit、FeedbackKit、HistoryKit。
- **独立维护（1/7）**：ConversionKit **未集成**——单位换算模块 `lib/app/modules/converter/` 继续使用本地实现，因为本地实现功能完整、测试通过，迁移收益低。

> ⚠️ **注意**：判断代码时勿混淆——换算模块的 `ConversionLogic`/`ConversionData` 是**应用内本地实现**，不依赖 ConversionKit 包。

## 核心设计思想

- **分层模块化**：核心业务逻辑抽取为独立领域包，主应用负责 UI 与模块编排。
- **零第三方 UI 依赖**：Neumorphic 效果由自研包（ZenUIKit/ZenThemeKit）实现，保持视觉一致性。
- **RAD/DEG 统一弧度制**：ArithmeticKit 内部恒为弧度制，DEG 模式由主应用负责三角函数的角度/弧度换算。

## 技术债与注意事项

1. **CON002 – 路由不统一**：导航混用 GetX 命名路由与 `Navigator.push`，建议统一。
2. **CON001 – 核心逻辑集中**：`CalculatorScreen` 承载几乎所有计算状态与逻辑，体量较大，建议抽取状态管理与计算逻辑。
3. **风格不统一**：converter 模块使用硬编码颜色，未复用主题常量。
4. **Dead Code**：`calculator_getx_view.dart` 为历史遗留适配器（v1.0.8 已移除未用 Controller）。
5. **音效系统**：`AudioService` 接口就绪但实际音频资源未实现（见 CHANGELOG 已知问题）。
6. **ConversionKit 未集成**：换算模块为本地实现，与生态包存在演进分叉。

## 扩展约定

- 新增功能优先复用已集成的领域包（ArithmeticKit / ZenUIKit / ZenThemeKit / ZenQuoteKit / FeedbackKit / HistoryKit），避免在主应用内复制逻辑。
- 换算类功能若要接入 ConversionKit，需评估本地实现（功能完整、测试通过）与迁移收益后再决断。
# 开发指南

## 前端页面与路由

入口与路由表见 [api-reference.md](api-reference.md)。主要页面：
- `CalculatorView`（`/calculator`，初始）：计算器主界面。
- `HistoryView`（`/history`）：历史记录界面。
- `ConverterView`：单位换算界面（通过 `Navigator.push` 进入）。

> 路由使用见 API 参考「路由使用说明」的技术债注意点。

## 业务组件

- `ZenCalcButton`（`components/zen_calc_button.dart`）：封装 ZenUIKit `ZenButton`，按类型触发触觉/音频反馈。
- `ZenCalcDisplay`（`components/zen_calc_display.dart`）：三层显示屏，含切换动画与闪烁光标。

详见 [modules.md](modules.md) 通用组件一节。

## 主题与设计系统

### `AppTheme`（`config/theme/app_theme.dart`）

- 定义浅色「沙石庭院」与深色「夜间竹林」的颜色常量（向后兼容）。
- `lightTheme = SandGardenTheme.themeData()`，`darkTheme = BambooForestTheme.themeData()`（来自 ZenThemeKit）。

### 配色

| 主题 | 背景 | 文字 | 强调 |
|------|------|------|------|
| 浅色（沙石庭院） | `#E8E4DC` | `#3A3A3A` | `#7C9885` |
| 深色（夜间竹林） | `#2B2D2A` | `#E8E4DC` | `#8FA896` |

### 动画时序
- 按钮按压 150ms、阴影过渡 200ms、数字切换 300–400ms、主题切换 800ms。

## 扩展提示

- 新增按钮/显示：复用 `ZenCalcButton` / `ZenCalcDisplay`，保持反馈一致。
- 新增主题：扩展 `AppTheme` 复用 ZenThemeKit 预设与色彩常量，避免硬编码颜色（converter 模块的既有技术债应避免扩散）。
- 新增模块：参考 modules/calculator 的 views + widgets 结构组织文件。
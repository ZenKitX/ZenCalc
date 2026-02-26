# 阶段一：项目调研与准备

## 1. Neumorphic-Calculator 项目概述

### 项目特点
- 使用 Flutter 开发的计算器应用
- 采用 Neumorphic（新拟态）设计风格
- 支持深色/浅色主题切换
- 简洁现代的用户界面

### 参考项目
找到多个优秀的开源实现：
- [belelaritra/Neumorphic_Calculator](https://github.com/belelaritra/Neumorphic_Calculator)
- [codenameakshay/flutter-calculator](https://github.com/codenameakshay/flutter-calculator)
- [utkarsh-UK/neumorphic-calci](https://github.com/utkarsh-UK/neumorphic-calci)

## 2. Neumorphic 设计风格详解

### 核心设计原则
Neumorphic（新拟态）是 "new" + "skeuomorphism" 的组合，是一种介于扁平化设计和拟物化设计之间的风格。

### 关键特征
1. **柔和阴影**
   - 使用双阴影系统：一个浅色阴影 + 一个深色阴影
   - 浅色阴影在左上方，深色阴影在右下方
   - 创造出元素从背景中凸起或凹陷的效果

2. **统一背景色**
   - 元素与背景使用相同或相近的颜色
   - 通过阴影而非颜色对比来区分元素

3. **圆角设计**
   - 使用柔和的圆角边缘
   - 避免尖锐的直角

4. **两种效果**
   - **凸起（Embossed）**：元素看起来从背景中凸出
   - **凹陷（Debossed）**：元素看起来嵌入背景中

### 视觉效果
- 干净、现代、触感强
- 极简主义美学
- 3D 立体感但不过度

### 设计注意事项
- 低对比度可能影响可访问性
- 不宜过度使用阴影
- 需要与其他设计风格平衡使用

## 3. Flutter 技术栈

### 推荐的 Flutter 包
1. **flutter_neumorphic** - 完整的 Neumorphic UI 工具包
2. **neumorphic_container** - 可定制的 Neumorphic 容器
3. **clay_containers** - 另一个流行的 Neumorphic 实现

### 基础依赖
```yaml
dependencies:
  flutter:
    sdk: flutter
  # 可选：使用现成的 neumorphic 包
  # flutter_neumorphic: ^3.2.0
```

### 实现方式选择
**方案 A：使用现成的包**
- 优点：快速开发，功能完整
- 缺点：学习成本，可能过度依赖

**方案 B：手动实现（推荐）**
- 优点：完全掌控，深入理解原理
- 缺点：需要更多时间
- 使用 BoxDecoration 和 BoxShadow 实现

## 4. 核心功能规划

### 基础功能
- 数字输入（0-9）
- 基本运算（+、-、×、÷）
- 等号计算
- 清除功能（C、AC）
- 小数点支持

### UI 组件
- 显示屏（输入/结果显示）
- 数字按钮（0-9）
- 运算符按钮
- 功能按钮（清除、等号）

### 主题支持
- 浅色主题（推荐：#E0E5EC 背景色）
- 深色主题（推荐：#2E3239 背景色）

## 5. 颜色方案

### 浅色主题
- 背景色：`#E0E5EC` 或 `#F0F0F0`
- 阴影浅色：`#FFFFFF`
- 阴影深色：`#A3B1C6` 或 `#BEBEBE`
- 文字颜色：`#333333`
- 强调色：`#FF6B6B`（可选，用于运算符）

### 深色主题
- 背景色：`#2E3239` 或 `#292929`
- 阴影浅色：`#3A3F47`
- 阴影深色：`#1C1E22`
- 文字颜色：`#FFFFFF`
- 强调色：`#FF6B6B`

## 6. 项目结构规划

```
calculator/
├── lib/
│   ├── main.dart                 # 应用入口
│   ├── screens/
│   │   └── calculator_screen.dart # 计算器主界面
│   ├── widgets/
│   │   ├── neumorphic_button.dart # Neumorphic 按钮组件
│   │   └── display_screen.dart    # 显示屏组件
│   ├── utils/
│   │   └── calculator_logic.dart  # 计算逻辑
│   └── theme/
│       └── app_theme.dart         # 主题配置
└── docs/
    └── phase1_research.md         # 本文档
```

## 7. 下一步行动

### 阶段二准备工作
1. 确定是否使用现成的 neumorphic 包
2. 设计详细的 UI 布局草图
3. 准备颜色常量和主题配置
4. 创建基础的项目结构

### 技术决策
- ✅ 使用手动实现 Neumorphic 效果（更好的学习体验）
- ✅ 先实现浅色主题，后续添加深色主题
- ✅ 采用 StatefulWidget 管理计算器状态
- ✅ 使用 GridView 布局按钮

---

**调研完成时间**：2026-02-26
**下一阶段**：基础框架搭建

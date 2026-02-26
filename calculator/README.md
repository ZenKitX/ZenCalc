# Neumorphic Calculator

一个使用 Flutter 开发的精美计算器应用，采用 Neumorphic（新拟态）设计风格。

![Flutter](https://img.shields.io/badge/Flutter-3.38.5-blue)
![Dart](https://img.shields.io/badge/Dart-3.10.4-blue)
![License](https://img.shields.io/badge/License-MIT-green)

## ✨ 特性

### 核心功能
- ✅ 基础四则运算（加、减、乘、除）
- ✅ 小数运算支持
- ✅ 运算符优先级处理
- ✅ 连续计算功能
- ✅ 输入验证
- ✅ 错误处理（除零保护）
- ✅ 删除功能（退格）

### 设计特色
- 🎨 完整的 Neumorphic 设计风格
- 🌓 深色/浅色主题切换
- 💫 流畅的按压动画效果
- 📱 响应式布局适配
- 🎯 直观的用户界面

### 技术亮点
- 手动实现 Neumorphic 效果（无第三方依赖）
- 优化的阴影参数和透明度控制
- 智能的表达式解析算法
- 完善的状态管理

## 📸 截图

### 浅色主题
清新明亮，适合白天使用

### 深色主题
优雅低调，适合夜间使用

## 🚀 快速开始

### 环境要求
- Flutter SDK: 3.38.5 或更高
- Dart: 3.10.4 或更高

### 安装步骤

1. 克隆项目
```bash
git clone <repository-url>
cd calculator
```

2. 获取依赖
```bash
flutter pub get
```

3. 运行应用
```bash
# Windows
flutter run -d windows

# Web
flutter run -d chrome

# Android/iOS
flutter run
```

## 📁 项目结构

```
calculator/
├── lib/
│   ├── main.dart                      # 应用入口
│   ├── screens/
│   │   └── calculator_screen.dart     # 计算器主界面
│   ├── widgets/
│   │   ├── neumorphic_button.dart     # Neumorphic 按钮组件
│   │   ├── neumorphic_display.dart    # 显示屏组件
│   │   └── neumorphic_container.dart  # 通用容器组件
│   ├── utils/
│   │   └── calculator_logic.dart      # 计算逻辑
│   └── theme/
│       └── app_theme.dart             # 主题配置
├── docs/                              # 开发文档
│   ├── phase1_research.md             # 阶段一：项目调研
│   ├── phase2_framework.md            # 阶段二：基础框架
│   ├── phase3_ui_components.md        # 阶段三：UI 组件
│   ├── phase4_functionality.md        # 阶段四：功能实现
│   └── phase5_polish.md               # 阶段五：样式优化
└── README.md                          # 本文件
```

## 🎨 设计说明

### Neumorphic 设计原理

Neumorphic（新拟态）是一种介于扁平化和拟物化之间的设计风格，通过双阴影系统创造出元素从背景中凸起或凹陷的效果。

**核心特征：**
- 双阴影系统（浅色 + 深色）
- 统一的背景色
- 柔和的圆角
- 凸起/凹陷效果

**实现方式：**
```dart
BoxShadow(
  color: lightShadowDark.withOpacity(0.4),
  offset: Offset(6, 6),
  blurRadius: 12,
),
BoxShadow(
  color: lightShadowLight,
  offset: Offset(-6, -6),
  blurRadius: 12,
),
```

### 颜色方案

**浅色主题**
- 背景：`#E0E5EC`
- 文字：`#2C3E50`
- 强调色：`#E74C3C`

**深色主题**
- 背景：`#2C2F36`
- 文字：`#ECF0F1`
- 强调色：`#FF6B6B`

## 🔧 使用说明

### 基础操作
1. 点击数字按钮输入数字
2. 点击运算符按钮（+、-、×、÷）
3. 点击 `=` 计算结果
4. 点击 `C` 清除所有内容
5. 点击 `⌫` 删除最后一个字符

### 高级功能
- **连续计算**：计算结果后可以继续输入运算符进行计算
- **小数运算**：支持小数点输入和计算
- **主题切换**：点击右上角图标切换深浅主题

### 运算优先级
- 先计算乘除运算
- 再计算加减运算
- 示例：`2 + 3 × 4 = 14`（先算 3×4=12，再算 2+12=14）

## 📝 开发历程

项目采用循序渐进的开发方式，分为五个阶段：

1. **阶段一：项目调研与准备**
   - 研究 Neumorphic 设计风格
   - 分析技术栈和依赖
   - 规划项目结构

2. **阶段二：基础框架搭建**
   - 创建主题配置
   - 搭建应用结构
   - 实现 Neumorphic 容器组件

3. **阶段三：UI 组件开发**
   - 创建按钮组件
   - 构建数字键盘
   - 实现显示屏组件

4. **阶段四：功能实现**
   - 实现计算逻辑
   - 完善交互功能
   - 添加输入验证

5. **阶段五：样式完善**
   - 优化阴影效果
   - 实现主题切换
   - 响应式布局适配

详细的开发文档请查看 `docs/` 目录。

## 🧪 测试用例

### 基础运算
- `2 + 3 = 5` ✅
- `10 - 4 = 6` ✅
- `5 × 6 = 30` ✅
- `20 ÷ 4 = 5` ✅

### 混合运算
- `2 + 3 × 4 = 14` ✅
- `10 - 2 × 3 = 4` ✅
- `8 ÷ 2 + 3 = 7` ✅

### 小数运算
- `3.5 + 2.5 = 6` ✅
- `10.5 ÷ 2 = 5.25` ✅

### 边界情况
- `5 ÷ 0 = Error` ✅
- `0.1 + 0.2 = 0.3` ✅

## 🎯 未来计划

### 可能的增强功能
- [ ] 括号运算支持
- [ ] 百分比计算
- [ ] 历史记录功能
- [ ] 震动反馈
- [ ] 音效支持
- [ ] 科学计算器模式
- [ ] 横屏布局
- [ ] 键盘输入支持

## 📄 许可证

本项目采用 MIT 许可证。详见 [LICENSE](LICENSE) 文件。

## 🙏 致谢

- Flutter 团队提供的优秀框架
- Neumorphic 设计社区的灵感
- 所有开源贡献者

## 📧 联系方式

如有问题或建议，欢迎提交 Issue 或 Pull Request。

---

**开发时间**：2026-02-26  
**版本**：1.0.0  
**状态**：✅ 完成

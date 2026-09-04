# ZenCalc - 禅意计算器

一个融合禅意美学的 Flutter 计算器应用，采用 Neumorphic 设计风格，提供宁静、专注的计算体验。

![Flutter](https://img.shields.io/badge/Flutter-3.41+-blue)
![Dart](https://img.shields.io/badge/Dart-3.11+-blue)
![License](https://img.shields.io/badge/License-MIT-green)
![Version](https://img.shields.io/badge/Version-1.0.8-blue)

## ✨ 禅意特性

### 🎨 视觉设计
- **自然配色方案**
  - 浅色主题：温暖的沙石色调（禅宗庭院）
  - 深色主题：深竹绿灰色调（夜间竹林）
  - 强调色：柔和的竹绿色
- **极简主义界面**
  - 去除一切不必要的元素
  - 充足的留白空间
  - 单一焦点：计算本身
- **Neumorphic 设计**
  - 柔和的阴影效果
  - 自然的凸起/凹陷感

### 💫 流畅动画
- **缓慢、流畅的过渡**（200-800ms）
- **按钮交互**
  - 缩放动画（95% → 100%）
  - 阴影渐变效果
  - easeInOutCubic 曲线
- **数字变化**
  - 淡入淡出效果
  - 轻微滑动动画
  - 避免突兀跳变
- **主题切换**
  - 旋转淡入动画
  - 平滑的颜色过渡

### 🎯 交互体验
- **触觉反馈**
  - 数字按钮：轻柔震动（10ms）
  - 运算符：中等震动（15ms）
  - 等号/清除：强震动（20ms）
  - 主题切换：选择反馈（8ms）
- **音效系统**（可选）
  - 竹子敲击声（数字）
  - 水滴声（运算符）
  - 钟声（等号）
  - 风铃声（清除）
- **禅意语录**
  - 清除时：「放下执念，心自清明」
  - 计算时：「一即一切，一切即一」
  - 错误时：「错误亦是修行」
  - 特殊数字：「九九归一」「三生万物」
  - 30+ 条精选禅语
  - 智能触发机制
- **历史记录**
  - 自动保存计算历史
  - 统计信息（总计/今日/本周）
  - 滑动删除单条记录
  - 一键清除所有记录
  - 点击历史记录快速复用
  - 本地持久化存储

## 🚀 核心功能

### 基础计算
- ✅ 基础四则运算（+、-、×、÷）
- ✅ 小数运算支持
- ✅ 运算符优先级处理
- ✅ 连续计算功能
- ✅ 输入验证与错误处理
- ✅ 删除功能（退格）

### 科学计算（v1.0.3）
- ✅ 三角函数（sin, cos, tan）
- ✅ 反三角函数（sin⁻¹, cos⁻¹, tan⁻¹）
- ✅ 对数函数（log, ln）
- ✅ 幂运算（xʸ, √, x²）
- ✅ 括号支持（( )）
- ✅ 常数（π, e）
- ✅ 基础/科学模式一键切换
- ✅ 7行5列科学计算器布局
- ✅ inv 反函数模式
- ✅ deg 返回计算式功能（按钮已更名 ANS）
- ✅ RAD/DEG 角度模式（DEG 下 sin/cos/tan 按角度计算，asin/acos/atan 返回角度）

### 单位换算（v1.0.5 新增）
- ✅ 长度换算（8个单位）
- ✅ 面积换算（7个单位）
- ✅ 重量换算（8个单位）
- ✅ 温度换算（3个单位）
- ✅ 体积换算（7个单位）
- ✅ 速度换算（5个单位）
- ✅ 压强换算（7个单位）
- ✅ 功率换算（5个单位）
- ✅ 进制转换（4种进制）
- ✅ 实时换算
- ✅ 单位交换
- ✅ 智能键盘（进制转换支持 A-F）

### 禅意特性
- ✅ 深色/浅色主题切换
- ✅ 触觉反馈系统
- ✅ 禅意音效（可选）
- ✅ 禅意语录显示
- ✅ 历史记录功能
- ✅ 实时预览功能

## 📸 截图

### 浅色主题 - 沙石庭院
温暖的沙色背景，墨色文字，营造宁静的计算氛围

### 深色主题 - 夜间竹林
深竹绿灰背景，月光色文字，适合夜间专注使用

## 📥 下载安装

### 从 Release 下载
前往 [Releases 页面](https://cnb.cool/h1s97x/ZenKitX/ZenCalc/-/releases) 下载最新版本的 APK 文件。

### 从源码构建
参见下方"快速开始"部分。

## 🛠️ 快速开始

### 环境要求
- Flutter SDK: 3.41+ 或更高
- Dart: 3.11+ 或更高

### 安装步骤

1. 克隆项目
```bash
git clone https://cnb.cool/h1s97x/ZenKitX/ZenCalc.git
cd ZenCalc
```

2. 获取依赖
```bash
flutter pub get
```

3. 运行应用
```bash
flutter run
```

## 📁 项目结构

```
zen_calc/
├── lib/
│   ├── main.dart                      # 应用入口
│   └── app/
│       ├── components/                # 通用组件（按钮、显示屏）
│       ├── config/theme/              # 禅意主题与配色
│       ├── data/models/               # 数据模型（计算历史）
│       ├── domain/converter/          # 换算领域逻辑（单位、类别、算法、数据）
│       ├── modules/
│       │   ├── calculator/            # 计算器模块（基础 + 科学）
│       │   ├── converter/             # 单位换算模块（控制器与视图）
│       │   └── history/               # 历史记录模块
│       ├── routes/                    # GetX 路由配置
│       └── services/                  # 设置与历史持久化服务
├── test/                              # 单元测试与 Widget 测试
├── android/ ios/ web/ windows/ macos/ linux/   # 各平台工程
├── docs/                              # 集成与签名等文档
└── pubspec.yaml                       # 依赖与版本定义
```

## 🎨 禅意设计理念

### 配色哲学

**浅色主题 - 沙石庭院**
```dart
背景：#E8E4DC  // 温暖的沙色
文字：#3A3A3A  // 墨色
强调：#7C9885  // 竹绿
```

**深色主题 - 夜间竹林**
```dart
背景：#2B2D2A  // 深竹绿灰
文字：#E8E4DC  // 月光色
强调：#8FA896  // 浅竹绿
```

### 动画时序

- 按钮按压：150ms（快速响应）
- 阴影过渡：200ms（柔和变化）
- 数字切换：300-400ms（平静过渡）
- 主题切换：800ms（缓慢呼吸）

### 触觉设计

| 操作 | 震动时长 | 强度 | 寓意 |
|------|---------|------|------|
| 数字 | 10ms | 50 | 轻触竹叶 |
| 运算符 | 15ms | 80 | 敲击竹筒 |
| 等号 | 20ms | 120 | 木鱼声 |
| 清除 | 20ms | 120 | 拂去尘埃 |

## ⚙️ 设置选项

点击左上角设置图标可以调整：

- **触觉反馈**：开启/关闭震动反馈
- **禅意音效**：开启/关闭自然音效
- **禅意语录**：开启/关闭禅语显示

点击右上角历史图标可以查看计算历史。

## 🧘 使用建议

1. **专注模式**：关闭通知，开启触觉反馈，享受纯粹的计算体验
2. **夜间使用**：切换到深色主题，降低屏幕亮度
3. **静音环境**：关闭音效，只保留触觉反馈
4. **冥想计算**：感受每次按键的反馈，专注于当下

## 🔧 技术亮点

- **ZenKitX 包生态**：核心能力拆分为独立包（ArithmeticKit、ZenUIKit、ZenThemeKit、ZenQuoteKit、FeedbackKit、HistoryKit），职责清晰、可独立复用
- **性能优化**：使用 AnimationController 和 SingleTickerProviderStateMixin
- **智能降级**：触觉反馈在不支持的设备上自动降级到系统反馈
- **状态管理**：GetX 路由 + 视图层状态管理
- **响应式设计**：适配不同屏幕尺寸

## 📝 开发历程

### 第一阶段：禅意设计实现
1. ✅ 自然配色方案（沙石、竹林）
2. ✅ 流畅动画过渡（缩放、淡入淡出）
3. ✅ 极简界面布局（去除冗余元素）

### 第二阶段：交互体验优化
4. ✅ 触觉反馈系统（分级震动）
5. ✅ 音效系统框架（可扩展）
6. ✅ 设置对话框（用户控制）

### 第三阶段：禅意功能增强
7. ✅ 禅语系统（30+ 条语录）
8. ✅ 历史记录功能（自动保存、统计）

### 第四阶段：科学计算功能（v1.0.3-v1.0.4）
9. ✅ 科学计算逻辑引擎
10. ✅ 科学计算器UI（7行5列布局）
11. ✅ 基础/科学模式切换
12. ✅ 三角函数、对数、幂运算支持
13. ✅ 反函数模式（inv）
14. ✅ 实时预览功能
15. ✅ 现代化显示区域设计

### 第五阶段：单位换算功能（v1.0.5）
16. ✅ 9大换算类别（长度、面积、重量、温度、体积、速度、压强、功率、进制）
17. ✅ 60+单位支持
18. ✅ 实时换算系统
19. ✅ 智能键盘（进制转换支持 A-F）
20. ✅ 单位交换功能
21. ✅ 完整的单元测试

### 未来计划
- [ ] 汇率换算（需要 API）
- [ ] 房贷计算器
- [ ] 呼吸模式动画（待机时）
- [ ] 手势操作（左滑清除、长按复制）
- [ ] 专注模式（隐藏历史）
- [ ] 自定义音效文件
- [ ] 国际化支持

## 📄 许可证

本项目采用 **MIT 许可证** 开源，详见 [LICENSE](LICENSE) 文件。

- ✅ 允许商业使用、修改、分发和私人使用
- ✅ 允许闭源再分发（需保留版权声明和许可声明）
- ✅ 提供“按现状”分发，不附带任何明示或默示的担保
- 📄 完整条款请参阅仓库根目录的 [LICENSE](LICENSE) 文件

```text
MIT License

Copyright (c) 2026 H1S97X

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## 🙏 致谢

- Flutter 团队
- Neumorphic 设计社区
- 禅宗美学的启发

---

**项目名称**：ZenCalc  
**开发时间**：2026-02-26  
**当前版本**：1.0.8  
**许可证**：[MIT](LICENSE)  
**理念**：在计算中寻找宁静

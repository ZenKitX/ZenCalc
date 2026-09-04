# ZenCalc 代码 Wiki（Code Wiki）

> 本 Wiki 是对 ZenCalc 项目的结构化代码说明，涵盖整体架构、模块职责、依赖关系、数据流与运行方式，帮助开发者快速理解代码库。

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

## 文档导航

本 Wiki 按主题拆分为多个页面，从对应章节定位内容：

| 页面 | 对应原章节 | 说明 |
|------|-----------|------|
| [架构（architecture.md）](architecture.md) | 3、4、10、11.3 | 分层架构、目录结构、核心数据流 |
| [模块职责（modules.md）](modules.md) | 6、7、8 | 计算器/换算/历史模块、服务层、通用组件 |
| [API 参考（api-reference.md）](api-reference.md) | 5、7 | 入口流程、路由表、服务层接口、数据模型 |
| [依赖关系（dependencies.md）](dependencies.md) | 2、11 | 技术栈、外部依赖、内部领域包 |
| [设计决策（design-decisions.md）](design-decisions.md) | 3.2、15 | 包集成决策、技术债、扩展约定 |
| [开发指南（development.md）](development.md) | 5、8、9 | 前端页面路由、业务组件、主题设计系统 |
| [测试（testing.md）](testing.md) | 12 | 测试体系与注意事项 |
| [运行方式（usage.md）](usage.md) | 13 | 环境要求、运行与构建步骤 |
| [CI/CD（ci-cd.md）](ci-cd.md) | 14 | 流水线与发布、签名 |

---

## 参考文档

- `README.md`：使用说明、功能清单、设计理念
- `docs/INTEGRATION_STATUS.md`：包集成状态与决策
- `docs/package_refactoring_todo.md`：包拆分演进史（7 个领域包）
- `docs/SETUP_SIGNING.md`、`docs/SIGNING.md`：应用签名配置
- `design/icon_philosophy.md`：应用图标设计哲学
- `CHANGELOG.md`：版本演进记录
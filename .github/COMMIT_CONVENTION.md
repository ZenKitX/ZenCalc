# Git 提交规范

## 核心原则

### 1. 清晰明确 (Clear and Concise)
提交信息应该清楚地说明"做了什么"以及"为什么这么做"。避免模糊不清或过于宽泛的描述。

### 2. 原子性 (Atomic)
每次提交应该只包含一个逻辑上的变更。例如，修复一个 bug 和添加一个新功能应该分成两次提交，而不是混在一起。这使得代码审查、回滚和问题排查变得更加容易。

### 3. 格式化 (Structured)
采用统一的格式，可以方便工具解析和生成 CHANGELOG。

## 提交信息格式

```
<类型>(<范围>): <简短描述>

[可选的详细描述]

[可选的 Footer]
```

### 第一行：标题行

- **类型**（必需）：说明提交的类别
- **范围**（可选）：说明提交影响的范围
- **简短描述**（必需）：简明扼要地描述变更内容
- 整行不超过 50 个字符（中文约 25 个字符）
- 使用现在时态："添加功能" 而非 "添加了功能"

### 详细描述（可选）

- 与标题行之间空一行
- 详细说明变更的原因、解决的问题、实现方式等
- 每行不超过 72 个字符
- 可以分多个段落

### Footer（可选）

- 不兼容变更：`Breaking Change: 描述`
- 关闭 Issue：`Closes #123`
- 相关 Issue：`Refs #456`

## 提交类型

| 类型 | 说明 | 示例 |
|------|------|------|
| `feat` | 新功能 | `feat(calculator): 添加科学计算器支持` |
| `fix` | 修复 bug | `fix(parser): 修复括号匹配错误` |
| `docs` | 文档变更 | `docs(readme): 更新安装说明` |
| `style` | 代码格式（不影响代码运行） | `style: 统一代码缩进为 2 空格` |
| `refactor` | 重构 | `refactor(lexer): 简化 token 识别逻辑` |
| `perf` | 性能优化 | `perf(calculator): 优化表达式求值算法` |
| `test` | 添加或修改测试 | `test(calculator): 添加边界条件测试` |
| `chore` | 构建过程或辅助工具的变动 | `chore: 更新依赖版本` |
| `build` | 影响构建系统或外部依赖 | `build: 升级 Dart SDK 到 3.0` |
| `ci` | CI 配置文件和脚本的变更 | `ci: 添加自动化测试流程` |

## 范围示例

根据项目结构，常用的范围包括：

- `calculator` - 计算器相关
- `parser` - 解析器
- `lexer` - 词法分析器
- `expression` - 表达式处理
- `test` - 测试相关
- `docs` - 文档
- `deps` - 依赖管理

## 提交示例

### 示例 1：添加新功能

```
feat(calculator): 添加科学计算器支持

- 实现三角函数计算（sin, cos, tan）
- 添加对数和指数运算
- 支持数学常量 π 和 e

这个功能扩展了基础计算器的能力，满足了用户对科学计算的需求。

Closes #42
```

### 示例 2：修复 bug

```
fix(parser): 修复负数解析错误

修复了当负号出现在表达式开头时无法正确解析的问题。
现在 "-5 + 3" 可以正确计算为 -2。

Fixes #58
```

### 示例 3：文档更新

```
docs(readme): 更新快速开始指南

添加了更详细的安装步骤和使用示例，帮助新用户快速上手。
```

### 示例 4：重构代码

```
refactor(lexer): 简化 token 识别逻辑

使用 switch 表达式替代 if-else 链，提高代码可读性。
功能保持不变，但代码更简洁易维护。
```

### 示例 5：不兼容变更

```
feat(api): 重新设计计算器 API

BREAKING CHANGE: Calculator.evaluate() 现在返回 Result<double>
而不是直接返回 double，以便更好地处理错误情况。

迁移指南：
- 旧代码：double result = calculator.evaluate(expr);
- 新代码：double result = calculator.evaluate(expr).value;

Closes #75
```

## 最佳实践

1. **提交前检查**
   - 运行测试确保代码正常工作
   - 使用 `git diff` 检查变更内容
   - 确保只包含相关的变更

2. **保持提交小而频繁**
   - 完成一个小功能就提交
   - 不要等到完成大量工作才提交
   - 便于代码审查和问题定位

3. **使用提交模板**
   - 配置 Git 使用项目的提交模板
   - 运行：`git config commit.template .gitmessage`

4. **编写有意义的描述**
   - 避免：`fix bug`、`update code`
   - 推荐：`fix(parser): 修复除零错误处理`

5. **关联 Issue**
   - 在提交信息中引用相关的 Issue
   - 使用 `Closes #123` 自动关闭 Issue

## 工具支持

### 配置提交模板

```bash
git config commit.template .gitmessage
```

### 使用 commitlint（可选）

安装 commitlint 来自动检查提交信息格式：

```bash
npm install --save-dev @commitlint/cli @commitlint/config-conventional
```

### 生成 CHANGELOG

使用 conventional-changelog 自动生成变更日志：

```bash
npm install --save-dev conventional-changelog-cli
```

## 参考资源

- [Conventional Commits](https://www.conventionalcommits.org/)
- [Angular Commit Guidelines](https://github.com/angular/angular/blob/master/CONTRIBUTING.md#commit)
- [How to Write a Git Commit Message](https://chris.beams.io/posts/git-commit/)

# ZenCalc 包拆分 TODO 清单

**更新日期**: 2026-03-06  
**状态**: 进行中

---

## ✅ 已完成的包

### 1. ArithmeticKit v0.3.0 ✓
- [x] 创建包结构
- [x] 实现 BasicCalculator
- [x] 实现 ScientificCalculator
- [x] 实现 ExpressionCalculator（自定义表达式树系统）
- [x] 实现 Lexer（词法分析器）
- [x] 实现 Parser（Shunting Yard 算法）
- [x] 支持变量和函数（sin, cos, tan, ln, log, sqrt, abs, ceil, floor, exp）
- [x] 表达式简化功能
- [x] 编写 60+ 测试用例
- [x] 创建完整文档（API.md, ARCHITECTURE.md, QUICK_REFERENCE.md）
- [x] 零外部依赖
- [x] 所有测试通过
- [ ] 发布到 pub.dev

### 2. ConversionKit v0.2.0 ✓
- [x] 创建包结构
- [x] 实现单位转换器（长度、重量、温度等）
- [x] 实现货币转换器
- [x] 实现房贷计算器
- [x] 重构目录结构（从 6 个目录优化到 4 个）
- [x] 添加 200+ 边界测试用例
- [x] 创建完整文档（API.md, EDGE_CASES_TESTING.md）
- [x] 180/188 测试通过（95.7%）
- [ ] 修复 8 个边界测试失败
- [ ] 发布到 pub.dev

### 3. ZenUIKit v0.2.0 ✓
- [x] 创建包结构
- [x] 实现 InheritedWidget 主题系统
- [x] 实现 ZenTheme（主题管理）
- [x] 实现 ZenColors（颜色系统）
- [x] 实现 ZenTypography（字体系统）
- [x] 实现 ZenSpacing（间距系统）
- [x] 实现 ZenShadows（阴影系统）
- [x] 实现 ZenButton 组件
- [x] 实现 ZenContainer 组件
- [x] 实现 ZenDisplay 组件
- [x] 重构所有组件使用 ZenTheme.of(context)
- [x] 创建示例应用
- [x] 编写 37 个测试用例（全部通过）
- [x] 创建完整文档（README.md, ARCHITECTURE.md, CHANGELOG.md）
- [x] 修复所有弃用警告
- [x] flutter analyze - 0 错误
- [x] flutter pub publish --dry-run - 通过
- [x] 集成到主项目
- [x] 创建 ZenCalcButton 和 ZenCalcDisplay 包装组件
- [x] 替换所有旧的 Neumorphic 组件
- [ ] 发布到 pub.dev

### 4. ZenQuoteKit v0.1.0 ✓
- [x] 创建包结构
- [x] 实现 ZenQuote 模型
- [x] 实现 ZenContext 模型
- [x] 实现 ZenQuoteService（禅语服务）
- [x] 实现 ZenQuoteWidget（禅语显示组件）
- [x] 实现 ZenQuoteOverlay（禅语浮层组件）
- [x] 添加多语言支持（中文、英文、日文）
- [x] 添加 99 条禅语（每种语言 33 条）
- [x] 按语言组织禅语数据
- [x] 创建示例应用（带语言切换器）
- [x] 编写服务测试（15/15 通过）
- [x] 创建完整文档
- [ ] 修复 Widget 测试的 Timer 清理问题
- [ ] 集成到主项目
- [ ] 发布到 pub.dev

---

## 🎯 下一步：集成和发布

### Phase 1: ZenQuoteKit 集成（优先级：高）

#### 1.1 集成到主项目 ✅ COMPLETE
- [x] 在 `pubspec.yaml` 中添加 ZenQuoteKit 依赖
- [x] 更新 calculator_view.dart 导入
- [x] 替换本地 ZenQuoteService 为 ZenQuoteKit 服务
- [x] 替换本地 ZenQuoteWidget 为 ZenQuoteKit 组件
- [x] 删除旧的本地实现
- [x] 在适当的位置显示禅语（计算完成后、错误发生时、清除时）
- [x] 根据计算上下文选择合适的禅语类型
- [x] 添加禅语显示的触发逻辑（概率控制）
- [x] 测试禅语显示动画
- [x] 验证 flutter analyze 无错误
- [x] 创建集成文档

#### 1.2 用户设置 ✅ COMPLETE
- [x] 添加禅语开关设置（UI 已有，需持久化）
- [x] 添加禅语显示频率设置
- [x] 添加语言选择设置（中文、英文、日文）
- [x] 保存用户偏好到 SharedPreferences
- [x] 从 SharedPreferences 加载用户偏好
- [x] 将语言参数传递给 ZenQuoteService
- [x] 测试多语言支持

### Phase 2: 包发布准备（优先级：高）

#### 2.1 ArithmeticKit 发布准备
- [ ] 检查 README.md 完整性
- [ ] 检查 CHANGELOG.md 格式
- [ ] 检查 LICENSE 文件
- [ ] 检查 pubspec.yaml 元数据
- [ ] 添加示例代码到 example/
- [ ] 运行 `flutter pub publish --dry-run`
- [ ] 修复所有警告
- [ ] 发布到 pub.dev

#### 2.2 ConversionKit 发布准备
- [ ] 修复 8 个边界测试失败
- [ ] 检查 README.md 完整性
- [ ] 检查 CHANGELOG.md 格式
- [ ] 检查 LICENSE 文件
- [ ] 检查 pubspec.yaml 元数据
- [ ] 添加示例代码到 example/
- [ ] 运行 `flutter pub publish --dry-run`
- [ ] 修复所有警告
- [ ] 发布到 pub.dev

#### 2.3 ZenUIKit 发布准备
- [ ] 检查 README.md 完整性（已有）
- [ ] 检查 CHANGELOG.md 格式（已有）
- [ ] 检查 LICENSE 文件
- [ ] 检查 pubspec.yaml 元数据（已检查）
- [ ] 示例应用已完成
- [ ] 已通过 `flutter pub publish --dry-run`
- [ ] 发布到 pub.dev

#### 2.4 ZenQuoteKit 发布准备
- [ ] 修复 Widget 测试的 Timer 清理问题
- [ ] 检查 README.md 完整性
- [ ] 检查 CHANGELOG.md 格式
- [ ] 检查 LICENSE 文件
- [ ] 检查 pubspec.yaml 元数据
- [ ] 示例应用已完成
- [ ] 运行 `flutter pub publish --dry-run`
- [ ] 修复所有警告
- [ ] 发布到 pub.dev

---

## 📦 待开发的包

### Phase 3: FeedbackKit 开发（优先级：中）✅ COMPLETE

#### 3.1 包结构设计 ✅
- [x] 创建包目录结构
- [x] 设计 API 接口
- [x] 编写 pubspec.yaml
- [x] 创建 README.md

#### 3.2 触觉反馈功能 ✅
- [x] 实现 HapticService
- [x] 支持轻度触觉反馈（light）
- [x] 支持中度触觉反馈（medium）
- [x] 支持重度触觉反馈（heavy）
- [x] 支持自定义触觉模式
- [x] 添加触觉开关控制

#### 3.3 音频反馈功能 ✅
- [x] 实现 AudioService
- [x] 添加点击音效
- [x] 添加成功音效
- [x] 添加错误音效
- [x] 实现音频预加载
- [x] 实现音频缓存
- [x] 添加音量控制
- [x] 添加音频开关控制

#### 3.4 测试和文档 ✅
- [x] 编写单元测试
- [x] 编写集成测试
- [x] 创建示例应用
- [x] 编写 API 文档
- [x] 编写使用指南

#### 3.5 集成和发布 ✅ COMPLETE
- [x] 集成到主项目
- [x] 替换现有的触觉和音频代码
- [x] 测试所有功能
- [ ] 发布到 pub.dev

### Phase 4: HistoryKit 开发（优先级：低）✅ COMPLETE

#### 4.1 包结构设计 ✅
- [x] 创建包目录结构
- [x] 设计 API 接口
- [x] 编写 pubspec.yaml
- [x] 创建 README.md

#### 4.2 历史记录管理 ✅
- [x] 实现 HistoryItem 模型
- [x] 实现 HistoryService
- [x] 实现添加历史记录
- [x] 实现获取历史记录
- [x] 实现删除历史记录
- [x] 实现清空历史记录
- [x] 实现搜索功能
- [x] 实现过滤功能

#### 4.3 本地持久化 ✅
- [x] 实现 StorageService
- [x] 使用 SharedPreferences
- [x] 实现数据序列化
- [x] 实现数据反序列化
- [x] 实现数据迁移

#### 4.4 UI 组件
- [ ] 实现 HistoryList 组件
- [ ] 实现 HistoryItemWidget 组件
- [ ] 实现分页加载
- [ ] 实现下拉刷新
- [ ] 实现滑动删除

#### 4.5 统计分析 ✅
- [x] 实现使用频率统计
- [x] 实现时间分布统计
- [x] 实现类型分布统计
- [x] 实现数据导出功能

#### 4.6 测试和文档 ✅
- [x] 编写单元测试
- [x] 编写 Widget 测试
- [x] 编写集成测试
- [x] 创建示例应用
- [x] 编写 API 文档
- [x] 编写使用指南

#### 4.7 集成和发布 ✅ COMPLETE
- [x] 集成到主项目
- [x] 替换现有的历史记录代码
- [x] 测试所有功能
- [ ] 发布到 pub.dev

---

## 🔧 主项目优化

### 代码清理
- [x] 删除旧的 Neumorphic 组件文件
- [ ] 清理未使用的导入
- [ ] 清理未使用的资源文件
- [ ] 统一代码风格

### 测试覆盖
- [ ] 为主项目添加单元测试
- [ ] 为主项目添加 Widget 测试
- [ ] 为主项目添加集成测试
- [ ] 提高测试覆盖率到 80%+

### 文档更新
- [x] 更新项目架构文档
- [x] 更新包集成文档
- [ ] 创建用户使用指南
- [ ] 创建开发者贡献指南

### CI/CD 配置
- [ ] 将 CI/CD 配置移到项目根目录
- [ ] 配置自动化测试
- [ ] 配置自动化构建
- [ ] 配置自动化发布

---

## 📊 进度总结

### 已完成
- ✅ ArithmeticKit v0.3.0（功能完成，待发布）
- ✅ ConversionKit v0.2.0（功能完成，待修复测试）
- ✅ ZenUIKit v0.2.0（功能完成，已集成，待发布）
- ✅ ZenThemeKit v0.1.0（功能完成，已集成，待发布）
- ✅ ZenQuoteKit v0.1.0（功能完成，已集成，待发布）
- ✅ ZenQuoteKit 集成到主项目（Phase 1.1 & 1.2 完成）
- ✅ FeedbackKit v0.1.0（功能完成，已集成，待发布）
- ✅ HistoryKit v0.1.0（功能完成，已集成，待发布）

### 进行中
- 🔄 包发布准备工作

### 待开始
- 无

### 完成度
- 核心包开发：100% (7/7) ✅
- 包集成：100% (7/7) ✅
- 包发布：0% (0/7)
- 可选包开发：100% (1/1) ✅

---

## 🎯 近期目标（1-2 周）

1. **ZenQuoteKit 集成**（3-5 天）
   - 集成到主项目
   - 添加用户设置
   - 测试所有功能

2. **包发布准备**（3-5 天）
   - 修复 ConversionKit 测试
   - 修复 ZenQuoteKit Widget 测试
   - 完善所有包的文档
   - 运行发布前检查

3. **发布到 pub.dev**（2-3 天）
   - ArithmeticKit v0.3.0
   - ConversionKit v0.2.0
   - ZenUIKit v0.2.0
   - ZenQuoteKit v0.1.0

---

## 📝 注意事项

### 发布前检查清单
- [ ] 所有测试通过
- [ ] 文档完整（README, CHANGELOG, LICENSE）
- [ ] 示例代码可运行
- [ ] pubspec.yaml 元数据完整
- [ ] flutter analyze 无错误
- [ ] flutter pub publish --dry-run 通过
- [ ] 版本号符合语义化版本规范

### 版本管理
- 使用语义化版本（Semantic Versioning）
- 主版本号：不兼容的 API 变更
- 次版本号：向后兼容的功能新增
- 修订号：向后兼容的问题修正

### 社区维护
- 及时响应 GitHub Issues
- 及时响应 Pull Requests
- 定期更新依赖
- 定期发布新版本

---

**最后更新**: 2026-03-06  
**维护者**: ZenCalc Team

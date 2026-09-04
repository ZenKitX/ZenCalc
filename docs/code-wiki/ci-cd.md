# CI/CD

配置文件：`.cnb.yml`（CNB 流水线）。

| 触发 | 阶段动作 |
|------|---------|
| `push` | 同步到 GitHub 镜像 + CI（`flutter pub get` → `flutter analyze` → `flutter test`） |
| `tag_push` | 构建多平台产物（APK/AAB/Web/Linux）+ 创建 Release + 上传附件 |
| `issue.open/reopen` | 自动指派给 h1s97x |
| `pull_request` | 自动指派 reviewer + CI |

**签名**：`tag_push` 时若有 `KEYSTORE_BASE64` 环境变量则注入签名；未配置则使用 debug 签名（详见 `docs/SETUP_SIGNING.md`、`docs/SIGNING.md`）。
# 运行方式

## 环境要求

- Flutter SDK **3.41+**、Dart **3.11+**。

## 获取依赖并运行

```bash
# 1. 克隆
git clone https://cnb.cool/h1s97x/ZenKitX/ZenCalc.git
cd ZenCalc

# 2. 获取依赖（Git 领域包会从 GitHub 拉取）
flutter pub get

# 3. 运行（默认占用格式选择设备）
flutter run

# 4. 指定平台
flutter run -d android   # Android
flutter run -d chrome    # Web
flutter run -d linux     # Linux 桌面
```

## 构建

```bash
# APK（发布）
flutter build apk --release

# App Bundle（上架 Google Play）
flutter build appbundle --release

# Web
flutter build web --release

# Linux 桌面
flutter build linux --release
```

## 使用本地领域包开发

将 `pubspec.yaml` 中的 git 依赖切换为 `pubspec_local.yaml` 的 `path:` 形式，链接本地 `packages/` 目录。

## 环境变量配置

应用主要依赖各平台工程配置（如 `shared_preferences` 需在 iOS 编译时通过 `--no-tree-shake-icons` 等处理），核心设置通过 `lib/app/services/zen_settings_service.dart` 在 SharedPreferences 中持久化，无需额外 `.env` 文件。
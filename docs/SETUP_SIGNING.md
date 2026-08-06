# 应用签名配置指南

本文档提供详细的步骤来配置 ZenCalc 的应用签名。

## 前提条件

- 已安装 Java JDK
- 已安装 Flutter SDK
- 有权限访问项目的 Android 配置

## 步骤 1：生成签名密钥

### 在本地生成密钥库

```bash
keytool -genkey -v -keystore ~/zencalc-release-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias zencalc
```

### 填写信息

系统会提示输入以下信息：

```
Enter keystore password: [输入密码，至少6个字符]
Re-enter new password: [再次输入密码]
What is your first and last name?
  [CN]: ZenKitX
What is the name of your organizational unit?
  [OU]: Development
What is the name of your organization?
  [O]: ZenKitX
What is the name of your City or Locality?
  [L]: [你的城市]
What is the name of your State or Province?
  [ST]: [你的省份]
What is the two-letter country code for this unit?
  [C]: CN
Is CN=ZenKitX, OU=Development, O=ZenKitX, L=[城市], ST=[省份], C=CN correct?
  [no]: yes

Enter key password for <zencalc>
  (RETURN if same as keystore password): [直接回车或输入不同密码]
```

### 重要提示

⚠️ **请妥善保管以下信息：**
- 密钥库文件：`~/zencalc-release-key.jks`
- 密钥库密码
- 密钥别名：`zencalc`
- 密钥密码（如果与密钥库密码不同）

**如果丢失这些信息，将无法更新已发布的应用！**

## 步骤 2：配置本地签名

### 2.1 创建 key.properties 文件

在 `android/` 目录下创建 `key.properties` 文件：

```bash
cd android
touch key.properties
```

### 2.2 编辑 key.properties

添加以下内容（替换为你的实际信息）：

```properties
storePassword=你的密钥库密码
keyPassword=你的密钥密码
keyAlias=zencalc
storeFile=C:/Users/你的用户名/zencalc-release-key.jks
```

**Windows 路径示例：**
```properties
storeFile=C:/Users/YourName/zencalc-release-key.jks
```

**macOS/Linux 路径示例：**
```properties
storeFile=/Users/yourname/zencalc-release-key.jks
```

### 2.3 更新 .gitignore

确保 `key.properties` 不会被提交到 Git：

```bash
# 在项目根目录的 .gitignore 中已包含
android/key.properties
```

## 步骤 3：配置 Gradle

### 3.1 编辑 android/app/build.gradle.kts

在文件开头添加（在 `plugins` 块之前）：

```kotlin
// 加载签名配置
val keystorePropertiesFile = rootProject.file("key.properties")
val keystoreProperties = java.util.Properties()
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(java.io.FileInputStream(keystorePropertiesFile))
}
```

### 3.2 添加 signingConfigs

在 `android {` 块内，`buildTypes` 之前添加：

```kotlin
signingConfigs {
    create("release") {
        keyAlias = keystoreProperties["keyAlias"] as String
        keyPassword = keystoreProperties["keyPassword"] as String
        storeFile = file(keystoreProperties["storeFile"] as String)
        storePassword = keystoreProperties["storePassword"] as String
    }
}
```

### 3.3 更新 buildTypes

在 `release {` 块中添加：

```kotlin
buildTypes {
    release {
        signingConfig = signingConfigs.getByName("release")
        // ... 其他配置
    }
}
```

## 步骤 4：测试签名

### 构建签名 APK

```bash
flutter build apk --release
```

### 验证签名

```bash
jarsigner -verify -verbose -certs build/app/outputs/flutter-apk/app-release.apk
```

应该看到：
```
jar verified.
```

### 查看签名信息

```bash
keytool -printcert -jarfile build/app/outputs/flutter-apk/app-release.apk
```

## 步骤 5：配置 CNB 流水线自动签名（规划中）

> ⚠️ **状态说明**：当前 `release` 构建类型仍使用 `signingConfigs.getByName("debug")`（即 debug 签名），**CNB 流水线自动签名尚未启用**。以下为规划方案，待密钥配置就绪后再落地。
> 说明：ZenCalc 的 CI/CD 已迁移到 CNB 流水线（`.cnb.yml`），不再使用 GitHub Actions。
> 打 `v*` 标签时会自动构建 release APK 并发布 Release。

### 5.1 准备密钥库的 Base64 编码

```bash
# Windows (PowerShell)
[Convert]::ToBase64String([IO.File]::ReadAllBytes("C:\Users\YourName\zencalc-release-key.jks")) | Out-File zencalc-key.base64

# macOS/Linux
base64 ~/zencalc-release-key.jks > zencalc-key.base64
```

### 5.2 配置 CNB 密钥仓库

在 CNB 的密钥仓库（如 `h1s97x/secret-env`）的 `env.yml` 中配置以下变量：

| Name | Value |
|------|-------|
| `KEYSTORE_BASE64` | zencalc-key.base64 文件的内容 |
| `KEYSTORE_PASSWORD` | 你的密钥库密码 |
| `KEY_ALIAS` | `zencalc` |
| `KEY_PASSWORD` | 你的密钥密码 |

### 5.3 在 `.cnb.yml` 发布流水线中启用签名（规划中）

> ⚠️ 此步骤尚未在 `.cnb.yml` 中落地，待密钥配置就绪后启用。

在 `tag_push` 流水线的 `build apk` 阶段之前，将密钥注入构建环境：

```yaml
- name: setup keystore
  script: |
    echo "$KEYSTORE_BASE64" | base64 -d > android/app/keystore.jks
    echo "storePassword=$KEYSTORE_PASSWORD" > android/key.properties
    echo "keyPassword=$KEY_PASSWORD" >> android/key.properties
    echo "keyAlias=$KEY_ALIAS" >> android/key.properties
    echo "storeFile=keystore.jks" >> android/key.properties
- name: build apk
  script: flutter build apk --release
```

同时在 `tag_push` 流水线添加密钥仓库 imports：

```yaml
imports:
  - https://cnb.cool/h1s97x/secret-env/-/blob/main/env.yml
```

## 常见问题

### Q: 忘记密钥库密码怎么办？
A: 无法恢复。需要生成新的密钥库，但这意味着无法更新已发布的应用，只能发布新应用。

### Q: 可以在多台电脑上使用同一个密钥库吗？
A: 可以。将 `.jks` 文件和密码安全地复制到其他电脑即可。

### Q: 密钥库文件应该备份吗？
A: **必须备份！** 建议：
- 加密后存储在云端
- 保存在安全的物理位置
- 使用密码管理器保存密码

### Q: 如何更改密钥库密码？
A: 使用 keytool 命令：
```bash
keytool -storepasswd -keystore ~/zencalc-release-key.jks
```

## 安全建议

1. ✅ 永远不要将 `key.properties` 或 `.jks` 文件提交到 Git
2. ✅ 定期备份密钥库文件
3. ✅ 使用强密码（至少12个字符，包含大小写字母、数字、符号）
4. ✅ 将密码保存在密码管理器中
5. ✅ 限制密钥库文件的访问权限

## 下一步

配置完成后，你可以：
1. 构建签名的 release APK
2. 上传到 Google Play Console
3. 打 `v*` 标签，通过 CNB 流水线自动构建和发布

参考 [SIGNING.md](./SIGNING.md) 了解更多详细信息。

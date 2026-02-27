# Android 应用签名配置

本文档说明如何为 ZenCalc 配置应用签名，以便发布到 Google Play 或分发 APK。

## 生成签名密钥

1. 创建密钥库文件：

```bash
keytool -genkey -v -keystore ~/zencalc-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias zencalc
```

2. 按提示输入信息：
   - 密钥库密码（请妥善保管）
   - 姓名、组织等信息
   - 密钥密码（可以与密钥库密码相同）

## 配置签名

1. 创建 `android/key.properties` 文件（不要提交到 Git）：

```properties
storePassword=你的密钥库密码
keyPassword=你的密钥密码
keyAlias=zencalc
storeFile=/path/to/zencalc-key.jks
```

2. 更新 `android/app/build.gradle.kts`：

在 `android {` 块之前添加：

```kotlin
val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}
```

在 `buildTypes {` 块之前添加：

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

在 `release {` 块中添加：

```kotlin
signingConfig = signingConfigs.getByName("release")
```

## GitHub Actions 配置

如果要在 GitHub Actions 中自动签名，需要：

1. 将密钥库文件转换为 Base64：

```bash
base64 ~/zencalc-key.jks > zencalc-key.jks.base64
```

2. 在 GitHub 仓库设置中添加 Secrets：
   - `KEYSTORE_BASE64`: 密钥库文件的 Base64 内容
   - `KEYSTORE_PASSWORD`: 密钥库密码
   - `KEY_ALIAS`: 密钥别名（zencalc）
   - `KEY_PASSWORD`: 密钥密码

3. 更新 `.github/workflows/release.yml`，在构建前添加：

```yaml
- name: Decode Keystore
  run: |
    echo "${{ secrets.KEYSTORE_BASE64 }}" | base64 -d > android/app/keystore.jks
    echo "storePassword=${{ secrets.KEYSTORE_PASSWORD }}" > android/key.properties
    echo "keyPassword=${{ secrets.KEY_PASSWORD }}" >> android/key.properties
    echo "keyAlias=${{ secrets.KEY_ALIAS }}" >> android/key.properties
    echo "storeFile=keystore.jks" >> android/key.properties
```

## 构建签名 APK

配置完成后，运行：

```bash
flutter build apk --release
```

签名的 APK 将生成在 `build/app/outputs/flutter-apk/app-release.apk`

## 安全提示

⚠️ **重要**：
- 不要将 `key.properties` 和 `.jks` 文件提交到 Git
- 妥善保管密钥库文件和密码
- 定期备份密钥库文件
- 如果密钥丢失，将无法更新已发布的应用

## 验证签名

验证 APK 是否已签名：

```bash
jarsigner -verify -verbose -certs build/app/outputs/flutter-apk/app-release.apk
```

查看签名信息：

```bash
keytool -printcert -jarfile build/app/outputs/flutter-apk/app-release.apk
```

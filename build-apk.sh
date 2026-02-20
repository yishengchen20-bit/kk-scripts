# 📱 理财助手APK构建说明

本指南将帮助您将理财助手Web应用打包成可安装的Android APK文件。

## 📋 准备工作

### 系统要求
- **操作系统**：Windows、macOS或Linux
- **Node.js**：版本16.x或更高
- **npm**：Node.js包管理器
- **Java JDK**：版本8或11（Android构建需要）
- **Android Studio**（可选）：用于更高级的配置

### 安装依赖
1. **安装Node.js**（如果尚未安装）：
   - 访问 [Node.js官网](https://nodejs.org/) 下载并安装最新的LTS版本
   - 安装时确保勾选"Add to PATH"选项

2. **验证安装**：
   ```bash
   node -v
   npm -v
   ```

## 🚀 快速开始

### 方法一：使用构建脚本（推荐）

1. **进入项目目录**：
   ```bash
   cd /home/user/vibecoding/workspace/cordova-finance-app
   ```

2. **赋予脚本执行权限**：
   ```bash
   chmod +x build-apk.sh
   ```

3. **运行构建脚本**：
   ```bash
   ./build-apk.sh
   ```

4. **等待构建完成**：
   - 脚本会自动安装依赖、配置项目并构建APK
   - 构建过程可能需要5-10分钟，请耐心等待

5. **获取APK文件**：
   - 构建成功后，APK文件将位于：
     - `finance-app-debug.apk`（当前目录）
     - `platforms/android/app/build/outputs/apk/debug/app-debug.apk`（原始位置）

### 方法二：手动构建

1. **安装Cordova**：
   ```bash
   npm install -g cordova
   ```

2. **进入项目目录**：
   ```bash
   cd /home/user/vibecoding/workspace/cordova-finance-app
   ```

3. **安装项目依赖**：
   ```bash
   npm install
   ```

4. **添加Android平台**：
   ```bash
   cordova platform add android
   ```

5. **安装必要插件**：
   ```bash
   cordova plugin add cordova-plugin-whitelist cordova-plugin-inappbrowser cordova-plugin-splashscreen cordova-plugin-network-information
   ```

6. **构建APK**：
   ```bash
   cordova build android --debug
   ```

## 📱 安装到手机

### 方法一：直接安装
1. **连接手机**：使用USB数据线将Android手机连接到电脑
2. **启用调试模式**：
   - 在手机上进入"设置" > "关于手机" > 连续点击"版本号"7次
   - 返回"设置" > "系统" > "开发者选项" > 启用"USB调试"
3. **安装APK**：
   ```bash
   adb install finance-app-debug.apk
   ```

### 方法二：文件传输
1. **复制APK文件**：将`finance-app-debug.apk`复制到手机存储
2. **在手机上安装**：
   - 打开文件管理器，找到APK文件
   - 点击安装，可能需要允许"安装未知来源应用"权限

## ⚙️ 自定义配置

### 修改应用信息
编辑`config.xml`文件可以自定义：
- 应用名称、版本号、描述
- 包名（Android应用ID）
- 权限设置
- 平台特定配置

### 自定义图标和启动图
1. **准备图片资源**：
   - 应用图标：至少192x192像素的PNG图片
   - 启动图：根据不同屏幕尺寸准备（可选）

2. **替换资源文件**：
   - 将图标文件替换到`res/icon/android/`目录
   - 将启动图替换到`res/screen/android/`目录

### 修改加载页面
编辑`www/index.html`文件可以自定义：
- 加载动画
- 错误提示
- 应用URL（修改`APP_URL`变量）

## 🌐 配置网络访问

### 指向您的网站
1. **编辑`www/index.html`**：
   ```javascript
   const APP_URL = 'https://your-website.com/finance-planner-app/index.html';
   ```

2. **替换为您的实际网址**：
   - 如果已部署到GitHub Pages：`https://your-username.github.io/finance-planner-app/index.html`
   - 如果是本地开发：`http://localhost:8080`（需要启动本地服务器）

### 网络权限配置
确保`config.xml`中包含正确的网络权限：
```xml
<access origin="*" />
<allow-navigation href="*" />
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
```

## 🎯 高级功能

### 生成发布版本APK
1. **创建签名密钥**：
   ```bash
   keytool -genkey -v -keystore finance-app.keystore -alias finance-app -keyalg RSA -keysize 2048 -validity 10000
   ```

2. **构建发布版本**：
   ```bash
   cordova build android --release
   ```

3. **签名APK**：
   ```bash
   jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore finance-app.keystore platforms/android/app/build/outputs/apk/release/app-release-unsigned.apk finance-app
   ```

### 添加推送通知
1. **安装推送插件**：
   ```bash
   cordova plugin add phonegap-plugin-push
   ```

2. **配置推送服务**：
   - 需要Firebase或其他推送服务的配置

## 🐛 常见问题解决

### 构建失败
1. **检查Node.js版本**：确保使用16.x或更高版本
2. **清理缓存**：
   ```bash
   npm cache clean --force
   ```
3. **重新添加平台**：
   ```bash
   cordova platform remove android
   cordova platform add android
   ```

### 网络连接问题
1. **检查网络权限**：确保`config.xml`中的权限配置正确
2. **检查URL**：确保`www/index.html`中的`APP_URL`正确
3. **测试网络连接**：在手机浏览器中访问相同URL

### 应用崩溃
1. **查看日志**：
   ```bash
   adb logcat
   ```
2. **检查JavaScript错误**：使用Chrome DevTools远程调试

## 📦 项目结构

```
cordova-finance-app/
├── build-apk.sh           # 一键构建脚本
├── config.xml             # Cordova配置文件
├── package.json           # npm配置文件
├── www/                   # Web资源目录
│   └── index.html         # 加载页面
├── res/                   # 资源文件目录
│   ├── icon/              # 应用图标
│   └── screen/            # 启动图
└── platforms/             # 平台特定代码（自动生成）
```

## 📱 支持的设备

- **Android版本**：Android 5.0 (API 21)及以上
- **屏幕尺寸**：自适应所有屏幕尺寸
- **架构**：支持armv7、arm64-v8a、x86、x86_64

## 🎉 完成！

现在您已经成功将理财助手Web应用打包成Android APK文件。用户可以直接安装并使用您的应用，享受原生应用般的体验。

如果您有任何问题或需要进一步的帮助，请参考以下资源：

- [Cordova官方文档](https://cordova.apache.org/docs/en/latest/)
- [Android开发者文档](https://developer.android.com/docs)
- [GitHub Pages部署指南](https://docs.github.com/en/pages)

祝您的应用开发顺利！ 🚀
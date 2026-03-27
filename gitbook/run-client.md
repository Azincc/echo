# 运行客户端

## 适用场景

这一章面向两类情况：

- 你想在本地运行本仓库，直接体验或调试 Echoes
- 你要二次开发客户端

## 依赖

- Flutter SDK
- Dart SDK
- 对应平台的构建环境

当前仓库 `pubspec.yaml` 使用的 Dart 约束为：

```text
sdk: ^3.10.8
```

## 安装依赖

在仓库根目录执行：

```bash
flutter pub get
```

## 运行代码生成

项目使用了 Freezed、JSON 序列化、Drift 和 Riverpod Generator，因此第一次运行前建议先生成代码：

```bash
dart run build_runner build --delete-conflicting-outputs
```

## 运行应用

```bash
flutter run
```

## 构建

```bash
flutter build apk
flutter build ios
flutter build windows
flutter build macos
flutter build linux
flutter build web
```

## 平台说明

根据当前仓库根 README：

- Android、iOS 是优先支持的平台
- macOS、Windows、Linux、Web 目前不是完全适配状态

如果你只是想稳定使用，建议优先在移动端验证。

## 首次启动后会发生什么

首次进入应用时，主要流程是：

1. 输入 Navidrome 服务器地址
2. 检测服务器能力
3. 使用用户名 + 密码或 API Key 登录
4. 创建本地音乐库配置
5. 同步当前可用线路并进入首页

后续详细操作见[首次登录与音乐库配置](login-and-library.md)。

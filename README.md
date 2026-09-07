# Echoes / 回响

<p align="center">
  <img src="web/icons/Icon-512.png" alt="Echoes Logo" width="180" />
</p>

让自己的音乐库，随时回响。Echoes 是一款基于 Flutter 的 Navidrome / Subsonic / OpenSubsonic 音乐客户端，面向自建音乐服务，提供多线路访问、音乐浏览与播放、歌词封面补全、本地下载和可选的服务器侧离线导入。

[产品官网](https://echoesmusic.app/) · [获取发布版本](https://github.com/Azincc/echo/releases) · [配置第一个音乐库](gitbook/README.md) · [产品官网源码](website/) · [本地开发](#本地开发)

## 使用文档

- [快速上手](gitbook/README.md)：服务器地址、账号与首条线路配置
- [Navidrome 推荐配置](gitbook/navidrome-recommended-config.md)：准备自己的音乐服务
- [Embed Service 部署](gitbook/embed-deploy.md)：可选的服务器侧离线导入

使用自己的音乐库需要准备可访问的兼容音乐服务器，以及用户名、密码或服务端支持的 API Key。普通音乐库播放不需要部署 Embed Service。

## 仓库组成

- **Echoes 客户端**：负责播放、浏览、搜索、歌单、收藏、歌词/封面增强、本地下载、缓存与设置
- **`gdstudio-embeded-service`**：可选的服务器侧离线导入服务，用于把远程搜索到的歌曲写入服务器音乐目录并触发 Navidrome 扫描
- **`website` 产品官网**：以真实应用截图展示 Echoes 的中文深色单页，使用 HTML、CSS 和 JavaScript，可独立预览与静态部署

## 项目特点

### 多音乐库与智能线路切换

- 支持管理多个音乐库，每个音乐库可配置多条服务器地址
- 启动时按优先级探测可达地址，自动选择当前可用线路
- 运行中连接异常时自动 fallback，高优先级线路恢复后可自动回切
- 支持手动锁定线路、延迟测速和拖拽调整地址优先级

### 围绕 Navidrome 的完整听歌体验

- 支持 Token/Salt 与 API Key 登录，并自动检测 OpenSubsonic 能力
- 提供音乐流首页、专辑/歌手/歌曲/歌单浏览、收藏、搜索与播放队列
- 迷你播放器 + 全屏播放器，提供播放队列、歌词面板，以及移动端后台播放与系统媒体控制
- 提供播放统计、收藏统计与缓存统计，方便观察使用情况

### 音质、缓存与播放策略可配置

- 支持原始直连和多档转码音质，转码能力由音乐服务器提供
- 可按 Wi-Fi / 移动数据自动切换音质
- 支持交叉淡入淡出、下一首预缓存、音频缓存上限与清理
- 提供日志导出、版本检查和缓存管理等运维向能力

### 歌词与封面增强

- 多源歌词：服务端、LRCLIB、网易云、自定义 API
- 多源封面：服务端、Fanart.tv、MusicBrainz、自定义 API
- 支持提供商优先级配置、同步歌词逐行高亮、点击歌词跳转
- 根据封面提取主色生成播放器背景氛围，并缓存歌词与资源

### 下载与离线导入双链路

- 原生客户端支持歌曲、专辑、歌单的本地下载和下载管理
- 支持扫描已下载文件，统一纳入客户端管理
- 支持远程搜索与试听，并通过 Embed Service 将歌曲导入服务器音乐目录
- GitBook 文档覆盖 Navidrome、Embed Service、客户端接入与排障

### 平台支持与当前边界

仓库包含 Android、iOS、macOS、Windows、Linux 和 Web 工程，当前优先打磨移动端。平台工程和构建流程的存在不代表所有功能均已完成平台验收。

| 平台 | 当前说明 |
| --- | --- |
| Android | 可通过 Android Emulator 或真机运行；支持本地下载、缓存与后台媒体服务 |
| iOS | 使用 macOS、Xcode 和 Simulator / 真机开发；真机安装需配置签名，CI 产物为未签名 IPA |
| Windows / macOS / Linux | 桌面布局与播放持续适配中；当前播放器不启用移动端的 AudioService 集成 |
| Web | 适合浏览器体验与开发预览；本地音频下载、音频文件缓存尚未实现，SQLite 使用内存数据库，刷新页面后数据库内容不会保留 |

Web 中的服务器访问还受浏览器跨域、HTTPS 和音频格式支持限制；不要把浏览器预览当作原生端离线能力的验收。

## 界面设计：Echo Listening System

Echo 使用自有的 **Echo Listening System**，以“**Album Light, Quiet Chrome**”为设计方向：专辑封面只在播放器、MiniPlayer 和媒体详情等与当前音乐直接相连的场景提供局部光线；导航、资料库、下载、设置和表单保持安静、稳定的中性界面，让内容与任务始终处于主位。

- **移动端三档布局**：Compact `< 600dp` 使用单列与底部导航；Medium `600-839dp` 扩展为更宽的内容分组和双列；Expanded `>= 840dp` 使用导航轨或侧栏、主从详情与双栏播放器，而不是简单放大手机页面。
- **产品状态**：以内容骨架、空内容说明、弱网与离线提示、局部重试表达加载和失败，保留仍可用的内容。
- **无障碍目标**：主要触控目标至少 48dp，支持系统明暗模式、动态字体与减少动效；关键流程以 200% 字体缩放仍可完成为目标，具体设备、读屏和布局验收仍在持续完善。
- **熟悉行为，自有表达**：保留 Flutter 的路由、语义、焦点、键盘和手势基础设施，可见界面统一由 Echo 组件、语义 token 与 `AppIcons` 控制。

完整设计合同见 [`PRODUCT.md`](PRODUCT.md)、[`DESIGN.md`](DESIGN.md) 与 [`docs/echo-ui-overhaul-plan.md`](docs/echo-ui-overhaul-plan.md)。

## 界面截图

以下四张为 **2026-09-07 从当前 `main` 分支实际运行采集的 Android Emulator 截图**，同时用于产品官网。采集代码提交为 `1df30705099b7b1933063f7674c2a699abf57923`；环境为 Flutter `3.38.9`、Dart `3.10.8`、Pixel 6 Pro 模拟器、Android 16 / API 36。截图尺寸为 `990 × 2200 px`，密度 `440 dpi`，对应逻辑视口 `360 × 800 dp`。

| 音乐流 | 音乐库 | 全屏播放器 | 同步歌词 |
| --- | --- | --- | --- |
| <img src="docs/screenshots/android-2026-09-07/music-home.png" alt="Echoes 音乐流首页模拟器截图" width="200" /> | <img src="docs/screenshots/android-2026-09-07/library-home.png" alt="Echoes 音乐库模拟器截图" width="200" /> | <img src="docs/screenshots/android-2026-09-07/full-player.png" alt="Echoes 专辑配色全屏播放器模拟器截图" width="200" /> | <img src="docs/screenshots/android-2026-09-07/lyrics-view.png" alt="Echoes 同步双语歌词模拟器截图" width="200" /> |

**本次核心验证**：完成编译安装、服务器登录、首页与音乐库加载、搜索并播放《Cruel Summer》，确认封面与同步双语歌词可用；采集后已暂停播放。本次仅完成这些必要流程验证，跨平台、完整设备矩阵、无障碍与性能验收仍以[UI 计划](docs/echo-ui-overhaul-plan.md)为准。[服务器连接页](docs/screenshots/android-2026-09-07/server-connection.png)也保留在本次截图目录中，历史采集记录见[截图验收清单](docs/ui-baseline-manifest.md)。

## 技术栈

| 层级     | 技术方案                        |
|--------|-----------------------------|
| 框架     | Flutter                     |
| 状态管理   | Riverpod                    |
| 音频引擎   | just_audio + audio_service  |
| 网络     | Dio + 自定义 Fallback 拦截器      |
| 本地数据库  | Drift (SQLite)              |
| 本地配置   | SharedPreferences           |
| API 协议 | Subsonic / OpenSubsonic API |
| 设计     | Echo Listening System       |

## 后续方向

- 继续完成 Android 与 iOS 的明暗模式、动态字体、减少动效、读屏与关键设备尺寸验收
- 更新各平台、主题与布局的真实运行截图
- 均衡器 / ReplayGain（尚未实现）
- 持续完善桌面端与 Web 适配体验

## 本地开发

### 前置环境

- **Flutter stable**：CI 当前使用 `3.38.9`；`pubspec.yaml` 要求 Dart `^3.10.8`，使用满足该约束的 Flutter SDK。
- **Android**：Android Studio、Android SDK、Platform-Tools、Android Emulator 和至少一个 AVD；Android 构建使用 Java 17 目标，建议使用 Android Studio 提供的 JDK，并通过 `flutter doctor -v` 检查工具链。
- **其他平台**：iOS / macOS 需要 macOS 与 Xcode；Windows 需要 Visual Studio 的 C++ 桌面开发工具；Linux 需要 GTK、CMake、Ninja 等原生构建依赖。

首次使用 Android 工具链时，运行 `flutter doctor --android-licenses` 完成 SDK 许可配置。

### 安装依赖

```bash
flutter doctor -v
flutter pub get
```

仓库已包含生成的 Dart 文件。修改 Freezed / JSON 模型、Drift 数据库或 Riverpod 生成器输入后，再运行代码生成：

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 在 Android Emulator 中启动

先在 Android Studio 的 Device Manager 创建 Android 虚拟设备，然后在项目根目录运行：

```bash
# 查看可启动的 AVD
flutter emulators

# 将 AVD_ID 替换为上一步列出的模拟器 ID
flutter emulators --launch AVD_ID

# 等待系统启动后，查看运行中的设备
flutter devices

# 将 DEVICE_ID 替换为实际设备 ID，例如 emulator-5554
flutter run -d DEVICE_ID
```

`AVD_ID` 是虚拟设备名称，`DEVICE_ID` 是启动后的设备标识，两者不同。已有运行中的模拟器时，直接从 `flutter devices` 开始即可。Debug 运行使用 Android 默认调试签名，不需要发布用 keystore。

建议使用专用开发 AVD。若设备已安装正式版或其他签名的同包名应用，`flutter run` 可能因签名冲突卸载旧版后重装，清除旧版的本地配置与数据。

首次启动会进入音乐库登录向导。如果 Navidrome 运行在开发电脑上，Android Emulator 中应使用 `http://10.0.2.2:4533`（端口按实际配置修改），而不是 `localhost`；如果服务在 NAS 或远程主机上，填写模拟器能够访问的完整地址。详细步骤见[快速上手](gitbook/README.md)。

2026-09-07 已在 `main` 分支使用 Flutter `3.38.9`、Dart `3.10.8`，向已启动的 `Pixel_6_Pro` AVD 执行 `flutter run -d emulator-5554`，并完成登录、首页加载与播放等核心验证，结果见[界面截图](#界面截图)。请以自己运行 `flutter devices` 的结果选择设备。

### 构建应用

在具备对应平台工具链的主机上执行：

```bash
flutter build apk --release --split-per-abi
flutter build ios --release --no-codesign
flutter build windows
flutter build macos
flutter build linux
flutter build web
```

Android APK 输出到 `build/app/outputs/flutter-apk/`。正式分发应配置 `android/key.properties` 或 `ECHO_STORE_FILE`、`ECHO_STORE_PASSWORD`、`ECHO_KEY_ALIAS`、`ECHO_KEY_PASSWORD` 环境变量；未配置完整发布签名时，当前构建脚本使用调试签名。`--no-codesign` 的 iOS 构建仅生成未签名产物，不能直接作为已签名应用安装。

### 开发检查

按改动范围执行必要检查；完整的 PR 检查由 [CI 工作流](.github/workflows/pr_checks.yml) 定义：

```bash
flutter analyze
flutter test
```

更改生成器输入时，还需运行前述代码生成并提交对应产物。首次接入音乐服务器的核心验证为：首页能够加载、任意歌曲能够播放、当前线路显示正确。

## 项目结构

```text
lib/
├── core/                     # 常量、主题、工具类、网络基础设施
├── data/                     # 数据模型、仓库、数据源（API、数据库、本地存储）
├── features/                 # 功能模块（认证、首页、探索、音乐库、播放器、设置）
├── providers/                # Riverpod 状态管理
├── widgets/                  # 共享组件
├── main.dart                 # 入口
└── app.dart                  # MaterialApp.router 与路由装配

gdstudio-embeded-service/     # 服务器侧离线导入服务
gitbook/                      # 使用与部署文档
website/                      # 产品官网、真实截图资源与本地预览服务
docs/                         # 设计说明、验收计划与界面截图
test/                         # 单元测试与 Widget 测试
.github/workflows/            # 检查、各平台构建与发布流程
```

## 协议

客户端通过 Subsonic / OpenSubsonic API 与 Navidrome 等兼容服务通信。探索页的远程搜索与试听接入 GD Studio API；把远程歌曲写入服务器音乐目录则需要配置可选的 Embed Service。客户端本地下载保存到设备，服务器侧离线导入保存到服务端音乐目录，两者独立管理。

## 友情链接

- [gdstudio 首页](https://music.gdstudio.org/)
- [linux.do 论坛](https://linux.do/)

## 许可证

本项目基于 [MIT](LICENSE) 许可证开源。

## 产品官网

访问 [Echoes 官网](https://echoesmusic.app/) · [English](https://echoesmusic.app/en/)。

[`website/`](website/) 是独立的中英文产品官网，以模拟器实采截图介绍音乐库、播放器、歌词与多线路体验。中文位于 `/`，英文位于 `/en/`。页面使用原生 HTML / CSS / JavaScript，无 npm 依赖；构建时生成双语 SEO、站点地图和分享元数据，并提供键盘导航、截图弹窗及减少动效适配。

安装 Node.js（推荐 22 LTS，最低 18）后，在项目根目录启动本地预览：

```bash
node website/serve.mjs
```

打开[中文预览](http://localhost:4311/)或[英文预览](http://localhost:4311/en/)。启动时自动构建到 `website/dist/`；修改源文件后需重新执行 `node website/build.mjs` 并刷新页面，或重启预览服务。

新增的 [官网发布工作流](.github/workflows/deploy_website.yml) 支持 Cloudflare Pages 和 GHCR 的 AMD64 / ARM64 容器镜像；也可运行 `docker compose -f website/compose.yaml up -d --build` 本地部署。静态托管应发布构建产物 `website/dist/`。域名、HTTPS、自托管和镜像使用方法见 [官网部署文档](website/README.md)。官网与 Flutter 的 `web/` 客户端及其构建工作流独立。

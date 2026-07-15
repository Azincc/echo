# 回响/Echoes

<p align="center">
  <img src="web/icons/Icon-512.png" alt="Echoes Logo" width="180" />
</p>

一款基于 Flutter 的 Navidrome / Subsonic / OpenSubsonic 音乐客户端，面向自建音乐服务场景，重点解决多线路访问、跨设备播放、歌词封面补全、本地下载与服务器侧离线导入等实际问题。

## 使用文档

- [`gitbook/README.md`](gitbook/README.md)：快速上手文档

## 仓库组成

- **Echoes 客户端**：负责播放、浏览、搜索、歌单、收藏、歌词/封面增强、本地下载、缓存与设置
- **`gdstudio-embeded-service`**：可选的服务器侧离线导入服务，用于把远程搜索到的歌曲写入服务器音乐目录并触发 Navidrome 扫描

## 项目特点

### 多音乐库与智能线路切换

- 支持管理多个音乐库，每个音乐库可配置多条服务器地址
- 启动时按优先级探测可达地址，自动选择当前可用线路
- 运行中连接异常时自动 fallback，高优先级线路恢复后可自动回切
- 支持手动锁定线路、延迟测速和拖拽调整地址优先级

### 围绕 Navidrome 的完整听歌体验

- 支持 Token/Salt 与 API Key 登录，并自动检测 OpenSubsonic 能力
- 提供音乐流首页、专辑/歌手/歌曲/歌单浏览、收藏、搜索与播放队列
- 迷你播放器 + 全屏播放器，支持后台播放、系统通知栏控制和歌词面板
- 提供播放统计、收藏统计与缓存统计，方便观察使用情况

### 音质、缓存与播放策略可配置

- 支持原始直连和多档转码音质
- 可按 Wi-Fi / 移动数据自动切换音质
- 支持交叉淡入淡出、下一首预缓存、音频缓存上限与清理
- 提供日志导出、版本检查和缓存管理等运维向能力

### 歌词与封面增强

- 多源歌词：服务端、LRCLIB、网易云、自定义 API
- 多源封面：服务端、Fanart.tv、MusicBrainz、自定义 API
- 支持提供商优先级配置、同步歌词逐行高亮、点击歌词跳转
- 根据封面提取主色生成播放器背景氛围，并缓存歌词与资源

### 下载与离线导入双链路

- 支持歌曲、专辑、歌单的本地下载和下载管理
- 支持扫描已下载文件，统一纳入客户端管理
- 支持远程搜索与试听，并通过 Embed Service 将歌曲导入服务器音乐目录
- GitBook 文档覆盖 Navidrome、Embed Service、客户端接入与排障

### 跨平台实现，但以移动端为先

- 使用 Flutter 一套代码覆盖 Android、iOS、macOS、Windows、Linux、Web
- 当前优先打磨 Android 与 iOS 体验，桌面端与 Web 仍在持续适配

## 界面设计：Echo Listening System

Echo 使用自有的 **Echo Listening System**，以“**Album Light, Quiet Chrome**”为设计方向：专辑封面只在播放器、MiniPlayer 和媒体详情等与当前音乐直接相连的场景提供局部光线；导航、资料库、下载、设置和表单保持安静、稳定的中性界面，让内容与任务始终处于主位。

- **移动端三档布局**：Compact `< 600dp` 使用单列与底部导航；Medium `600-839dp` 扩展为更宽的内容分组和双列；Expanded `>= 840dp` 使用导航轨或侧栏、主从详情与双栏播放器，而不是简单放大手机页面。
- **完整产品状态**：加载使用与最终内容同形的骨架；空内容、弱网、离线、失败、部分数据和禁用状态都提供清楚说明与恢复路径，不用通用进度圈或全屏错误覆盖仍可用的内容。
- **无障碍优先**：主要触控目标至少 48dp，支持系统明暗模式、动态字体与减少动效；关键流程以 200% 字体缩放仍可完成为目标，并为读屏、焦点顺序和非颜色状态提示保留明确语义。
- **熟悉行为，自有表达**：保留 Flutter 的路由、语义、焦点、键盘和手势基础设施，可见界面统一由 Echo 组件、语义 token 与 `AppIcons` 控制。

完整设计合同见 [`PRODUCT.md`](PRODUCT.md)、[`DESIGN.md`](DESIGN.md) 与 [`docs/echo-ui-overhaul-plan.md`](docs/echo-ui-overhaul-plan.md)。

## 界面截图

> 截图状态（2026-07-15）：下列链接均指向仓库中真实存在的重构前功能基线截图，用于核对页面范围和功能，不代表当前 Echo Listening System 的最终视觉。新的 Android/iOS、明暗模式和多档布局截图将在最终验收后替换；当前没有的新截图不会用概念图或伪造图片代替。

- [音乐流首页（待替换）](docs/screenshots/music-home.png)
- [探索（待替换）](docs/screenshots/explore-page.png)
- [应用设置入口（待替换）](docs/screenshots/profile-page.png)
- [多音乐库管理（待替换）](docs/screenshots/multi-library-management.png)
- [编辑音乐库与多线路（待替换）](docs/screenshots/edit-library-multi-endpoint.png)
- [统计信息（待替换）](docs/screenshots/stats-overview.png)
- [全屏播放器（待替换）](docs/screenshots/full-player.png)
- [歌词（待替换）](docs/screenshots/lyrics-view.png)
- [下载管理（待替换）](docs/screenshots/download-manager.png)
- [离线下载管理（待替换）](docs/screenshots/offline-download-manager.png)
- [缓存管理（待替换）](docs/screenshots/cache-management.png)
- [主题设置（待替换）](docs/screenshots/theme-settings.png)

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

## 当前 UI 收尾

- 完成 Android 与 iOS 的明暗模式、动态字体、减少动效、读屏与关键设备尺寸验收
- 最终验收后采集并替换 Echo Listening System 新截图与 UI 导出
- 均衡器 / ReplayGain
- 持续完善桌面端与 Web 适配体验

## 快速开始

```bash
# 安装依赖
flutter pub get

# 运行代码生成（Freezed、JSON、Drift、Riverpod）
dart run build_runner build --delete-conflicting-outputs

# 运行应用
flutter run

# 构建
flutter build apk      # Android
flutter build ios      # iOS
flutter build windows  # Windows
flutter build macos    # macOS
flutter build linux    # Linux
flutter build web      # Web
```

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
```

## 协议

客户端主要通过 Subsonic / OpenSubsonic API 与 Navidrome 等兼容服务通信；远程试听与服务器侧离线导入依赖仓库内提供的可选 Embed Service。

## 友情链接

- [gdstudio 首页](https://music.gdstudio.org/)
- [linux.do 论坛](https://linux.do/)

## 许可证

本项目基于 [MIT](LICENSE) 许可证开源。

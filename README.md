# Echo

一款基于 Flutter 的 Navidrome/Subsonic 音乐串流客户端，支持全平台（Android、iOS、macOS、Windows、Linux、Web）。

## 项目目标

Echo 旨在成为一款高品质的自建音乐服务客户端，核心解决以下痛点：

- **多服务器管理** — 支持多后端 + 多地址智能 Fallback，适应复杂网络环境
- **无感切换** — 按优先级自动探测地址，连接失败时自动切换，无需手动干预
- **跨平台** — Flutter 一套代码覆盖六大平台
- **开源免费** — 社区共建，持续迭代

## 技术栈

| 层级 | 技术方案 |
|------|---------|
| 框架 | Flutter |
| 状态管理 | Riverpod |
| 音频引擎 | just_audio + audio_service |
| 网络 | Dio + 自定义 Fallback 拦截器 |
| 本地数据库 | Drift (SQLite) |
| API 协议 | Subsonic / OpenSubsonic API |
| 设计 | Material 3 |

## 功能进度

### v0.1.0 — 基础播放 ✅ 已完成

- [x] 连接 Navidrome 服务器（支持 Token/Salt 和 API Key 两种认证）
- [x] 登录页面（自动检测 OpenSubsonic 支持）
- [x] 音乐流首页（随机推荐、最近播放、常听专辑）
- [x] 音乐库浏览（按专辑、歌手、歌曲、歌单）
- [x] 专辑详情、歌手详情页
- [x] 音频播放（播放/暂停/上一首/下一首/进度拖动）
- [x] 播放队列管理
- [x] 迷你播放器 + 全屏播放器
- [x] 后台播放 + 系统通知栏控制
- [x] 搜索功能
- [x] 收藏（Star）功能

### v0.2.0 — 多地址智能 Fallback ✅ 已完成

- [x] 多音乐库管理（添加/编辑/切换/删除）
- [x] 多地址池（为每个音乐库配置多个地址，拖拽排序优先级）
- [x] 启动时按优先级自动探测，选择最快可达地址
- [x] 运行中连接失败自动切换到下一地址
- [x] 后台心跳检测（每 30s 检测连接状态）
- [x] 高优先级地址恢复后可自动回切
- [x] 网络变化（Wi-Fi / 移动数据切换）时自动重新探测
- [x] 侧栏抽屉（音乐库列表、连接状态、设置入口）
- [x] Drift 数据库持久化（音乐库 + 地址配置）
- [x] 封面图清晰度优化（根据设备像素比请求高分辨率图片）

### v0.3.0 — 歌词 & 封面提供商 🚧 未开始

- [ ] 多源歌词获取（服务端 / LRCLIB / 网易云 / 自定义 API）
- [ ] 歌词提供商优先级配置（拖拽排序）
- [ ] 同步歌词逐行高亮滚动
- [ ] 点击歌词行跳转到对应时间
- [ ] 纯文本歌词展示
- [ ] 多源封面获取（服务端 / Fanart.tv / MusicBrainz / 自定义）
- [ ] 播放器背景色从封面提取
- [ ] 歌词本地缓存

### 后续规划 🚧 未开始

- [ ] 音质切换 & 按网络环境自动切换码率
- [ ] 下载管理器（按曲目/专辑/歌单批量下载）
- [ ] 智能缓存（LFU + LRU 混合淘汰策略）
- [ ] 均衡器 & ReplayGain
- [ ] Gapless / Crossfade 无缝播放
- [ ] 播放统计可视化
- [ ] 深色模式 & Dynamic Color

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

```
lib/
├── core/          # 常量、主题、工具类、网络基础设施
├── data/          # 数据模型、仓库、数据源（API、数据库、本地存储）
├── features/      # 功能模块（认证、首页、音乐库、播放器、侧栏）
├── providers/     # Riverpod 状态管理
├── widgets/       # 共享组件（主骨架、侧栏、封面图）
├── main.dart      # 入口
└── app.dart       # 路由配置、MaterialApp
```

## 协议

本项目基于 Subsonic API（v1.16.1）与 Navidrome 服务端通信，兼容所有 Subsonic 协议的音乐服务器。

## 许可证

本项目基于 [MIT](LICENSE) 许可证开源。

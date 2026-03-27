# 项目总览

Echoes 是一个基于 Flutter 的 Navidrome / Subsonic / OpenSubsonic 客户端，重点解决自建音乐服务在多线路访问、跨平台使用、歌词封面补全、本地下载和服务器侧离线导入上的实际问题。

## 项目包含什么

当前仓库主要由两部分组成：

- Echoes 客户端：负责播放、浏览、搜索、歌单、收藏、设置、本地下载
- `gdstudio-embeded-service`：负责将远程搜索到的歌曲导入服务器音乐库

如果只想把 Navidrome 当作音乐服务器来听歌，只部署 Navidrome 就够了。

如果还想把远程找到的歌曲补进服务器曲库，再额外部署 Embed Service。

## 核心能力

- 支持 Navidrome / Subsonic / OpenSubsonic 登录
- 支持多音乐库与多地址线路切换
- 支持启动探测、故障切换和线路自动回退
- 支持首页推荐、音乐库浏览、歌单、收藏和搜索
- 支持歌词和封面多源获取
- 支持客户端本地下载
- 支持远程搜索、试听与服务器侧离线导入

## 适合谁看

- 想直接使用本项目的用户
- 要部署 Navidrome 和 Embed Service 的维护者
- 要本地运行或继续开发客户端的开发者

## 快速上手

如果你想最快跑起来，直接看：

- [快速上手](quick-start.md)

## 推荐阅读顺序

1. [快速上手](quick-start.md)
2. [系统架构](architecture.md)
3. [部署 Navidrome](deploy-navidrome.md)
4. [部署 Embed Service](deploy-embed-service.md)
5. [首次登录与音乐库配置](login-and-library.md)
6. [功能使用说明](feature-guide.md)

## 推荐部署拓扑

```text
Echoes App
  ├─ 播放 / 浏览 / 歌单 / 歌词 / 封面 -> Navidrome
  ├─ 远程搜索 / 试听 -> GDStudio Public API
  └─ 离线导入任务 -> Embed Service -> 写入音乐文件 -> 触发 Navidrome 扫描
```

## 说明

- 文档以当前仓库实现为准。
- 服务部署以 Docker 为主。
- Navidrome Docker 示例参考官方文档：<https://www.navidrome.org/docs/installation/docker/>

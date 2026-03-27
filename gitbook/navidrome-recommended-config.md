# Navidrome 推荐配置

## 目的

本文提供面向 Echoes 的最小推荐配置。配置范围仅覆盖当前项目使用中实际需要的项，不追求完整列举。

以下内容已参考 Navidrome 官方 Docker 安装文档和配置选项文档进行核对，核对日期为 2026-03-27：

- <https://www.navidrome.org/docs/installation/docker/>
- <https://www.navidrome.org/docs/usage/configuration/options/>

## 配置目标

推荐配置主要关注以下事项：

1. 为 Echoes 提供稳定的登录与播放能力
2. 明确数据目录与音乐目录的持久化方式
3. 为后续接入 Embed Service 保留兼容性
4. 改善中文搜索表现
5. 适配反向代理及多线路访问场景

## 推荐 Compose

```yaml
services:
  navidrome:
    image: deluan/navidrome:latest
    container_name: navidrome
    restart: unless-stopped
    user: "1000:1000"
    ports:
      - "4533:4533"
    environment:
      ND_LOGLEVEL: info
      ND_SCANNER_SCANONSTARTUP: "true"
      ND_SCANNER_SCHEDULE: "@every 24h"
      ND_SEARCHFULLSTRING: "true"
      ND_ENABLEINSIGHTSCOLLECTOR: "false"
      # 仅在反向代理或路径前缀场景下配置
      # ND_BASEURL: "https://music.example.com"
    volumes:
      - ./navidrome-data:/data
      - ./music-root:/music:ro
```

## 配置说明

### `user: "1000:1000"`

建议以非 root 用户运行容器，以减少宿主机目录权限问题。

### `./navidrome-data:/data`

该目录用于持久化数据库、缓存与配置文件。容器重建时，数据不会丢失。

### `./music-root:/music:ro`

建议以只读方式挂载音乐目录。若后续接入 Embed Service，写入操作应由 Embed Service 负责，Navidrome 保持只读即可。

### `ND_LOGLEVEL=info`

适用于常规运行场景。仅在排查问题时再切换为 `debug`。

### `ND_SCANNER_SCANONSTARTUP=true`

容器启动后自动执行一次扫描，用于降低重启后的索引不一致风险。

### `ND_SCANNER_SCHEDULE=@every 24h`

建议保留周期性扫描，作为主动扫描之外的补充机制。

### `ND_SEARCHFULLSTRING=true`

该选项对中文及非空格分词语言更友好，通常能改善 Echoes 的搜索体验。

### `ND_ENABLEINSIGHTSCOLLECTOR=false`

若部署目标偏向自托管和最小化外联，可关闭该项。

### `ND_BASEURL`

仅在以下场景中建议设置：

- 服务位于反向代理之后
- 使用路径前缀
- 需要 Navidrome 生成带完整域名的外部链接

若直接通过 `http://IP:4533` 访问，通常无需设置。

## 推荐目录布局

基础目录布局如下：

```text
stack/
  navidrome-data/
  music-root/
```

若需要接入 Embed Service，建议扩展为：

```text
stack/
  navidrome-data/
  music-root/
  embed-work/
```

## 面向 Echoes 的使用建议

### 为客户端创建独立用户

不建议长期在客户端中使用管理员账号。

### 优先使用 API Key

当 Navidrome 支持 API Key 时，建议将其作为 Echoes 的首选认证方式。

### 优先配置稳定的第一条线路

第一条线路建议使用最稳定、最常用的地址，例如：

- 局域网：`http://192.168.1.10:4533`
- 公网：`https://music.example.com`

在第一条线路验证通过后，再配置附加线路。

## 接入 Embed Service 时的要求

若计划接入 Embed Service，应满足以下条件：

1. Navidrome 读取宿主机 `./music-root`
2. Embed Service 写入宿主机 `./music-root`
3. 两个容器看到的是同一份文件

在当前项目默认配置下，Embed Service 会将文件写入：

```text
./music-root/library/...
```

因此，只要 Navidrome 读取 `./music-root`，扫描后即可识别该目录中的新文件。

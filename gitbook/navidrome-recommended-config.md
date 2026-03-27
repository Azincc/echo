# Navidrome 推荐配置

这份配置是给 Echoes 用的最小推荐版，不追求“大而全”，只保留当前项目真正需要的项。

以下配置项已按 Navidrome 官方 Docker 安装页和配置选项页核对，核对日期为 2026-03-27：

- <https://www.navidrome.org/docs/installation/docker/>
- <https://www.navidrome.org/docs/usage/configuration/options/>

## 推荐目标

这份推荐配置主要解决五件事：

1. 稳定提供给 Echoes 登录和播放
2. 目录持久化清晰
3. 适合后续接 Embed Service
4. 适合中文搜索
5. 适合反向代理或多线路访问

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
      # 如果放在反向代理路径后面，再取消下面这一行注释
      # ND_BASEURL: "https://music.example.com"
    volumes:
      - ./navidrome-data:/data
      - ./music-root:/music:ro
```

## 每一项为什么这样配

### `user: "1000:1000"`

避免容器以 root 身份写宿主机目录，减少权限问题。

### `./navidrome-data:/data`

把数据库、缓存和配置持久化下来，容器重建不会丢。

### `./music-root:/music:ro`

让 Navidrome 只读读取音乐目录。

如果你后续要接 Embed Service，仍然推荐 Navidrome 保持只读；写入应由 Embed Service 完成。

### `ND_LOGLEVEL=info`

正常使用足够；出问题再临时切 `debug`。

### `ND_SCANNER_SCANONSTARTUP=true`

重启后自动补一次扫描，降低“服务重启后库状态没更新”的概率。

### `ND_SCANNER_SCHEDULE=@every 24h`

日常自动兜底扫描。

即使你已经使用 Embed Service 的主动扫描，这个定时扫描仍然值得保留。

### `ND_SEARCHFULLSTRING=true`

对中文和非空格分词语言更友好，Echoes 搜索体验会更稳。

### `ND_ENABLEINSIGHTSCOLLECTOR=false`

如果你更偏向自托管和最小外联，可以关掉。

### `ND_BASEURL`

只有在以下情况才需要设置：

- 你放在反向代理后面
- 你使用路径前缀
- 你希望 Navidrome 生成的外部链接带完整域名

如果只是直接用 `http://IP:4533`，通常不用设。

## 推荐的目录布局

```text
stack/
  navidrome-data/
  music-root/
```

如果你还要接 Embed Service，建议继续沿用：

```text
stack/
  navidrome-data/
  music-root/
  embed-work/
```

## 给 Echoes 使用时的建议

### 1. 给客户端准备一个专用用户

不要直接长期使用管理员账号在客户端登录。

### 2. 如果支持 API Key，优先给 Echoes 用 API Key

这样比长期直接填密码更合适。

### 3. 第一条线路先用最稳的地址

例如：

- 局域网优先：`http://192.168.1.10:4533`
- 公网优先：`https://music.example.com`

先把第一条线路跑通，再去配第二条。

## 如果你要接 Embed Service

请保证：

1. Navidrome 读取的是宿主机 `./music-root`
2. Embed Service 写入的也是这份 `./music-root`
3. 两边看到的是同一份文件

当前项目默认情况下，Embed Service 会写到：

```text
./music-root/library/...
```

所以 Navidrome 只要读 `./music-root`，就能把这部分内容扫进来。

# Navidrome 推荐配置

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

## 飞牛版本说明

如果使用飞牛应用中心安装的 Navidrome，建议额外根据以下教程启用 FFmpeg 转码支持：

- <https://club.fnnas.com/forum.php?mod=viewthread&tid=4968>

根据该教程，飞牛版本通常需要在 Navidrome 配置中显式开启转码界面配置，并指定 `ffmpeg` 路径，否则客户端在启用转码时可能无法正常播放。

教程给出的关键配置如下：

```toml
# 启用用户界面中的转码配置
ND_ENABLETRANSCODINGCONFIG = true

# 配置 ffmpeg 路径
FFmpegPath = "/usr/bin/ffmpeg"
```

对于飞牛应用中心安装的 Navidrome，教程中提到的配置文件路径为：

```text
/vol1/@appdata/navidrome/navidrome.toml
```

修改完成后，建议重新停用并启用 Navidrome，再到客户端中验证转码播放是否恢复正常。

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

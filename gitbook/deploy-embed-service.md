# 部署 Embed Service

## 这个服务是做什么的

`gdstudio-embeded-service` 用于把 Echoes 远程搜索到的歌曲下载到服务器，并在完成后触发 Navidrome 扫描。

它不是播放器，也不是 Navidrome 的替代品，而是“服务器侧离线导入服务”。

## 部署前先理解一个路径细节

当前仓库中 Embed Service 的默认配置文件 `configs/config.yaml` 使用：

```yaml
storage:
  music_dir: /music/library
```

这意味着：

- 如果你把宿主机 `./music-root` 挂载到容器内 `/music`
- 那么最终音频文件会写进宿主机的 `./music-root/library/...`

这不是错误，是当前项目的默认行为。文档下面的示例会沿用这一行为，避免和仓库现有配置打架。

## 推荐方式一：使用预构建镜像

这是最适合真实使用的方式。

### 示例 `docker-compose.yml`

如果你希望和 Navidrome 一起部署，可以直接使用下面这份组合示例：

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
    volumes:
      - ./navidrome-data:/data
      - ./music-root:/music:ro

  embed-service:
    image: ghcr.io/azincc/gdstudio-embeded-service:latest
    container_name: embed-service
    restart: unless-stopped
    ports:
      - "5434:8080"
    environment:
      NAVIDROME_BASE_URL: http://navidrome:4533
      NAVIDROME_USER: admin
      NAVIDROME_PASSWORD: change-me
      API_KEY: change-this-api-key
      API_KEY_NAME: echo-client
      MAX_CONCURRENT_JOBS: 3
      JOB_POLL_INTERVAL: 2s
      DOWNLOAD_TIMEOUT: 600s
      LOG_LEVEL: info
      MUSICBRAINZ_ENABLED: true
    volumes:
      - ./music-root:/music:rw
      - ./embed-work/work:/work:rw
```

## 启动

```bash
docker compose up -d
docker compose logs -f embed-service
```

## 健康检查

```bash
curl http://localhost:5434/healthz
```

## 列出任务

```bash
curl http://localhost:5434/v1/jobs \
  -H "X-API-Key: change-this-api-key"
```

## 客户端里该填什么

在 Echoes 的“编辑音乐库 -> Embed Service 离线下载”里填写：

| 字段 | 示例值 |
| --- | --- |
| Embed Service URL | `http://192.168.1.10:5434` |
| API Key | `change-this-api-key` |
| Library ID | `default` |

说明：

- `Library ID` 当前默认填 `default` 即可。
- `测试连接` 实际会访问 `/v1/jobs`，所以如果这里失败，通常是 URL 或 API Key 填错。

## 端口说明

当前仓库里有两套对外端口：

- 开发 compose：`8080:8080`
- 生产 compose：`5434:8080`

所以你会看到文档里同时出现 `8080` 和 `5434`。关键不在于哪个更“正确”，而在于客户端里要填写你实际暴露出去的那个地址。

## 推荐方式二：本地开发运行

如果你要调试服务本身，可以进入子项目目录：

```bash
cd gdstudio-embeded-service
```

然后分别启动 API 和 Worker：

```bash
go run cmd/api/main.go
go run cmd/worker/main.go
```

本地开发前建议先准备：

```bash
mkdir -p /work/tmp /work/data /music/library
```

## 工作目录里有什么

默认情况下：

- SQLite 数据库位于 `/work/data/embed.db`
- 临时下载文件位于 `/work/tmp` 下的任务目录
- 最终音乐文件写入 `/music/library/...`

## 你需要特别确认的三件事

1. `NAVIDROME_BASE_URL` 指向真实可访问的 Navidrome 地址
2. 容器对 `/music` 和 `/work` 具有写权限
3. Navidrome 与 Embed Service 看到的是同一份宿主机音乐目录

只要这三件事有一项不成立，离线导入就很容易表现成“任务成功了，但音乐库里看不到歌”。

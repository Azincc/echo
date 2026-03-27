# Embed 部署教程

这份文档只讲一件事：把 `gdstudio-embeded-service` 跑起来，并接进 Echoes。

## 先说结论

Embed Service 不是播放器，它的作用是：

1. 接收 Echoes 提交的离线导入任务
2. 下载远程歌曲
3. 写入标签和封面
4. 把文件放进服务器音乐目录
5. 触发 Navidrome 扫描

如果你只想听已经在 Navidrome 里的歌，不需要部署它。

## 部署前必须理解的路径规则

当前仓库默认配置里，Embed Service 的目标音乐目录是：

```yaml
storage:
  music_dir: /music/library
```

这意味着：

- 宿主机挂载 `./music-root:/music`
- 最终文件会落到宿主机 `./music-root/library/...`

所以 Navidrome 也必须读同一份 `./music-root`，否则导入成功后它看不到文件。

## 最小可用 Compose

假设你的 Navidrome 已经在同一个 Compose 网络里，服务名叫 `navidrome`：

```yaml
services:
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

如果 Navidrome 不在同一个 Compose 里，把 `NAVIDROME_BASE_URL` 改成它实际可访问的地址，例如：

```text
http://192.168.1.10:4533
```

## 启动

```bash
docker compose up -d
docker compose logs -f embed-service
```

## 部署完成后先验三项

### 1. 健康检查

```bash
curl http://localhost:5434/healthz
```

### 2. API Key 是否生效

```bash
curl http://localhost:5434/v1/jobs \
  -H "X-API-Key: change-this-api-key"
```

### 3. 目录是否正确共享

至少确认两件事：

- Embed Service 能写宿主机 `./music-root`
- Navidrome 读取的也是这份 `./music-root`

## Echoes 里怎么配置

进入：

```text
侧边栏 -> 展开音乐库 -> 编辑音乐库 -> Embed Service 离线下载
```

填写：

| 字段 | 示例 |
| --- | --- |
| Embed Service URL | `http://192.168.1.10:5434` |
| API Key | `change-this-api-key` |
| Library ID | `default` |

然后点“测试连接”。

只要测试连接失败，就不要继续排下载问题，先把 URL 和 API Key 解决掉。

## 跑通后的最短验证

1. 在 Echoes 里进入“探索”
2. 切到远程搜索
3. 搜一首服务器里没有的歌
4. 加入离线下载队列
5. 打开“离线下载状态”
6. 等待任务完成
7. 回到 Navidrome 看新歌是否已经入库

## 最常见的坑

### 1. 把 Embed Service URL 填成 Navidrome URL

会直接导致测试连接失败或 401/404。

### 2. 端口填错

当前仓库里常见两种外部端口：

- `8080`
- `5434`

客户端里必须填你自己实际暴露出去的那个。

### 3. Navidrome 和 Embed Service 没共享同一份音乐目录

这是最常见的“任务成功但看不到歌”的原因。

### 4. `NAVIDROME_BASE_URL` 从容器内不可达

如果你在容器里写 `http://localhost:4533`，通常就是错的。容器内的 `localhost` 只代表它自己。

# Embed 部署教程

## 目的

本文说明如何部署 `gdstudio-embeded-service`，并将其接入 Echoes。

Embed Service 用于接收 Echoes 提交的离线导入任务，完成远程歌曲下载、标签写入、文件落盘以及 Navidrome 扫描触发。若仅使用 Navidrome 播放既有曲库，可不部署该服务。

## 目录映射要求

当前仓库默认配置中，Embed Service 的目标音乐目录如下：

```yaml
storage:
  music_dir: /music/library
```

若宿主机采用以下挂载：

```text
./music-root:/music
```

则最终文件路径为：

```text
./music-root/library/...
```

因此，Navidrome 必须读取同一份宿主机目录 `./music-root`。若目录不一致，导入完成后文件不会出现在 Navidrome 曲库中。

## 最小部署示例

以下示例假设 Navidrome 与 Embed Service 位于同一个 Compose 网络，且 Navidrome 服务名为 `navidrome`：

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

若 Navidrome 不在同一 Compose 网络，应将 `NAVIDROME_BASE_URL` 设置为容器内可访问的实际地址，例如：

```text
http://192.168.1.10:4533
```

## 启动步骤

```bash
docker compose up -d
docker compose logs -f embed-service
```

## 部署后验证

建议至少执行以下验证：

### 健康检查

```bash
curl http://localhost:5434/healthz
```

### API Key 验证

```bash
curl http://localhost:5434/v1/jobs \
  -H "X-API-Key: change-this-api-key"
```

### 目录共享验证

应确认以下两项：

- Embed Service 对宿主机 `./music-root` 具有写权限
- Navidrome 读取的音乐目录同样指向 `./music-root`

## Echoes 接入配置

在 Echoes 中进入以下路径：

```text
侧边栏 -> 展开音乐库 -> 编辑音乐库 -> Embed Service 离线下载
```

按下表填写：

| 字段 | 示例 |
| --- | --- |
| Embed Service URL | `http://192.168.1.10:5434` |
| API Key | `change-this-api-key` |
| Library ID | `default` |

完成后执行“测试连接”。若该步骤失败，应优先检查 URL、API Key 与端口配置，而不是继续排查任务执行问题。

## 功能验证

建议按以下顺序验证离线导入流程：

1. 在 Echoes 中进入“探索”
2. 切换到远程搜索
3. 搜索一首当前曲库中不存在的歌曲
4. 将其加入离线下载队列
5. 打开“离线下载状态”
6. 等待任务完成
7. 返回 Navidrome 验证新文件是否已入库

## 常见问题

### 将 Embed Service 地址误填为 Navidrome 地址

该错误通常会导致测试连接失败，或返回 `401` / `404`。

### 端口配置错误

当前仓库常见的外部端口为：

- `8080`
- `5434`

Echoes 中应填写实际对外暴露的端口。

### Navidrome 与 Embed Service 未共享同一宿主机音乐目录

该问题通常表现为任务成功，但 Navidrome 曲库中无法看到新文件。

### `NAVIDROME_BASE_URL` 对容器不可达

若在容器中填写 `http://localhost:4533`，通常表示配置错误。容器内的 `localhost` 仅指向当前容器自身。

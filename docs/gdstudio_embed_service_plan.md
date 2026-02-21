# GDStudio 嵌入下载微服务实施方案

## 1. 背景与目标

当前客户端离线下载仅保证拿到音频文件，无法稳定保证以下能力：

- 文件名规范化（适合直接入库）
- 元数据完整（标题、歌手、专辑、曲目号、年份等）
- 封面内嵌
- 歌词内嵌/落地
- 入库后快速可见（触发 Navidrome 扫描）

目标是新增一个 Docker 内运行的独立微服务，提供标准 API，供回响客户端提交任务：

- 输入：`source + trackId (+ quality/libraryId)`  
- 输出：可直接入 Navidrome 的“已刮削成品文件”
- 能力：下载、嵌入封面/歌词/元信息、入库、触发扫描、可观测

## 2. 范围定义

### 2.1 In Scope

- gdstudio 资源解析（url/pic/lyric/基础元信息）
- 文件下载到临时目录
- 音频文件元数据写入（MP3/FLAC）
- 原子移动到 Navidrome 音乐目录
- 触发 Navidrome 扫描与状态查询
- 任务状态 API、重试/取消 API
- 结构化日志与基础指标

### 2.2 Out of Scope（第一版）

- 实时转码
- 多租户隔离计费
- 复杂版权策略引擎
- Web 管理后台（仅 API + 日志）

## 3. 总体架构

```mermaid
flowchart LR
  A["回响客户端"] -->|POST /v1/jobs| B["Embed Service API"]
  B --> C["任务队列 Redis"]
  C --> D["Worker"]
  D --> E["GDStudio API"]
  D --> F["临时目录 /work/tmp"]
  D --> G["Tagger (MP3/FLAC)"]
  G --> H["目标音乐库 /music/library"]
  D --> I["Navidrome Subsonic API (startScan/getScanStatus)"]
  A -->|GET /v1/jobs/{id}| B
```

## 4. 模块设计

### 4.1 API 层（同步快速返回）

- 仅负责参数校验、幂等检查、任务入队、返回任务 ID
- 不执行耗时下载/写标签

### 4.2 任务执行层（Worker）

按状态机执行完整流程：

1. `resolving`：解析下载链接、封面、歌词、元信息  
2. `downloading`：下载到临时目录  
3. `tagging`：写入标签、封面、歌词  
4. `moving`：原子移动到最终目录  
5. `scanning`：触发 Navidrome 扫描并轮询  
6. `done/failed`：结束

### 4.3 存储层

- Redis：任务队列、短期状态、重试计数
- SQLite/PostgreSQL（建议）：任务历史与审计
- 文件系统挂载：
  - `/work/tmp`（临时）
  - `/music/library`（Navidrome 扫描目录）

### 4.4 GDStudio 接口定义（Worker 侧）

以下定义基于当前可观测行为与公开前端实现，建议在服务内统一做一层适配与标准化。

#### 4.4.1 API 入口与路由策略

- 主入口：`https://music.gdstudio.xyz/api.php`
- 可用镜像（按源路由）：
  - `https://music-api.gdstudio.xyz/api.php`
  - `https://music-api-cn.gdstudio.xyz/api.php`
  - `https://music-api-hk.gdstudio.xyz/api.php`
  - `https://music-api-us.gdstudio.xyz/api.php`

建议默认路由（可配置）：

- `netease / kuwo / tencent / spotify / bilibili / apple / tidal` -> 主入口
- `migu / kugou / ximalaya` -> `music-api-cn`
- `joox` -> `music-api-hk`
- `qobuz / ytmusic` -> `music-api-us`

#### 4.4.2 公共参数约定

- `types`：接口类型（`search` / `url` / `pic` / `lyric`）
- `source`：音乐源标识（如 `netease`、`kuwo`）
- `s`：签名字段（建议始终带上）
- `callback`：JSONP 回调（部分入口需要）
- `_`：时间戳（JSONP 场景常用）

签名 `s` 计算建议（与现有生态兼容）：

1. 取 `id_or_keyword`（按接口不同而不同）
2. 生成 `src = "{hostname}|{versionPadded}|{ts9}|{urlencode(id_or_keyword)}"`
3. `s = MD5(src)` 的后 8 位并转大写

说明：

- `versionPadded` 示例：`2025.11.4` -> `20251104`
- `ts9` 为毫秒时间戳前 9 位
- 若签名计算失败，可先重试一次无签名请求（兼容少量宽松入口）

#### 4.4.3 搜索接口 `types=search`

用途：搜索歌曲/专辑/歌手结果（由 `source` 与查询词决定）。

请求示例（歌曲/歌手）：

```text
types=search&count=30&source=netease&pages=1&name=Taylor%20Swift&s=6A0139A9
```

请求示例（专辑搜索）：

```text
types=search&count=30&source=netease_album&pages=1&name=The%20Dutchess%20-%20Fergie&s=4C927031
```

关键参数：

- `name`：关键词
- `count`：每页条数（建议 30）
- `pages`：页码（从 1 开始）
- `source`：可为 `xxx` 或 `xxx_album`

期望结果字段（标准化前）：

- `id`
- `name`
- `artist`（数组或字符串，需归一）
- `album`
- `source`
- `url_id`
- `pic_id`
- `lyric_id`

#### 4.4.4 解析播放/下载链接 `types=url`

用途：通过曲目标识获取可下载/可播放 URL。

请求示例：

```text
types=url&id=5084198&source=netease&br=999&s=XXXXXXXX
```

关键参数：

- `id`：歌曲唯一标识（通常来自 `search.id`）
- `br`：目标码率（建议降级顺序：`999 -> 740 -> 320 -> 192 -> 128`）

期望结果字段：

- `url`（可能为空或 `err`，需判失败）
- `br`
- `size`

#### 4.4.5 封面接口 `types=pic`

用途：通过 `pic_id` 获取封面 URL。

请求示例：

```text
types=pic&id=<pic_id>&source=netease&size=640&s=XXXXXXXX
```

期望结果字段：

- `url`

#### 4.4.6 歌词接口 `types=lyric`

用途：通过 `lyric_id` 获取歌词与翻译歌词。

请求示例：

```text
types=lyric&id=<lyric_id>&source=netease&s=XXXXXXXX
```

期望结果字段：

- `lyric`
- `tlyric`

#### 4.4.7 响应格式与标准化

服务内部必须统一以下差异：

- JSON 与 JSONP（如 `jQuery123(...json...)`）双格式兼容
- `artist` 数组/字符串兼容
- `url=err`、空对象、空字符串统一转为失败态
- 对外输出统一 DTO，不暴露上游原始差异

建议统一 DTO（内部）：

```json
{
  "trackId": "5084198",
  "source": "netease",
  "title": "Song Name",
  "artist": "Artist A, Artist B",
  "album": "Album Name",
  "downloadUrl": "https://...",
  "coverUrl": "https://...",
  "lyric": "...",
  "tlyric": "...",
  "bitrate": 320,
  "size": 12345678,
  "ext": "mp3"
}
```

#### 4.4.8 失败处理约定

- `search` 无结果：返回 `NO_RESULT`
- `url` 解析失败：返回 `URL_RESOLVE_FAILED`
- `pic/lyric` 失败：可降级为非致命 warning
- 上游超时/5xx：指数退避重试（建议 2~3 次）
- 镜像切换：同源失败后自动切换备用入口并记录日志

## 5. 标准 API 设计（供回响调用）

## 5.1 创建任务

`POST /v1/jobs`

请求体（建议）：

```json
{
  "source": "netease",
  "trackId": "5084198",
  "libraryId": "nas-main",
  "quality": "best",
  "idempotencyKey": "netease:5084198:nas-main",
  "pathPolicy": {
    "template": "{artist}/{album}/{trackNo} - {title}.{ext}"
  }
}
```

响应体：

```json
{
  "jobId": "job_01J....",
  "status": "queued"
}
```

## 5.2 查询任务

`GET /v1/jobs/{jobId}`

返回：

```json
{
  "jobId": "job_01J....",
  "status": "tagging",
  "progress": 62,
  "message": "writing id3 tags",
  "result": null,
  "error": null
}
```

## 5.3 重试任务

`POST /v1/jobs/{jobId}/retry`

## 5.4 取消任务

`POST /v1/jobs/{jobId}/cancel`

## 5.5 健康检查

`GET /healthz`

## 6. 元数据嵌入策略

### 6.1 MP3

- 写入 ID3v2：`title/artist/album/track/year/genre`
- 封面写入 APIC
- 歌词写入 USLT

### 6.2 FLAC

- 写入 VorbisComment：`TITLE/ARTIST/ALBUM/TRACKNUMBER/DATE`
- 封面写入 PICTURE Block
- 歌词：
  - 首选写 `LYRICS` 字段
  - 同时落地同名 `.lrc` 作为兼容兜底

### 6.3 失败降级

- 写标签失败：任务标记失败，保留临时文件供诊断（可配置自动清理）
- 封面/歌词失败：可配置为“非致命”，仍可入库，但记录 warning

## 7. 目录与原子入库策略

- 临时文件：`/work/tmp/{jobId}/raw.ext`
- 成品文件：`/work/tmp/{jobId}/final.ext`
- 最终路径：`/music/library/{artist}/{album}/{trackNo} - {title}.{ext}`
- 使用同分区 `rename` 原子移动，避免 Navidrome 扫到半成品

## 8. Navidrome 集成策略

- 完成移动后调用 `startScan`
- 按需轮询 `getScanStatus`（设置超时）
- 若扫描失败：任务可标记 `done_with_scan_warning`（不阻塞已入库文件）

## 9. 幂等与防重复

- `idempotencyKey` 唯一索引
- 若同 key 任务正在运行：返回已有 jobId
- 若同 key 已成功：可配置返回历史结果而非重复下载

## 10. 可观测性

### 10.1 日志字段（结构化）

- `jobId/source/trackId/libraryId/status/step/durationMs/errorCode`
- `downloadUrlHost/fileExt/fileSize/tagWriteResult/scanResult/finalPath`

### 10.2 指标（Prometheus）

- 任务总数、成功率、失败率
- 各阶段耗时（resolve/download/tag/move/scan）
- 重试次数分布
- 外部依赖错误率（gdstudio/navidrome）

## 11. 安全与运行约束

- API Key 鉴权（回响 -> 服务）
- 限流（按来源 IP/API Key）
- 路径白名单，防止路径穿越
- 下载 URL host allowlist（避免 SSRF）
- 容器以非 root 运行，最小权限挂载目录

## 12. Docker 部署建议

### 12.1 组件

- `embed-api`（FastAPI/Go API）
- `embed-worker`（同镜像不同启动参数）
- `redis`

### 12.2 挂载

- `/work/tmp`（读写）
- `/music/library`（读写，指向 Navidrome 扫描目录）

### 12.3 环境变量

- `GD_API_BASE`
- `NAVIDROME_BASE_URL`
- `NAVIDROME_USER/NAVIDROME_TOKEN`
- `REDIS_URL`
- `MAX_CONCURRENT_JOBS`
- `DOWNLOAD_TIMEOUT`

## 13. Go 技术栈选型

### 13.1 核心框架

- **Web 框架**：`Gin` (gin-gonic/gin) - 轻量、高性能、中间件丰富
- **任务队列**：`asynq` (hibiken/asynq) - Redis 支持、重试、调度、可视化
- **配置管理**：`viper` - 环境变量、配置文件、热重载
- **日志**：`zap` (uber-go/zap) - 结构化日志、高性能
- **数据库**：`gorm` + SQLite/PostgreSQL
- **HTTP 客户端**：`resty` (go-resty/resty) - 重试、超时、拦截器

### 13.2 音频处理

- **MP3 标签**：`go-taglib` (wtolson/go-taglib) - 基于 TagLib C++ 库
- **FLAC 标签**：`go-taglib` 同样支持
- **备选方案**：`tag` (dhowden/tag) - 纯 Go 实现，无需 C 依赖
- **图片处理**：`imaging` (disintegration/imaging) - 封面尺寸调整

### 13.3 存储与队列

- **Redis**：`go-redis/redis/v9` - 任务队列、状态缓存
- **数据库 ORM**：`gorm.io/gorm` - 任务历史持久化
- **数据库驱动**：
  - SQLite: `gorm.io/driver/sqlite`
  - PostgreSQL: `gorm.io/driver/postgres`

### 13.4 监控与可观测

- **指标**：`prometheus/client_golang` - Prometheus metrics
- **健康检查**：自定义 `/healthz` 和 `/readyz` 端点
- **追踪**：`opentelemetry-go` (可选)

### 13.5 项目结构

```
gdstudio-embeded-service/
├── cmd/
│   ├── api/          # API 服务入口
│   │   └── main.go
│   └── worker/       # Worker 进程入口
│       └── main.go
├── internal/
│   ├── api/          # API 层 (Gin handlers)
│   │   ├── handlers/
│   │   ├── middleware/
│   │   └── router.go
│   ├── worker/       # Worker 任务执行器
│   │   ├── tasks/
│   │   └── processor.go
│   ├── service/      # 业务逻辑层
│   │   ├── gdstudio/      # GDStudio API 客户端
│   │   ├── navidrome/     # Navidrome API 客户端
│   │   ├── tagger/        # 音频标签写入
│   │   └── job/           # 任务管理
│   ├── model/        # 数据模型
│   │   ├── job.go
│   │   └── track.go
│   ├── repository/   # 数据访问层
│   │   └── job_repo.go
│   └── config/       # 配置
│       └── config.go
├── pkg/              # 可复用的公共库
│   ├── logger/
│   └── errors/
├── configs/
│   └── config.yaml
├── scripts/
│   └── docker-compose.yml
├── Dockerfile
├── Makefile
├── go.mod
└── README.md
```

### 13.6 核心依赖清单

```go
// go.mod
module github.com/azin/gdstudio-embed-service

go 1.22

require (
    github.com/gin-gonic/gin v1.10.0
    github.com/hibiken/asynq v0.24.1
    github.com/go-resty/resty/v2 v2.11.0
    github.com/wtolson/go-taglib v0.0.0-20210406152913-79209c280058
    github.com/spf13/viper v1.18.2
    go.uber.org/zap v1.26.0
    gorm.io/gorm v1.25.7
    gorm.io/driver/sqlite v1.5.5
    gorm.io/driver/postgres v1.5.6
    github.com/redis/go-redis/v9 v9.4.0
    github.com/prometheus/client_golang v1.19.0
    github.com/google/uuid v1.6.0
)
```

## 14. 关键实现细节

### 14.1 任务状态机实现 (asynq)

```go
// internal/worker/tasks/download_task.go
type DownloadTask struct {
    JobID     string `json:"job_id"`
    Source    string `json:"source"`
    TrackID   string `json:"track_id"`
    LibraryID string `json:"library_id"`
    Quality   string `json:"quality"`
}

func (t *DownloadTask) ProcessTask(ctx context.Context, task *asynq.Task) error {
    // 状态机流程
    stages := []struct {
        name string
        fn   func(context.Context) error
    }{
        {"resolving", t.resolveMetadata},
        {"downloading", t.downloadAudio},
        {"tagging", t.writeMetadata},
        {"moving", t.moveToLibrary},
        {"scanning", t.triggerScan},
    }

    for _, stage := range stages {
        if err := t.updateStatus(stage.name); err != nil {
            return err
        }
        if err := stage.fn(ctx); err != nil {
            return fmt.Errorf("%s failed: %w", stage.name, err)
        }
    }

    return t.updateStatus("done")
}
```

### 14.2 GDStudio 客户端（签名计算）

```go
// internal/service/gdstudio/client.go
import (
    "crypto/md5"
    "fmt"
    "time"
)

type Client struct {
    baseURL string
    client  *resty.Client
}

func (c *Client) generateSignature(id string) string {
    hostname := "music.gdstudio.xyz"
    version := "20251104" // 2025.11.4 -> 20251104
    ts9 := fmt.Sprintf("%d", time.Now().UnixMilli())[:9]
    src := fmt.Sprintf("%s|%s|%s|%s", hostname, version, ts9, url.QueryEscape(id))

    hash := md5.Sum([]byte(src))
    full := fmt.Sprintf("%x", hash)
    return strings.ToUpper(full[len(full)-8:]) // 后 8 位大写
}

func (c *Client) ResolveURL(source, trackID string, br int) (*URLResult, error) {
    sig := c.generateSignature(trackID)

    resp, err := c.client.R().
        SetQueryParams(map[string]string{
            "types":  "url",
            "source": source,
            "id":     trackID,
            "br":     fmt.Sprintf("%d", br),
            "s":      sig,
        }).
        SetResult(&URLResult{}).
        Get("/api.php")

    if err != nil {
        return nil, err
    }

    result := resp.Result().(*URLResult)
    if result.URL == "" || result.URL == "err" {
        return nil, fmt.Errorf("url resolution failed")
    }

    return result, nil
}
```

### 14.3 音频标签写入 (taglib)

```go
// internal/service/tagger/mp3.go
/*
#cgo pkg-config: taglib
#include <taglib/tag_c.h>
*/
import "C"

func WriteMP3Tags(filePath string, meta *Metadata) error {
    cPath := C.CString(filePath)
    defer C.free(unsafe.Pointer(cPath))

    file := C.taglib_file_new(cPath)
    if file == nil {
        return fmt.Errorf("failed to open file")
    }
    defer C.taglib_file_free(file)

    tag := C.taglib_file_tag(file)

    // 写入基础标签
    C.taglib_tag_set_title(tag, C.CString(meta.Title))
    C.taglib_tag_set_artist(tag, C.CString(meta.Artist))
    C.taglib_tag_set_album(tag, C.CString(meta.Album))
    C.taglib_tag_set_track(tag, C.uint(meta.TrackNumber))
    C.taglib_tag_set_year(tag, C.uint(meta.Year))

    // 保存
    if C.taglib_file_save(file) == 0 {
        return fmt.Errorf("failed to save tags")
    }

    // 嵌入封面和歌词需要使用 ID3v2 特定 API
    return embedCoverAndLyrics(filePath, meta.CoverData, meta.Lyrics)
}
```

### 14.4 幂等性实现

```go
// internal/api/handlers/job.go
func (h *Handler) CreateJob(c *gin.Context) {
    var req CreateJobRequest
    if err := c.ShouldBindJSON(&req); err != nil {
        c.JSON(400, gin.H{"error": err.Error()})
        return
    }

    // 生成幂等 key
    idempotencyKey := fmt.Sprintf("%s:%s:%s",
        req.Source, req.TrackID, req.LibraryID)

    // 检查是否已存在
    existing, err := h.repo.FindByIdempotencyKey(idempotencyKey)
    if err == nil && existing != nil {
        // 已存在，直接返回
        c.JSON(200, gin.H{
            "job_id": existing.ID,
            "status": existing.Status,
            "message": "job already exists",
        })
        return
    }

    // 创建新任务
    job := &model.Job{
        ID:             uuid.New().String(),
        IdempotencyKey: idempotencyKey,
        Source:         req.Source,
        TrackID:        req.TrackID,
        Status:         "queued",
    }

    if err := h.repo.Create(job); err != nil {
        c.JSON(500, gin.H{"error": "failed to create job"})
        return
    }

    // 入队
    task := asynq.NewTask("download", job.Payload())
    h.queue.Enqueue(task)

    c.JSON(200, gin.H{
        "job_id": job.ID,
        "status": job.Status,
    })
}
```

### 14.5 Navidrome 集成

```go
// internal/service/navidrome/client.go
type Client struct {
    baseURL  string
    username string
    token    string // MD5(password + salt) 或 API Key
    salt     string
}

func (c *Client) StartScan() error {
    resp, err := c.client.R().
        SetQueryParams(c.authParams()).
        SetQueryParam("u", c.username).
        Get(c.baseURL + "/rest/startScan")

    if err != nil {
        return err
    }

    if resp.StatusCode() != 200 {
        return fmt.Errorf("scan failed: %s", resp.Status())
    }

    return nil
}

func (c *Client) GetScanStatus() (*ScanStatus, error) {
    var result struct {
        SubsonicResponse struct {
            ScanStatus ScanStatus `json:"scanStatus"`
        } `json:"subsonic-response"`
    }

    _, err := c.client.R().
        SetQueryParams(c.authParams()).
        SetResult(&result).
        Get(c.baseURL + "/rest/getScanStatus")

    return &result.SubsonicResponse.ScanStatus, err
}

func (c *Client) authParams() map[string]string {
    return map[string]string{
        "u": c.username,
        "t": c.token,
        "s": c.salt,
        "v": "1.16.1",
        "c": "echo-embed",
        "f": "json",
    }
}
```

## 15. 版本里程碑

### M1（最小可用）

- [x] Go 项目脚手架 (Gin + asynq + zap)
- [ ] 单曲任务 API（POST /v1/jobs, GET /v1/jobs/:id）
- [ ] GDStudio 客户端（search/url/pic/lyric + 签名）
- [ ] Worker 下载流程（download + temp storage）
- [ ] MP3 标签写入（taglib 集成）
- [ ] 文件移动到 Navidrome 目录
- [ ] Navidrome startScan 调用
- [ ] 基础日志（zap structured logging）

### M2（增强）

- [ ] FLAC 标签支持 + `.lrc` 歌词文件
- [ ] 幂等性实现（idempotency key + DB 唯一索引）
- [ ] 任务重试 API（POST /v1/jobs/:id/retry）
- [ ] 任务取消 API（POST /v1/jobs/:id/cancel）
- [ ] Prometheus 指标（任务成功率、耗时、队列长度）
- [ ] 健康检查端点（/healthz, /readyz）

### M3（生产化）

- [ ] 批量任务 API（POST /v1/jobs/batch）
- [ ] 封面/歌词失败非致命配置
- [ ] 多镜像路由策略（CN/HK/US）
- [ ] 高可用部署（多 worker + Redis Sentinel）
- [ ] 备份策略（失败任务归档）
- [ ] Grafana Dashboard 模板

## 14. 验收标准

- 单曲成功链路：提交到可在 Navidrome 可见 <= 60 秒（常规网络）
- 元数据完整率 >= 95%
- 任务失败可重试率 100%
- API 幂等：同 key 不产生重复文件

## 15. 风险与对策

- gdstudio 接口波动：多源重试 + 熔断 + 降级策略  
- 大文件写标签慢：并发阈值与队列背压  
- 扫描延迟：增量扫描 + 轮询超时后的异步补偿  

---

该方案默认“服务器端完成所有重活”，客户端只做任务发起与状态展示，能最大化稳定性与一致性。

## 16. Docker 部署配置

### 16.1 Dockerfile

```dockerfile
# 多阶段构建
FROM golang:1.22-alpine AS builder

# 安装 taglib 开发库
RUN apk add --no-cache gcc musl-dev pkgconfig taglib-dev

WORKDIR /build
COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN CGO_ENABLED=1 GOOS=linux go build -o api ./cmd/api
RUN CGO_ENABLED=1 GOOS=linux go build -o worker ./cmd/worker

# 运行阶段
FROM alpine:latest

RUN apk add --no-cache ca-certificates taglib

WORKDIR /app
COPY --from=builder /build/api .
COPY --from=builder /build/worker .
COPY configs/config.yaml ./configs/

EXPOSE 8080

# 默认启动 API，可通过 CMD 覆盖启动 worker
CMD ["./api"]
```

### 16.2 docker-compose.yml

```yaml
version: '3.8'

services:
  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"
    volumes:
      - redis-data:/data
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 10s
      timeout: 3s
      retries: 3

  postgres:
    image: postgres:16-alpine
    environment:
      POSTGRES_DB: embed_service
      POSTGRES_USER: embed
      POSTGRES_PASSWORD: embed_pass
    volumes:
      - postgres-data:/var/lib/postgresql/data
    ports:
      - "5432:5432"
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U embed"]
      interval: 10s
      timeout: 3s
      retries: 3

  api:
    build: .
    ports:
      - "8080:8080"
    environment:
      - REDIS_URL=redis://redis:6379
      - DATABASE_URL=postgres://embed:embed_pass@postgres:5432/embed_service?sslmode=disable
      - GD_API_BASE=https://music-api.gdstudio.xyz
      - NAVIDROME_BASE_URL=http://navidrome:4533
      - NAVIDROME_USER=admin
      - NAVIDROME_TOKEN=${NAVIDROME_TOKEN}
      - LOG_LEVEL=info
    volumes:
      - /path/to/navidrome/music:/music:rw
      - /tmp/embed-work:/work:rw
    depends_on:
      redis:
        condition: service_healthy
      postgres:
        condition: service_healthy
    restart: unless-stopped

  worker:
    build: .
    command: ["./worker"]
    environment:
      - REDIS_URL=redis://redis:6379
      - DATABASE_URL=postgres://embed:embed_pass@postgres:5432/embed_service?sslmode=disable
      - GD_API_BASE=https://music-api.gdstudio.xyz
      - NAVIDROME_BASE_URL=http://navidrome:4533
      - NAVIDROME_USER=admin
      - NAVIDROME_TOKEN=${NAVIDROME_TOKEN}
      - MAX_CONCURRENT_JOBS=3
      - DOWNLOAD_TIMEOUT=600
      - LOG_LEVEL=info
    volumes:
      - /path/to/navidrome/music:/music:rw
      - /tmp/embed-work:/work:rw
    depends_on:
      redis:
        condition: service_healthy
      postgres:
        condition: service_healthy
    restart: unless-stopped
    deploy:
      replicas: 2  # 可水平扩展

  # 可选：asynq web UI
  asynqmon:
    image: hibiken/asynqmon:latest
    ports:
      - "8090:8080"
    environment:
      - REDIS_ADDR=redis:6379
    depends_on:
      - redis

  # 可选：Prometheus + Grafana
  prometheus:
    image: prom/prometheus:latest
    ports:
      - "9090:9090"
    volumes:
      - ./configs/prometheus.yml:/etc/prometheus/prometheus.yml
      - prometheus-data:/prometheus
    command:
      - '--config.file=/etc/prometheus/prometheus.yml'

volumes:
  redis-data:
  postgres-data:
  prometheus-data:
```

### 16.3 配置文件示例

```yaml
# configs/config.yaml
server:
  port: 8080
  mode: release  # debug / release

gdstudio:
  base_url: https://music-api.gdstudio.xyz
  mirrors:
    cn: https://music-api-cn.gdstudio.xyz
    hk: https://music-api-hk.gdstudio.xyz
    us: https://music-api-us.gdstudio.xyz
  timeout: 15s
  retry_count: 2

navidrome:
  base_url: http://localhost:4533
  username: admin
  password: admin  # 或使用环境变量
  api_version: 1.16.1
  scan_timeout: 300s

storage:
  work_dir: /work/tmp
  music_dir: /music/library
  path_template: "{artist}/{album}/{trackNo:02d} - {title}.{ext}"
  allowed_extensions: [mp3, flac, m4a]

worker:
  max_concurrent: 3
  download_timeout: 600s
  tag_write_timeout: 30s
  move_timeout: 10s
  scan_timeout: 300s
  retry_max_attempts: 3
  retry_delay: 10s

database:
  driver: postgres  # sqlite / postgres
  dsn: "postgres://embed:embed_pass@localhost:5432/embed_service?sslmode=disable"
  # dsn: "file:embed.db?cache=shared&mode=rwc"
  max_idle_conns: 10
  max_open_conns: 100
  conn_max_lifetime: 3600s

redis:
  url: redis://localhost:6379
  db: 0
  max_retries: 3

security:
  api_keys:
    - key: "your-api-key-here"
      name: "echo-client"
  rate_limit:
    enabled: true
    requests_per_minute: 60
  allowed_download_hosts:
    - "*.163.com"
    - "*.kuwo.cn"
    - "*.gdstudio.xyz"
    - "*.qq.com"

logging:
  level: info  # debug / info / warn / error
  format: json  # json / console
  output: stdout  # stdout / file
  file_path: /var/log/embed-service.log

metrics:
  enabled: true
  port: 9091
  path: /metrics
```

## 17. Makefile

```makefile
.PHONY: help build run test docker-build docker-up docker-down migrate-up migrate-down

help:
	@echo "可用命令："
	@echo "  make build          - 构建 API 和 Worker 二进制"
	@echo "  make run-api        - 运行 API 服务"
	@echo "  make run-worker     - 运行 Worker"
	@echo "  make test           - 运行测试"
	@echo "  make docker-build   - 构建 Docker 镜像"
	@echo "  make docker-up      - 启动 Docker Compose"
	@echo "  make docker-down    - 停止 Docker Compose"
	@echo "  make migrate-up     - 运行数据库迁移"

build:
	CGO_ENABLED=1 go build -o bin/api ./cmd/api
	CGO_ENABLED=1 go build -o bin/worker ./cmd/worker

run-api:
	go run ./cmd/api/main.go

run-worker:
	go run ./cmd/worker/main.go

test:
	go test -v -race -coverprofile=coverage.out ./...

docker-build:
	docker build -t gdstudio-embed-service:latest .

docker-up:
	docker-compose up -d

docker-down:
	docker-compose down

docker-logs:
	docker-compose logs -f api worker

migrate-up:
	go run ./cmd/migrate/main.go up

migrate-down:
	go run ./cmd/migrate/main.go down

clean:
	rm -rf bin/
	rm -f coverage.out

lint:
	golangci-lint run ./...

proto:
	# 如果使用 gRPC
	protoc --go_out=. --go-grpc_out=. api/proto/*.proto
```

## 18. 部署步骤

### 18.1 本地开发环境

```bash
# 1. 安装依赖
brew install taglib  # macOS
# sudo apt-get install libtag1-dev  # Ubuntu

# 2. 初始化项目
cd /Users/azin/PycharmProjects/gdstudio-embeded-service
go mod init github.com/azin/gdstudio-embed-service
go mod tidy

# 3. 启动 Redis
docker run -d -p 6379:6379 redis:7-alpine

# 4. 运行 API
make run-api

# 5. 运行 Worker（另开终端）
make run-worker
```

### 18.2 生产环境部署

```bash
# 1. 配置环境变量
cp .env.example .env
# 编辑 .env 填入 NAVIDROME_TOKEN 等敏感信息

# 2. 启动服务
docker-compose up -d

# 3. 查看日志
docker-compose logs -f api worker

# 4. 健康检查
curl http://localhost:8080/healthz

# 5. 提交测试任务
curl -X POST http://localhost:8080/v1/jobs \
  -H "Content-Type: application/json" \
  -H "X-API-Key: your-api-key-here" \
  -d '{
    "source": "netease",
    "trackId": "5084198",
    "libraryId": "default",
    "quality": "best"
  }'
```

## 19. 后续优化方向

### 19.1 性能优化
- 并发下载（分片下载大文件）
- 本地封面缓存（减少重复下载）
- 增量扫描 API（仅扫描新增目录）
- Redis 集群模式（高可用）

### 19.2 功能扩展
- 支持专辑批量下载
- 歌词翻译合并（中英双语）
- 自定义文件名模板
- WebDAV/FTP 上传支持
- 多音乐库管理

### 19.3 运维增强
- Grafana Dashboard 模板
- 告警规则配置（PagerDuty/钉钉/飞书）
- 自动化测试（集成测试 + E2E）
- CI/CD Pipeline（GitHub Actions）
- 备份恢复策略

---

## 附录 A：回响客户端集成示例

### Flutter 客户端调用

```dart
// lib/data/sources/remote/embed_service_client.dart
class EmbedServiceClient {
  final Dio _dio;
  final String baseUrl;
  final String apiKey;

  EmbedServiceClient({
    required this.baseUrl,
    required this.apiKey,
  }) : _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 10),
          headers: {'X-API-Key': apiKey},
        ));

  Future<String> submitDownloadJob({
    required String source,
    required String trackId,
    required String libraryId,
    String quality = 'best',
  }) async {
    final response = await _dio.post(
      '/v1/jobs',
      data: {
        'source': source,
        'trackId': trackId,
        'libraryId': libraryId,
        'quality': quality,
        'idempotencyKey': '$source:$trackId:$libraryId',
      },
    );

    return response.data['job_id'];
  }

  Future<JobStatus> getJobStatus(String jobId) async {
    final response = await _dio.get('/v1/jobs/$jobId');
    return JobStatus.fromJson(response.data);
  }

  Future<void> retryJob(String jobId) async {
    await _dio.post('/v1/jobs/$jobId/retry');
  }

  Future<void> cancelJob(String jobId) async {
    await _dio.post('/v1/jobs/$jobId/cancel');
  }
}

class JobStatus {
  final String jobId;
  final String status;  // queued/downloading/tagging/moving/scanning/done/failed
  final int? progress;  // 0-100
  final String? message;
  final String? error;
  final DateTime createdAt;
  final DateTime updatedAt;

  JobStatus.fromJson(Map<String, dynamic> json)
      : jobId = json['job_id'],
        status = json['status'],
        progress = json['progress'],
        message = json['message'],
        error = json['error'],
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']);
}
```

### UI 集成示例

```dart
// 在现有的 SongOptionsSheet 中添加
Future<void> _downloadToNavidrome(Song song) async {
  try {
    final embedClient = ref.read(embedServiceClientProvider);
    
    // 提交任务
    final jobId = await embedClient.submitDownloadJob(
      source: song.previewSource!,
      trackId: song.previewTrackId!,
      libraryId: 'default',
    );

    // 显示进度对话框
    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => _DownloadProgressDialog(jobId: jobId),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('下载失败: $e')),
    );
  }
}

class _DownloadProgressDialog extends ConsumerStatefulWidget {
  final String jobId;
  const _DownloadProgressDialog({required this.jobId});

  @override
  ConsumerState<_DownloadProgressDialog> createState() => _DownloadProgressDialogState();
}

class _DownloadProgressDialogState extends ConsumerState<_DownloadProgressDialog> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startPolling();
  }

  void _startPolling() {
    _timer = Timer.periodic(const Duration(seconds: 2), (_) async {
      try {
        final client = ref.read(embedServiceClientProvider);
        final status = await client.getJobStatus(widget.jobId);

        if (status.status == 'done') {
          _timer?.cancel();
          if (!mounted) return;
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('下载完成，已添加到音乐库')),
          );
        } else if (status.status == 'failed') {
          _timer?.cancel();
          if (!mounted) return;
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('下载失败: ${status.error}')),
          );
        }
      } catch (e) {
        _timer?.cancel();
        if (!mounted) return;
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('查询状态失败: $e')),
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('下载中...'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          StreamBuilder<JobStatus>(
            stream: _pollJobStatus(),
            builder: (ctx, snapshot) {
              if (!snapshot.hasData) return const SizedBox();
              final status = snapshot.data!;
              return Column(
                children: [
                  Text(status.message ?? status.status),
                  if (status.progress != null)
                    LinearProgressIndicator(value: status.progress! / 100),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Stream<JobStatus> _pollJobStatus() async* {
    while (true) {
      try {
        final client = ref.read(embedServiceClientProvider);
        final status = await client.getJobStatus(widget.jobId);
        yield status;
      } catch (_) {}
      await Future.delayed(const Duration(seconds: 2));
    }
  }
}
```

---

## 附录 B：API 接口详细规范

### POST /v1/jobs

**请求**：
```json
{
  "source": "netease",           // 必填：音乐源
  "trackId": "5084198",          // 必填：曲目 ID
  "libraryId": "default",        // 必填：音乐库 ID
  "quality": "best",             // 可选：best/high/medium/low，默认 best
  "idempotencyKey": "...",       // 可选：幂等键，建议格式 source:trackId:libraryId
  "pathPolicy": {                // 可选：路径策略
    "template": "{artist}/{album}/{trackNo:02d} - {title}.{ext}"
  }
}
```

**响应** (200 OK)：
```json
{
  "job_id": "job_01J6X...",
  "status": "queued",
  "message": "job created successfully"
}
```

### GET /v1/jobs/:id

**响应** (200 OK)：
```json
{
  "job_id": "job_01J6X...",
  "status": "tagging",           // queued/resolving/downloading/tagging/moving/scanning/done/failed
  "progress": 62,                // 0-100
  "message": "writing id3 tags",
  "created_at": "2026-02-19T10:30:00Z",
  "updated_at": "2026-02-19T10:30:25Z",
  "result": {                    // status=done 时存在
    "file_path": "/music/library/Taylor Swift/1989/01 - Shake It Off.mp3",
    "file_size": 12345678,
    "duration": 219,
    "bitrate": 320
  },
  "error": null                  // status=failed 时存在
}
```

### POST /v1/jobs/:id/retry

**响应** (200 OK)：
```json
{
  "job_id": "job_01J6X...",
  "status": "queued",
  "message": "job queued for retry"
}
```

### POST /v1/jobs/:id/cancel

**响应** (200 OK)：
```json
{
  "job_id": "job_01J6X...",
  "status": "cancelled",
  "message": "job cancelled successfully"
}
```

### GET /healthz

**响应** (200 OK)：
```json
{
  "status": "healthy",
  "version": "1.0.0",
  "uptime": 3600,
  "components": {
    "redis": "healthy",
    "database": "healthy",
    "gdstudio_api": "healthy"
  }
}
```

---

**技术栈总结**：Go + Gin + asynq + taglib + Redis + PostgreSQL + Docker

**预计开发周期**：
- M1（最小可用）：2-3 周
- M2（增强）：1-2 周
- M3（生产化）：2-3 周

该方案默认"服务器端完成所有重活"，客户端只做任务发起与状态展示，能最大化稳定性与一致性。

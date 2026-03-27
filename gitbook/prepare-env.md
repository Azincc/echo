# 环境准备

## 最低准备项

| 项目 | 用途 |
| --- | --- |
| Docker / Docker Compose | 部署 Navidrome 和 Embed Service |
| Flutter SDK | 本地运行或开发 Echoes 客户端 |
| Go 1.22+ | 仅在本地开发 Embed Service 时需要 |
| 一份可持久化的音乐目录 | Navidrome 读取，Embed Service 写入 |
| 一个可访问的 Navidrome 账号 | Echoes 登录与 Embed Service 扫描都要用 |

## 推荐目录结构

建议先在宿主机准备一套固定目录，例如：

```text
music-stack/
  navidrome-data/
  music-root/
  embed-work/
  echo/
```

建议含义如下：

- `navidrome-data/`：Navidrome 的数据库与缓存
- `music-root/`：音乐文件根目录
- `embed-work/`：Embed Service 的工作目录、SQLite 和临时文件
- `echo/`：当前 Flutter 客户端仓库

## 推荐端口

| 服务 | 容器内默认端口 | 推荐宿主机端口 |
| --- | --- | --- |
| Navidrome | `4533` | `4533` |
| Embed Service | `8080` | `5434` 或 `8080` |

说明：

- 本仓库的 `gdstudio-embeded-service/docker-compose.yml` 使用 `8080:8080`。
- 本仓库的 `gdstudio-embeded-service/docker-compose.prod.yml` 使用 `5434:8080`。
- 客户端只关心你最终填写的外部地址，比如 `http://192.168.1.10:5434`。

## 路径规划建议

如果你准备同时使用 Navidrome 和 Embed Service，建议优先统一以下几件事：

- Navidrome 读取的宿主机音乐目录是什么
- Embed Service 写入的宿主机音乐目录是什么
- 两个容器看到的是不是同一份文件

只要这三件事一致，离线导入完成后 Navidrome 才能立即扫到新文件。

## 启动前检查清单

- 宿主机目录已经创建
- 运行 Docker 的用户对宿主机目录有读写权限
- Navidrome 端口没有被占用
- Embed Service 端口没有被占用
- 如果用公网访问，反向代理和 HTTPS 已经准备好
- 如果只在局域网使用，确认客户端可以访问服务器 IP

# 快速上手

这页只讲最短路径，目标是在最少步骤下把项目跑通。

## 场景一：我只想正常听歌

按下面顺序做：

1. 部署 Navidrome
2. 启动 Echoes 客户端
3. 在客户端里登录 Navidrome

对应文档：

- [部署 Navidrome](deploy-navidrome.md)
- [运行客户端](run-client.md)
- [首次登录与音乐库配置](login-and-library.md)

## 场景二：我还想把远程歌曲导入到服务器

按下面顺序做：

1. 先完成 Navidrome 部署并确认能正常播放
2. 再部署 `gdstudio-embeded-service`
3. 在 Echoes 的音乐库编辑页里配置 Embed Service
4. 到“探索”页搜索远程歌曲并加入离线下载队列

对应文档：

- [部署 Navidrome](deploy-navidrome.md)
- [部署 Embed Service](deploy-embed-service.md)
- [首次登录与音乐库配置](login-and-library.md)
- [下载与离线导入](download-and-offline.md)

## 最短部署清单

### Navidrome

```yaml
services:
  navidrome:
    image: deluan/navidrome:latest
    ports:
      - "4533:4533"
    volumes:
      - ./navidrome-data:/data
      - ./music-root:/music:ro
```

启动后访问：

```text
http://<你的服务器IP>:4533
```

### Embed Service

```yaml
services:
  embed-service:
    image: ghcr.io/azincc/gdstudio-embeded-service:latest
    ports:
      - "5434:8080"
    environment:
      NAVIDROME_BASE_URL: http://navidrome:4533
      NAVIDROME_USER: admin
      NAVIDROME_PASSWORD: change-me
      API_KEY: change-this-api-key
    volumes:
      - ./music-root:/music:rw
      - ./embed-work/work:/work:rw
```

健康检查：

```bash
curl http://localhost:5434/healthz
```

## 客户端里怎么填

### 登录 Navidrome

- 服务器地址：`http://<服务器IP>:4533`
- 用户名：你的 Navidrome 用户名
- 密码或 API Key：按你的服务端配置填写

### 配置 Embed Service

在“编辑音乐库 -> Embed Service 离线下载”里填写：

- Embed Service URL：`http://<服务器IP>:5434`
- API Key：`change-this-api-key`
- Library ID：`default`

## 第一次建议验证什么

- Navidrome 能否在浏览器中打开
- Echoes 能否成功登录并播放一首歌
- Embed Service 的 `/healthz` 是否返回正常
- Embed Service 测试连接是否通过
- 远程歌曲加入离线队列后，是否能在 Navidrome 中扫出来

## 下一步

- 想理解整体关系，看[系统架构](architecture.md)
- 想详细看功能，看[功能使用说明](feature-guide.md)
- 出现异常，直接看[常见问题与排障](troubleshooting.md)

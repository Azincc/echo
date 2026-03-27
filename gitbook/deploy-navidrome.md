# 部署 Navidrome

## 目标

先把 Navidrome 跑起来，并确认它能正常读取音乐目录、提供 Subsonic/OpenSubsonic API。

## 推荐方式

推荐直接使用 Docker。官方安装文档见：

- <https://www.navidrome.org/docs/installation/docker/>
- <https://www.navidrome.org/docs/usage/configuration/options/>

## 示例目录

假设你的宿主机目录如下：

```text
music-stack/
  navidrome-data/
  music-root/
```

## 示例 `docker-compose.yml`

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
```

说明：

- `/data` 用来存放 Navidrome 的数据库、缓存和配置。
- `/music` 是 Navidrome 的音乐目录。
- 在 Linux 上建议显式设置 `user`，避免文件权限问题。
- 如果你的音乐目录需要让 Embed Service 写入，Navidrome 这一侧仍然建议保持 `:ro` 只读挂载。

## 启动

```bash
docker compose up -d
docker compose logs -f navidrome
```

浏览器访问：

```text
http://<服务器IP或域名>:4533
```

首次访问时，按页面提示完成初始化即可。

## 与 Echoes 的关系

Echoes 登录时需要填写的“服务器地址”，就是 Navidrome 的访问地址，例如：

- `http://192.168.1.10:4533`
- `https://music.example.com`

## 与 Embed Service 的关系

如果你后续要开启离线导入：

- Navidrome 与 Embed Service 必须能看到同一份宿主机音乐目录
- Embed Service 完成下载后会调用 Navidrome 的扫描接口

只要目录映射一致，新文件就会在扫描后进入音乐库。

## 建议

- 局域网环境优先用 HTTPS 反向代理，实在不方便再使用 HTTP
- 如果你有内网和外网两套地址，后续可在 Echoes 里把它们都加到同一个音乐库下
- 先确认 Navidrome 单独可用，再继续部署 Embed Service

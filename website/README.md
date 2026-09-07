# Echoes 产品官网

中英文产品展示与下载页面：中文 `/`，英文 `/en/`，可直接切换语言。深色界面、Echo 绿色和真实应用截图保持一致；英文页面中的应用截图仍为中文界面。使用原生 HTML、CSS、JavaScript 和 Node.js 内置模块，无需安装 npm 依赖。

正式站点地址配置为 **https://echoesmusic.app/**，支持 Cloudflare Pages 静态托管和 Docker 自托管。本仓库提供发布配置；实际公网部署、镜像发布和域名生效以工作流与托管平台的结果为准。

## 本地预览与构建

推荐 Node.js 22 LTS（最低 18）。在仓库根目录运行：

```bash
node website/serve.mjs
```

访问[中文页面](http://localhost:4311/)或[英文页面](http://localhost:4311/en/)。预览服务只监听本机，启动时自动构建 `website/dist/`。修改源文件后执行 `node website/build.mjs` 并刷新浏览器，或重启服务；没有自动监听与热更新。

通过 `PORT` 环境变量修改预览端口，例如 PowerShell：

```powershell
$env:PORT = '4312'
node website/serve.mjs
```

生成发布产物并执行核心检查：

```bash
node website/build.mjs
node website/check.mjs
```

检查覆盖双语页面结构、SEO 元数据、本地资源与锚点链接、截图替代文本等必要内容。它不替代浏览器操作或完整无障碍审核。

**发布 `website/dist/` 内的内容。** HTML 源文件只有基础元数据，完整 SEO 由构建脚本注入，直接上传源码会漏掉这些发布产物。

## Cloudflare Pages 发布

官网工作流为 [`../.github/workflows/deploy_website.yml`](../.github/workflows/deploy_website.yml)，与 Flutter 客户端的 [`build_web.yml`](../.github/workflows/build_web.yml) 独立。

### 方式一：GitHub Actions 上传

1. 在 Cloudflare **Workers & Pages** 中创建一个 Pages **Direct Upload** 项目，生产分支使用 `main`。工作流使用已有项目，不会自动创建云资源。
2. 在 GitHub 仓库 **Settings → Secrets and variables → Actions** 配置以下值。

| 类型 | 名称 | 值 |
| --- | --- | --- |
| Secret | `CLOUDFLARE_API_TOKEN` | 具有目标账户 **Cloudflare Pages: Edit** 权限的 API Token |
| Secret | `CLOUDFLARE_ACCOUNT_ID` | Pages 项目所属的 Cloudflare Account ID |
| Variable | `CLOUDFLARE_PAGES_PROJECT` | 上一步创建的 Pages 项目名称 |
| Variable（可选） | `WEBSITE_SITE_URL` | 公开站点地址，默认 `https://echoesmusic.app/` |

3. 将官网改动推送到 `main`，或在 Actions 中选择 `main` 手动运行 **Publish Echoes Website**。
4. 在 Pages 项目的 **Custom domains** 中添加 `echoesmusic.app`，完成下方域名步骤。

向 `main` 推送 `website/**` 或官网工作流改动时，自动构建并发布 Pages 和 GHCR 镜像。未设置 `CLOUDFLARE_PAGES_PROJECT` 时，工作流跳过 Pages 上传，仍可发布镜像；设置项目名称后，缺少所需密钥会报错。面向 `main` 的相关 Pull Request 只执行构建与检查，不发布页面或镜像。CI 使用 Node.js 22，检查静态产物，构建 `linux/amd64` 与 `linux/arm64` 镜像，并验证 Nginx 配置和原生架构容器的 HTTP 路由。

官方参考：[通过 CI 使用 Direct Upload](https://developers.cloudflare.com/pages/how-to/use-direct-upload-with-continuous-integration/)。

### 方式二：Cloudflare Git 集成

也可在 Cloudflare Pages 直接连接 GitHub 仓库，使用以下设置：

| 设置 | 值 |
| --- | --- |
| Production branch | `main` |
| Framework preset | None |
| Root directory | 仓库根目录（默认） |
| Build command | `node website/build.mjs` |
| Build output directory | `website/dist` |
| Environment variable | `NODE_VERSION=22` |
| Environment variable | `SITE_URL=https://echoesmusic.app/` |

若将 Root directory 设置为 `website`，则 Build command 改为 `node build.mjs`，Build output directory 改为 `dist`。

Git 集成与 Actions Direct Upload 选择一种负责 Pages 部署，避免同一提交重复发布。选择 Git 集成时，保持仓库变量 `CLOUDFLARE_PAGES_PROJECT` 未设置，以跳过 Actions 的 Pages 上传；GHCR 镜像发布仍可由 Actions 负责。

### 正式域名与 HTTPS

在 Pages 项目 **Custom domains** 中先添加 `echoesmusic.app`，再按 Cloudflare 引导完成 DNS 绑定。该域名的 DNS 已托管于 Cloudflare，可由界面引导添加或确认记录；已有同名记录应先确认其用途。不能只添加 DNS CNAME 而跳过 Pages 项目域名绑定。

等待自定义域名与证书状态正常后，通过 `https://echoesmusic.app/` 访问。`.app` 域名要求有效 HTTPS。仓库文件不能代替平台域名配置；本次代码改动没有修改 Cloudflare DNS、创建 Pages 项目或上传站点。

正式地址变化时，Actions 部署更新仓库变量 `WEBSITE_SITE_URL`；Git 集成更新构建环境变量 `SITE_URL`，然后重新部署。

## Docker 跨平台部署

镜像使用非 root Nginx，监听容器内 `8080`，提供 `/healthz` 健康检查。Compose 启用只读根文件系统、临时 `/tmp` 和权限限制。支持 Linux AMD64 / ARM64 主机，以及使用 Linux 容器的 Docker Desktop（Windows / macOS）。这是静态官网镜像，不包含 Flutter 应用或 Navidrome 服务。

### 从源码部署

安装 Docker Engine 与 Compose 插件或 Docker Desktop 后，在仓库根目录执行：

```bash
docker compose -f website/compose.yaml up -d --build
```

访问 [http://localhost:8080/](http://localhost:8080/)。Compose 默认以 `SITE_URL=http://localhost:8080/` 构建本地预览的 SEO。

自托管到正式域名时，在构建前传入公开地址，例如 PowerShell：

```powershell
$env:SITE_URL = 'https://echoesmusic.app/'
$env:WEBSITE_PORT = '8080'
docker compose -f website/compose.yaml up -d --build
```

Linux / macOS shell：

```bash
SITE_URL=https://echoesmusic.app/ WEBSITE_PORT=8080 docker compose -f website/compose.yaml up -d --build
```

`WEBSITE_PORT` 控制主机端口。如果只是改本地访问端口，应同步把 `SITE_URL` 改为对应的完整本地地址，例如 `http://localhost:8088/`。正式域名通过反向代理访问时，`SITE_URL` 填用户看到的 HTTPS 地址，容器端口继续供代理转发即可。TLS 证书由反向代理或托管入口提供。

### 使用预构建镜像

当前仓库的发布目标为 `ghcr.io/azincc/echo-website`，标签包括 `latest`、`main` 和 `sha-<完整提交 SHA>`。派生仓库的镜像名随仓库所有者和名称变化。

首次工作流成功发布镜像后，才能使用以下命令；当前配置文件本身不代表镜像已经可用：

```bash
docker compose -f website/compose.yaml pull
docker compose -f website/compose.yaml up -d --no-build
```

匿名拉取要求 GitHub Packages 中该镜像的可见性为 **Public**；私有包需先执行 `docker login ghcr.io`，使用具有包读取权限的凭据。可以通过 `WEBSITE_IMAGE` 环境变量指定 `ghcr.io/azincc/echo-website:sha-<完整提交 SHA>`，固定到某次发布。

预构建镜像中的 canonical 等 SEO 地址在 CI 构建时确定，默认指向 `https://echoesmusic.app/`。**容器运行时设置 `SITE_URL` 不会改变已生成页面。** 要使用不同域名，请按“从源码部署”传入构建参数重新构建，或修改仓库变量后重新发布镜像。

本地环境未安装 Docker，因此未在本机实际构建或运行容器。工作流已配置双架构构建和容器检查，执行结果需在 Actions 中确认。

## SEO、路径与无障碍

`build.mjs` 默认使用 `https://echoesmusic.app/`，也接受构建时的 `SITE_URL` 环境变量。地址应是完整的 HTTP(S) 站点目录，不含账号、密码、查询参数或片段。构建结果包括：

- 两种语言各自的 canonical、`hreflang` 与 `x-default`，Open Graph、Twitter 卡片和 JSON-LD。
- `sitemap.xml`、`robots.txt`、双语 `404.html`，以及 Cloudflare Pages 使用的 `_headers` 和 `_redirects`。
- `assets/social-card.png`：由真实应用截图合成的分享图。

Cloudflare Pages 的 `_headers` 配置安全响应头，并对默认站点及预览的 `*.pages.dev` 地址发送 `noindex`，同时保留 Pages 默认缓存策略。`_redirects` 将显式的 `index.html` 和英文目录入口统一 301 跳转至规范路径，路径前缀由 `SITE_URL` 决定。独立的 `404.html` 让不存在的页面返回真实 404，避免被当作单页应用回退到首页。构建不生成 GitHub Pages 的 `CNAME` 或 `.nojekyll`。

官方参考：[Pages 路由与 404](https://developers.cloudflare.com/pages/configuration/serving-pages/)、[响应头配置](https://developers.cloudflare.com/pages/configuration/headers/)。

示例：在 PowerShell 中为其他域名生成静态产物：

```powershell
$env:SITE_URL = 'https://music.example.com/'
node website/build.mjs
node website/check.mjs
```

静态资源使用相对路径，`SITE_URL` 可包含站点子路径，例如 `https://example.com/music/`。上传到静态托管时，将 `dist/` 内容放到对应目录；使用 Docker 时，容器始终从根路径提供 `/` 与 `/en/`，反向代理须先剥离公开地址的子路径前缀。SEO 仍使用完整公开地址。

页面提供跳过导航链接、清晰的键盘焦点、移动导航的焦点恢复、原生截图对话框与 Escape 关闭、替代文本和随页面语言变化的交互标签；同时适配减少动效与强制颜色模式，改善文字大小及颜色对比度。禁用 JavaScript 时仍可使用导航和直接打开截图。这些措施属于无障碍改进，不代表通过 WCAG 认证或完整辅助技术兼容性验收。

下载入口指向 [GitHub Releases](https://github.com/Azincc/echo/releases/latest)，实际平台与安装包以 Release 附件为准。页面不收集音乐服务器地址、账号或密码，不包含分析脚本。

## 文件说明

| 路径 | 用途 |
| --- | --- |
| `index.html`、`en/index.html` | 中文与英文页面源文件 |
| `styles.css`、`script.js` | 共享响应式样式、导航和截图预览 |
| `assets/` | Logo、真实截图及分享图 |
| `build.mjs`、`check.mjs` | 静态产物生成与核心检查 |
| `serve.mjs` | 只供本机使用的预览服务 |
| `dist/` | 自动生成的发布目录，不作为页面源码维护 |
| `Dockerfile`、`nginx.conf`、`compose.yaml` | 容器构建、Nginx 与 Compose 配置 |
| `smoke-container.sh` | CI 使用的容器启动与 HTTP 核心检查 |

## 截图来源

四张产品图均为 **2026-09-07 在当前 `main` 分支实际运行后通过 ADB 采集**，已替换制作期间使用的历史归档图。

- 代码提交：`1df30705099b7b1933063f7674c2a699abf57923`。
- 环境：Flutter `3.38.9` / Dart `3.10.8`，Pixel_6_Pro，Android 16 / API 36。
- PNG 尺寸：`990 × 2200`，密度 `440 dpi`，逻辑布局约 `360 × 800`。
- 音乐流、资料库使用深色界面；播放器和歌词采用应用自身从封面提取的色彩。
- 原始文件位于 [`../docs/screenshots/android-2026-09-07/`](../docs/screenshots/android-2026-09-07/)，`assets/` 中保留相同文件的副本以便独立部署。
- `logo.png` 来自项目已有的 `web/icons/Icon-512.png`。

截图保留应用原始画面；手机边框由网页样式呈现。截图中的专辑封面、歌曲名与歌词用于展示应用，相关内容权利归各自权利人。此次截图采集已完成 Android Debug 构建、安装、登录、音乐流加载、歌曲播放、封面与同步歌词显示等核心验证，不代表其他平台或完整设备矩阵验收。

## English quick start

The website has a Chinese homepage at `/` and a complete English page at `/en/`. Application screenshots show the original Chinese UI. Use Node.js 22 LTS (18 minimum); no npm installation is needed.

```bash
node website/serve.mjs
```

Open [the English preview](http://localhost:4311/en/). The server builds `website/dist/` on startup. After editing source files, run `node website/build.mjs` and reload, or restart the server. To validate a release, run the build followed by `node website/check.mjs`; publish the contents of `website/dist/`.

```bash
docker compose -f website/compose.yaml up -d --build
```

This serves a local build at [http://localhost:8080/](http://localhost:8080/). For production, set the build-time `SITE_URL` to your public HTTPS URL. Setting an environment variable on a running container does not rewrite SEO metadata.

For Cloudflare Pages, either configure Actions with `CLOUDFLARE_API_TOKEN`, `CLOUDFLARE_ACCOUNT_ID` and the `CLOUDFLARE_PAGES_PROJECT` repository variable for an existing Direct Upload project, or use Pages Git integration with build command `node website/build.mjs` and output directory `website/dist`. Choose one deployment method. Add `echoesmusic.app` in the Pages project's Custom domains before configuring DNS, then confirm HTTPS is active.

The workflow also publishes Linux AMD64 / ARM64 images to `ghcr.io/azincc/echo-website` after eligible pushes to `main`; pull requests only validate. Published images use `https://echoesmusic.app/` unless the `WEBSITE_SITE_URL` repository variable overrides it. Prebuilt images can be pulled after the first successful publication; anonymous pulls require a public package. Docker was unavailable locally, so container execution is delegated to the configured CI checks.

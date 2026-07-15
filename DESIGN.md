---
name: Echo Listening System
description: A content-led mobile design system where album art provides the light and interface chrome stays quiet.
colors:
  echo-accent: "#3B8258"
  on-accent: "#FFFFFF"
  content-tint-fallback: "#556F60"
  canvas-light: "#F5F7F8"
  surface-light: "#FFFFFF"
  raised-light: "#E9EDF0"
  ink-light: "#16191C"
  muted-light: "#626A72"
  divider-light: "#D9DEE2"
  canvas-dark: "#0C0F12"
  surface-dark: "#14181C"
  raised-dark: "#1E2429"
  ink-dark: "#F2F5F7"
  muted-dark: "#AAB2B9"
  divider-dark: "#2A3238"
  error: "#B84B48"
  warning: "#9F6B20"
  scrim: "#080A0DDD"
typography:
  display:
    fontFamily: "system-ui, -apple-system, BlinkMacSystemFont, PingFang SC, Roboto, Noto Sans CJK SC, Microsoft YaHei UI, sans-serif"
    fontSize: "32px"
    fontWeight: 700
    lineHeight: 1.12
    letterSpacing: "-0.02em"
  headline:
    fontFamily: "system-ui, -apple-system, BlinkMacSystemFont, PingFang SC, Roboto, Noto Sans CJK SC, Microsoft YaHei UI, sans-serif"
    fontSize: "24px"
    fontWeight: 700
    lineHeight: 1.18
    letterSpacing: "-0.01em"
  title:
    fontFamily: "system-ui, -apple-system, BlinkMacSystemFont, PingFang SC, Roboto, Noto Sans CJK SC, Microsoft YaHei UI, sans-serif"
    fontSize: "17px"
    fontWeight: 600
    lineHeight: 1.25
    letterSpacing: "normal"
  body:
    fontFamily: "system-ui, -apple-system, BlinkMacSystemFont, PingFang SC, Roboto, Noto Sans CJK SC, Microsoft YaHei UI, sans-serif"
    fontSize: "15px"
    fontWeight: 400
    lineHeight: 1.45
    letterSpacing: "normal"
  label:
    fontFamily: "system-ui, -apple-system, BlinkMacSystemFont, PingFang SC, Roboto, Noto Sans CJK SC, Microsoft YaHei UI, sans-serif"
    fontSize: "13px"
    fontWeight: 600
    lineHeight: 1.25
    letterSpacing: "0.01em"
rounded:
  detail: "4px"
  control: "12px"
  surface: "16px"
  scene: "24px"
  pill: "999px"
spacing:
  xxs: "4px"
  xs: "8px"
  sm: "12px"
  md: "16px"
  lg: "24px"
  xl: "32px"
  xxl: "48px"
components:
  button-primary:
    backgroundColor: "{colors.echo-accent}"
    textColor: "{colors.on-accent}"
    typography: "{typography.label}"
    rounded: "{rounded.control}"
    padding: "12px 20px"
    height: "48px"
  button-secondary-light:
    backgroundColor: "{colors.raised-light}"
    textColor: "{colors.ink-light}"
    typography: "{typography.label}"
    rounded: "{rounded.control}"
    padding: "12px 20px"
    height: "48px"
  button-secondary-dark:
    backgroundColor: "{colors.raised-dark}"
    textColor: "{colors.ink-dark}"
    typography: "{typography.label}"
    rounded: "{rounded.control}"
    padding: "12px 20px"
    height: "48px"
  mini-player-light:
    backgroundColor: "{colors.surface-light}"
    textColor: "{colors.ink-light}"
    rounded: "{rounded.surface}"
    padding: "8px 12px"
    height: "72px"
  mini-player-dark:
    backgroundColor: "{colors.surface-dark}"
    textColor: "{colors.ink-dark}"
    rounded: "{rounded.surface}"
    padding: "8px 12px"
    height: "72px"
  input-light:
    backgroundColor: "{colors.raised-light}"
    textColor: "{colors.ink-light}"
    typography: "{typography.body}"
    rounded: "{rounded.control}"
    padding: "12px 16px"
    height: "48px"
  input-dark:
    backgroundColor: "{colors.raised-dark}"
    textColor: "{colors.ink-dark}"
    typography: "{typography.body}"
    rounded: "{rounded.control}"
    padding: "12px 16px"
    height: "48px"
---

# Design System: Echo Listening System

## 1. Overview

**Creative North Star: "Album Light, Quiet Chrome"**

Echo 像一间随身携带的安静试听室。稳定的中性壳层构成房间，专辑封面只在与当前音乐直接相连的区域成为光源。用户在白天通勤、夜间独处、弱网或离线环境中打开应用时，都应该立刻看懂当前内容与下一步操作，而不是先理解一套视觉特效。

这是一套移动端优先的产品系统，视觉变化度为 7/10，动效强度为 6/10，信息密度为 6/10。页面可以通过封面比例、留白、局部色彩与排版形成身份，但所有高频交互必须保持熟悉、稳定和快速。默认 Material 视觉被彻底隐藏，Flutter 的路由、语义、焦点、手势和无障碍基础设施继续保留。

布局使用三档结构响应，而不是简单放大手机页面。紧凑宽度小于 600dp 时采用单列、底部导航和单手可达操作；中等宽度 600-839dp 时扩大边距并允许双列内容；扩展宽度大于等于 840dp 时使用导航轨或侧栏、主从详情和双栏播放器。页面基础边距为 16dp，内容组间距为 24dp，场景级间距为 32-48dp。

普通反馈使用 160ms，组件状态切换使用 220ms，页面与播放器空间转场使用 300ms。动效统一采用快速减速的 ease-out 曲线。列表不做编排式逐项入场，页面不要求用户等待动画。减少动态效果开启时，共享元素转场退化为短交叉淡化或即时切换。

**Key Characteristics:**

- 中性、稳定、可长期使用的应用壳层。
- 封面驱动但严格限制作用范围的内容氛围色。
- 一屏一个主要焦点，少卡片、少装饰、清楚分组。
- 48dp 起步的触控目标和适合单手操作的底部区域。
- 从 MiniPlayer 到全屏播放器、歌词和队列的空间连续性。
- 长列表、弱网、离线和大字体状态与理想状态同等精致。

## 2. Colors

固定色彩保持冷静中性，默认 Echo 绿只用于主要操作、当前选择和焦点；专辑动态色作为内容光源存在，不能变成全局品牌色。

### Primary

- **Echo Moss** (`echo-accent`): 默认品牌操作色。用于主要按钮、当前导航、焦点环和明确的选中状态。用户自定义主题色必须经过亮度、饱和度和对比度归一化后再进入这一角色。
- **Clean Signal** (`on-accent`): Echo Moss 上的文字与图标。若用户主题色无法保证 4.5:1 对比度，系统必须自动选择深色或浅色前景，而不是固定使用白色。
- **Album Echo** (`content-tint-fallback`): 封面取色尚未完成或失败时的内容氛围回退色。运行时颜色来自专辑封面，并经过对比度与色度限制。

### Tertiary

- **Clear Error** (`error`): 仅用于失败、破坏性操作和需要立即处理的错误。
- **Measured Warning** (`warning`): 仅用于弱网风险、缓存或下载警告，不作为装饰色。

### Neutral

- **Day Canvas** (`canvas-light`) 与 **Night Canvas** (`canvas-dark`): 页面最底层背景。
- **Day Surface** (`surface-light`) 与 **Night Surface** (`surface-dark`): 顶栏、底栏、弹层和需要明确边界的稳定表面。
- **Day Raised** (`raised-light`) 与 **Night Raised** (`raised-dark`): 输入框、次级控件、选中分组和轻量抬升层。
- **Day Ink** (`ink-light`) 与 **Night Ink** (`ink-dark`): 主要文字与关键图标。
- **Day Muted** (`muted-light`) 与 **Night Muted** (`muted-dark`): 次级信息、时间、数量和说明文字，必须保持正文级可读对比度。
- **Day Divider** (`divider-light`) 与 **Night Divider** (`divider-dark`): 只在留白不足以表达分组时使用的细分隔。
- **Stage Scrim** (`scrim`): 模态层与封面上的对比度保护层。

**The Album Light Rule.** 动态封面色只允许出现在全屏播放器、MiniPlayer、专辑或歌手详情头部，以及与这些场景连续展开的歌词、队列和操作面板。首页列表、资料库、设置、下载和表单保持稳定中性。

**The Quiet Chrome Rule.** 非活动界面不使用品牌色装饰。若一个颜色既不表达主要操作、当前选择、语义状态，也不来自当前音乐内容，就不应出现。

**The Contrast Before Hue Rule.** 动态取色和用户主题色必须先满足对比度，再保留原始色相。文字永远不能为了忠实封面颜色而变得难读。

## 3. Typography

**Display Font:** 系统 UI Sans，优先使用 SF Pro、PingFang SC、Roboto 与平台原生中文字体。

**Body Font:** 与 Display 相同的系统 UI Sans。

**Character:** 一套字体贯穿标题、正文、按钮和数据，通过字重、尺寸与留白形成层级。它应像成熟移动产品，而不是音乐杂志或营销页面。

### Hierarchy

- **Display** (700, 32sp, 1.12): 页面主标题、媒体详情的大标题和关键空状态标题。普通页面每屏最多一个。
- **Headline** (700, 24sp, 1.18): 区域标题、弹层标题和紧凑详情标题。
- **Title** (600, 17sp, 1.25): 歌曲、专辑、歌手、设置项和主要列表标题。
- **Body** (400, 15sp, 1.45): 说明、表单内容和正文。长说明控制在约 65-75 个拉丁字符的行宽以内。
- **Label** (600, 13sp, 1.25): 按钮、导航标签、筛选项和短状态。不使用全大写加宽字距作为装饰。
- **Metadata** (500, 12-13sp, 1.25): 时长、年份、音质、数量和辅助状态。数字启用等宽数字特性，避免播放时间跳动。

**The One Family Rule.** 产品界面只使用一套系统无衬线字体家族。不得在按钮、标签、统计或详情页中插入展示字体制造个性。

**The Scale Without Clipping Rule.** 所有布局必须在系统字体缩放 200% 时保持可操作。标题可以换行，操作不能被文字挤出屏幕，截断不能隐藏唯一信息。

## 4. Elevation

Echo 以色调层级、边缘和空间位置表达深度，默认不依赖阴影。普通列表、设置分组和内容区保持平面；只有 MiniPlayer、浮动操作、底部弹层、菜单和模态对话框可以抬升。模糊只允许出现在尺寸稳定、不会随长列表滚动的大型场景层中，并必须提供不透明回退。

### Shadow Vocabulary

- **Ambient Float** (`0 8px 24px rgba(4, 8, 12, 0.18)`): MiniPlayer、浮动菜单和短暂悬浮控件。
- **Modal Depth** (`0 18px 48px rgba(4, 8, 12, 0.28)`): 底部弹层与模态对话框，必须配合 Stage Scrim。
- **Artwork Lift** (`0 16px 40px rgba(4, 8, 12, 0.24)`): 仅用于全屏播放器和媒体详情中的主封面，不用于普通网格缩略图。

**The Flat By Default Rule.** 如果留白、底色或位置已经能说明层级，就禁止再加阴影、描边或卡片容器。

**The No Global Glass Rule.** 毛玻璃不能成为页面背景、设置分组或列表容器。它只允许服务于播放器邻接层，并且不能影响滚动性能和文字对比度。

**The Clean-room Implementation Rule.** `feature-glass-like` 及其他历史视觉实验分支不是 Echo Listening System 的代码来源。实现只能依据 `PRODUCT.md`、本文件、重构计划和 `main` 的共同业务基线独立编写；禁止复用历史分支的组件实现、主题段落、图标别名映射、页面补丁或仅做重命名的派生代码。Remix Icons 是本设计系统独立选定的图标家族，具体 glyph 必须按当前操作语义重新选择，不能沿用历史映射表。

## 5. Components

所有业务页面只使用 `Echo*` 组件与语义 token。`ThemeData` 仅作为 Flutter、第三方组件和迁移期的兼容层，不能决定最终可见轮廓。

### App Shell

- `EchoScaffold` 负责安全区、页面底色、系统栏样式、MiniPlayer 占位和响应式结构。
- `EchoTopBar` 默认左对齐标题。返回、抽屉、搜索与更多操作保持固定光学位置，不复制默认 `AppBar` 的居中标题和阴影。
- `EchoBottomNavigation` 在紧凑宽度使用 64dp 高度加安全区，选中态依靠图标、字重和克制色块共同表达。中等与扩展宽度分别迁移为导航轨或侧栏。
- 图标统一通过 `AppIcons` 暴露。主图标族采用 Remix Icons，返回与关闭等系统动作可使用 Cupertino 图标。业务页面禁止直接使用 `Icons.*`。

### Buttons and Icon Controls

- 主要与次要按钮高度均为 48dp，圆角为 12dp。主要按钮使用 Echo Moss，次要按钮使用 Raised Surface，危险按钮只在确认破坏性操作时使用 Clear Error。
- 图标按钮的可见图标为 22-24dp，实际触控区域不小于 48dp。
- 按下反馈使用 160ms 的轻微缩放或明度变化，并配合可选触觉反馈。禁用状态仍必须清楚可辨。
- 同一页面只允许一个视觉上的主要操作，不能同时出现多个同权重实心按钮。

### Media Rows and Grids

- `EchoSongRow`、`EchoAlbumTile`、`EchoArtistTile` 和 `EchoPlaylistTile` 直接排列在页面上，不默认套卡片。
- 歌曲行最小高度为 64dp，封面通常为 48dp；需要下载或多行元数据时可增长到 72dp。标题与副标题对齐封面视觉中心。
- 长列表使用轻量行背景、局部留白和必要的单条分隔，不在每一行同时使用上下边线。
- 网格封面保持内容原始比例和统一圆角。文字位于图片下方，不把标签、胶囊或装饰文字叠在封面上。
- 资料库 A-Z 索引仅在滚动或交互时出现，静止后淡出，并为屏幕阅读器提供等价的分组导航。

### Section and Detail Headers

- `EchoPageHeader` 提供页面标题、说明和最多一个主要操作；不在每个区域标题上方重复小号全大写眉题。
- `EchoSectionHeader` 主要由标题和必要的“查看全部”动作组成，不强制所有页面使用相同结构。
- `EchoMediaHeader` 根据专辑、歌手和歌单的内容类型选择布局。专辑强调封面与播放，歌手强调身份与热门内容，歌单强调编辑信息与连续播放。禁止把三者塞进同一个玻璃信息卡。
- 媒体详情可以使用 Album Light，但普通滚动内容在头部离场后回归稳定中性表面。

### MiniPlayer and Player Surfaces

- `EchoMiniPlayer` 高度为 72dp，是应用壳层与沉浸播放器之间的桥。封面、标题和背景通过共享元素进入全屏播放器。
- MiniPlayer 只保留播放暂停和一个上下文相关的次要操作。横向切歌、点击展开和纵向展开都必须有按钮或菜单替代入口。
- 全屏播放器保留大封面、单一主播放控制、歌词与封面模式切换。现有约 800ms 的分段入场不得成为全局规范，场景转场目标为 300ms。
- 队列、歌词与歌曲操作面板使用与播放器连续的背景和标题层级，但内部行必须使用 Echo 组件，不能退回 `ListTile + Divider`。

### Sheets, Dialogs and Menus

- 底部弹层顶部圆角为 24dp，使用拖动把手、清楚标题和安全区。首选底部弹层处理移动端上下文操作。
- 对话框只用于不可逆确认、需要阻断的权限或关键错误。可在当前页面内完成的选择与编辑不得默认弹窗。
- 菜单、弹层和对话框必须支持键盘、焦点回收、返回键、点击遮罩关闭策略和屏幕阅读器名称。

### Inputs and Settings

- 输入框高度至少 48dp，标签位于输入框上方，帮助文本与错误文本位于下方。禁止只用 placeholder 充当标签。
- 设置页使用 `EchoSettingRow`、分段选择、内联开关和渐进披露，不使用整页相同的 `ListTile` 卡片。
- 复杂音乐库编辑按“身份、地址、认证、能力与危险操作”分组。错误显示在对应字段或分组内，不依赖瞬时 Toast。
- 滑杆、单选、开关和多选必须共享同一视觉词汇，并在大字体与屏幕阅读器下保持可操作。

### Loading, Empty, Offline and Error States

- 内容加载使用与最终布局同形的骨架，不在页面中央放置通用圆形进度指示器。
- 空状态说明为什么为空，并给出一个最相关的下一步。没有可执行动作时不制造按钮。
- 弱网和离线状态保留已有内容，使用内联状态条说明影响范围。不得用全屏错误覆盖仍然可用的本地内容。
- 错误状态提供重试、切换线路或打开设置等具体恢复路径。

## 6. Do's and Don'ts

### Do:

- **Do** 让封面成为全屏播放器、MiniPlayer 和媒体详情头部的局部光源。
- **Do** 在普通浏览、资料库、下载和设置中使用稳定中性色与清楚的信息层级。
- **Do** 用 Echo Moss 只表达主要操作、当前选择和焦点，并保证文字对比度至少 4.5:1。
- **Do** 使用 4/8/12/16/24/32/48dp 间距节奏和 4/12/16/24dp 圆角规则。
- **Do** 保证主要触控目标不小于 48dp，手势提供按钮或菜单替代入口。
- **Do** 使用 160/220/300ms 动效层级，并为减少动态效果提供交叉淡化或即时切换。
- **Do** 将加载、空内容、弱网、离线、失败、禁用和部分数据作为每个页面的正式设计状态。
- **Do** 使用 Remix Icons 作为统一主图标族，通过 `AppIcons` 暴露。
- **Do** 在中等和扩展宽度使用结构性适配，包括双列、主从详情、导航轨或侧栏。

### Don't:

- **Don't** 做默认 Material 3 组件陈列页，也不接受只通过换色、圆角和阴影完成的 Material 换肤。
- **Don't** 做 Apple Music、Spotify 或 Plexamp 的直接复刻。
- **Don't** 从 `feature-glass-like` 或其他历史视觉实验分支复制、改名或机械改写实现代码。
- **Don't** 让整个应用壳层随每次切歌持续变色。
- **Don't** 把毛玻璃、渐变光球、发光阴影或大圆角卡片铺满每个页面。
- **Don't** 用装饰性动效打断高频任务，不使用需要等待的编排式页面入场。
- **Don't** 把设置、下载、缓存和长列表做成同质化 `ListTile + Divider` 或层层嵌套卡片。
- **Don't** 为了追求个性而发明陌生的返回、确认、选择、搜索和表单交互。
- **Don't** 牺牲单手操作、动态字体、弱网反馈、离线可用性和长列表性能。
- **Don't** 在业务页面直接实例化 `NavigationBar`、`AppBar`、`ListTile`、`Card`、`AlertDialog`、`FilledButton` 或通用圆形加载器来决定视觉。
- **Don't** 在每个页面和区域标题上方重复小号全大写眉题、编号标签或装饰状态点。
- **Don't** 在普通列表和滚动容器上使用实时模糊、重阴影或持续动画。
- **Don't** 只靠颜色、触觉或手势表达唯一状态与操作。

# Echo 移动端 UI 全面重构计划

> 状态：P0 合同与 P1 foundations 已完成，M0 截图基线仍按 `docs/ui-baseline-manifest.md` 补齐；旧 P2-P6 巨大工作区已隔离。后续阶段从不含 Glasslike 对象的独立 clone 按顺序 clean-room 重建。

## 1. Feature Summary

本次工作不是为现有 Material 3 页面换色，而是在保留 Flutter 基础设施、现有信息架构与业务行为的前提下，建立 Echo 自有的移动端设计系统，并迁移全部可见界面。

目标用户是高频使用自建音乐库的移动端听众。重构必须让播放器已经具备的沉浸感自然延伸到音乐流、探索、资料库、媒体详情、下载、设置和复杂编辑页面，同时保持长列表效率、单手操作、弱网与离线可靠性。

## 2. Primary User Action

用户在任何页面都应当能够快速完成与当前场景最相关的一件事：找到音乐、开始或继续播放、理解播放状态，或完成明确的配置任务。

UI 的首要职责是降低寻找和判断成本。视觉个性来自封面、内容层级、连续转场和统一触感，不来自额外步骤或陌生控件。

## 3. Design Direction

- **Color strategy:** Restrained。稳定中性壳层加一个受约束的默认强调色，当前专辑色只在与音乐直接相连的局部场景进入 Committed 状态。
- **Theme scene:** 用户在白天通勤或夜间独处时，用一只手打开自己的音乐库；环境光不断变化，但界面始终清楚安静，只有当前唱片像光源一样照亮播放场景。
- **Anchor references:** Plexamp 的音乐个性、Apple Music 的专辑沉浸、Spotify 的信息效率。
- **Personality:** 沉浸、克制、敏捷。
- **Creative North Star:** Album Light, Quiet Chrome。
- **Design dials:** 视觉变化度 7/10，动效强度 6/10，信息密度 6/10。

动态颜色采用“稳定中性底色 + 当前音乐局部染色”。全局主题跟随系统明暗模式，用户可以选择受约束的静态强调色。专辑色不能驱动整个应用壳层。

## 4. Scope

- **Fidelity:** 生产级设计与实现，不做一次性概念稿。
- **Breadth:** Android 与 iOS 的全部现有页面、弹层和关键状态。
- **Interactivity:** 保留并完善全部现有交互，包括播放器手势、Hero、歌词、队列、A-Z 索引、分页、批量选择、下载和复杂表单。
- **Time intent:** 通过垂直样板链路验证体系，再分批迁移，直到默认 Material 视觉出口清零。
- **Later scope:** Windows、macOS、Linux 与 Web 在移动端体系稳定后做结构适配，不在首期并行探索另一套视觉。

首期不修改路由名称、导航信息架构、Riverpod 状态模型、仓库层、网络层、数据库结构或播放业务逻辑。UI 重构若暴露业务缺陷，应单独立项，避免与视觉迁移混在同一提交。

## 5. Layout Strategy

### 5.1 全局壳层

紧凑宽度使用自定义底部导航、MiniPlayer 与单列页面。顶部栏默认左对齐，搜索、返回、抽屉和更多操作保持稳定位置。页面底部操作优先放在拇指可达区域，但不能遮挡 MiniPlayer、系统手势区或键盘。

中等宽度允许双列媒体网格、较宽的详情头部和更清楚的内容分组。扩展宽度使用导航轨或侧栏、主从详情和播放器双栏，不把手机页面简单居中放大。

建议断点：

- Compact: `< 600dp`
- Medium: `600-839dp`
- Expanded: `>= 840dp`

### 5.2 内容层级

- 页面只建立一个主要视觉焦点。
- 媒体内容优先使用封面、标题、元数据和留白，不默认放入卡片。
- 卡片只在表达真实容器、任务或抬升层级时出现。
- 详情页按专辑、歌手、歌单的内容身份分别组织，不使用统一玻璃头卡。
- 设置和管理页按任务分组，使用渐进披露，避免连续的通用列表行。

### 5.3 播放器连续性

MiniPlayer 是稳定应用壳层与沉浸播放器之间的桥。封面、标题与背景继续通过共享元素进入全屏播放器。歌词、队列与操作面板继承当前播放场景的色彩与空间关系，但内部控件使用统一 Echo 组件。

## 6. Key States

每个页面或共享组件必须在设计和测试中覆盖以下状态：

| 状态 | 用户需要看到什么 | 体验目标 |
|---|---|---|
| 默认 | 清楚的内容层级与一个主要操作 | 不需要学习页面布局 |
| 加载 | 与最终内容同形的骨架和稳定尺寸 | 不跳动，不阻断已有内容 |
| 空内容 | 为什么为空，以及最相关的下一步 | 有帮助但不过度营销 |
| 弱网 | 哪些内容仍可用，当前请求是否重试 | 保持掌控感 |
| 离线 | 本地内容、下载状态和受限功能 | 不用全屏错误覆盖可用内容 |
| 失败 | 原因范围、重试、切换线路或设置入口 | 提供具体恢复路径 |
| 部分数据 | 缺封面、缺歌词、缺元数据时的稳定回退 | 不破坏布局与操作 |
| 禁用 | 为什么不可用以及如何恢复 | 不只降低透明度 |
| 选择模式 | 已选数量、可执行批量操作和退出方式 | 不与底栏和 MiniPlayer 冲突 |
| 大字体 | 200% 字体缩放下的换行和操作位置 | 流程仍可完成 |
| 减少动效 | 交叉淡化或即时状态切换 | 功能与空间关系仍然清楚 |

## 7. Interaction Model

- 高频操作保持标准移动端语义：点击打开，长按进入上下文操作，滑动只用于已有明确心智模型的播放器和列表行为。
- 所有手势都有按钮、菜单或列表项替代入口。
- 普通反馈为 160ms，组件状态切换为 220ms，页面与播放器场景切换为 300ms。
- 动效只解释层级、反馈、加载或状态变化。禁止为普通页面添加编排式逐项入场。
- 主要操作可提供轻触觉反馈，但视觉和语义反馈必须独立完整。
- 模态不是默认方案。优先使用内联编辑、展开区、独立页面或底部弹层；对话框保留给不可逆确认和真正阻断的事件。
- Android 返回行为、三分支导航栈、动态探索 Tab 和退回首页逻辑保持不变。

## 8. Content Requirements

- 保留现有中文页面名称、路由含义和主要操作文案，视觉现代化不自动授权重写产品信息架构。
- 长标题、多个歌手、未知年份、未知音质、无封面、无歌词和本地路径必须有真实回退。
- 下载与缓存状态使用清楚的动词和结果，不只显示百分比或颜色。
- 错误文案说明影响范围和恢复动作，例如重试、切换线路、检查服务器或打开设置。
- 封面是主要视觉资产。不得使用装饰性假封面、渐变占位图或与当前内容无关的图库照片。
- 图标统一通过 `AppIcons` 提供，主图标族采用 Remix Icons。返回与关闭等系统动作可使用 Cupertino 图标。

## 9. Recommended References

实现阶段建议继续使用以下设计检查维度：

- `layout`: 壳层、详情页、设置与宽屏结构。
- `typeset`: 中文动态字体、媒体标题与数据排版。
- `animate`: MiniPlayer、全屏播放器、详情头部和弹层连续性。
- `harden`: 弱网、离线、错误、权限、空内容和复杂表单。
- `adapt`: 横屏、平板、桌面与 Web 的结构适配。
- `audit`: 无障碍、性能、响应式和默认 Material 视觉出口检查。

## 10. Open Questions

当前没有阻塞性设计问题。进入代码前只需要用户确认本 brief 与下方迁移路线。首条垂直样板完成后，应再做一次视觉确认，再批量迁移剩余页面。

## 11. “完全取代 Material Design”的工程定义

完全取代指消除默认 Material 的可见视觉与组件语法，不是删除 Flutter 的 Material 基础设施。

继续保留：

- `MaterialApp.router`
- GoRouter 与 `StatefulShellRoute`
- Flutter 的语义、焦点、键盘、手势、文本缩放和平台适配
- 必要时作为 Echo 组件内部实现细节的 Material primitive
- `ThemeData` 作为第三方组件和迁移期兼容层

最终业务页面不得直接依赖以下组件决定视觉：

- `AppBar`、`SliverAppBar`
- `NavigationBar`、`NavigationDestination`、默认 `Drawer`
- `ListTile`、`RadioListTile`、`SwitchListTile`
- `Card`
- `FilledButton`、`ElevatedButton`、默认 `IconButton`
- `AlertDialog`、默认 `showModalBottomSheet` 内容结构
- `ChoiceChip`、默认 `TabBar`
- 页面中央的通用 `CircularProgressIndicator`

这些能力应由 `Echo*` 组件包装并统一控制。最终机械检查要求 `lib/features/**` 中上述直接构造降为零，少量底层实现只允许存在于设计系统目录的明确 allowlist 中。

## 12. Target Architecture

建议新增以下结构，具体文件名可在实现时微调：

```text
lib/core/design/
├── theme/
│   ├── echo_theme.dart
│   ├── echo_colors.dart
│   ├── echo_typography.dart
│   ├── echo_spacing.dart
│   ├── echo_radii.dart
│   ├── echo_motion.dart
│   ├── echo_interaction.dart
│   └── echo_breakpoints.dart
├── foundations/
│   ├── echo_pressable.dart
│   ├── echo_surface.dart
│   ├── echo_text.dart
│   ├── echo_icon.dart
│   ├── echo_divider.dart
│   └── echo_skeleton.dart
├── navigation/
│   ├── echo_scaffold.dart
│   ├── echo_top_bar.dart
│   ├── echo_bottom_navigation.dart
│   ├── echo_navigation_rail.dart
│   └── echo_page_route.dart
├── overlays/
│   ├── echo_bottom_sheet.dart
│   ├── echo_dialog.dart
│   ├── echo_menu.dart
│   └── echo_toast.dart
├── forms/
│   ├── echo_field.dart
│   ├── echo_toggle.dart
│   ├── echo_choice_list.dart
│   └── echo_setting_row.dart
└── media/
    ├── echo_cover_art.dart
    ├── echo_song_row.dart
    ├── echo_album_tile.dart
    ├── echo_artist_tile.dart
    ├── echo_playlist_tile.dart
    ├── echo_media_header.dart
    └── echo_media_palette_scope.dart
```

原则：

- token 使用语义名称，不使用 `primaryContainer`、`surfaceVariant` 等 Material 角色名。
- 不创建万能 `EchoCard`。优先创建 `EchoSongRow`、`EchoTaskRow`、`EchoSettingRow` 等领域组件。
- `EchoColors`、`EchoTypography`、`EchoSpacing`、`EchoMotion` 与 `EchoInteraction` 可采用 `ThemeExtension` 技术骨架，但重新定义语义。
- `ThemeData` 不再集中覆写几十种 Material 组件主题来模拟品牌。
- 页面只消费设计系统公开 API，不直接使用颜色常量、随机圆角和硬编码动画时长。

## 13. Dynamic Color Architecture

现有当前歌曲调色板能力应扩展为按媒体内容工作的通用机制：

1. 使用 `coverArtId` 或稳定资源键缓存调色板，不能让专辑详情错误复用当前播放歌曲的颜色。
2. 提取主色后限制亮度与色度，生成可用的背景、前景和渐变停靠点。
3. 在应用前验证文字与控件对比度，必要时牺牲色彩忠实度。
4. 首次加载使用 `content-tint-fallback`，调色板完成后在 220-300ms 内平滑过渡。
5. 调色板计算不能在 Widget rebuild 中重复执行，也不能阻塞列表滚动。
6. 普通页面不订阅当前播放颜色，避免切歌触发整棵应用壳层重绘。

## 14. Migration Roadmap

本节使用 `M0-M9` 表示产品迁移里程碑；第 16.1 节使用 `P0-P6` 表示可审查的 Git 提交批次。两套编号分别描述完成范围与提交边界，不再混用。

| 阶段 | 页面组 | 关键 Echo 组件 | 完成判据 |
|---|---|---|---|
| M0 设计契约与基线 | 全部页面 | tokens、theme、adaptive metrics、palette scope | `PRODUCT.md` 与 `DESIGN.md` 冻结；clean-room 零复用门禁明确；`docs/ui-baseline-manifest.md` 中 24 个页面和关键弹层基线截图齐全；明暗模式、动态字体、减少动效规则明确 |
| M1 应用壳层 | `MainScaffold`、`AppDrawer`、底部导航、MiniPlayer 容器 | `EchoScaffold`、`EchoTopBar`、`EchoBottomNavigation`、`EchoIconAction`、`EchoPageRoute` | 三个主入口、返回逻辑和动态探索 Tab 行为不变；MiniPlayer 不遮挡内容；壳层无默认 Material 视觉 |
| M2 垂直样板 | 音乐流、专辑详情、MiniPlayer、全屏播放器、队列与操作弹层 | `EchoCoverArt`、`EchoSongRow`、`EchoAlbumTile`、`EchoMediaHeader`、`EchoActionSheet`、`EchoAsyncView` | 打通“音乐流 → 专辑 → 播放 → MiniPlayer → 全屏播放器 → 操作弹层”；现有 Hero、手势、歌词和进度控制无回退 |
| M3 三大主入口 | 探索、搜索、资料库 | `EchoSearchField`、`EchoModeSwitcher`、`EchoFilterBar`、`EchoCollectionShortcut`、`EchoSelectionBar` | 搜索、刷新、分页、试听、批量选择、下载与歌单操作全部保留；单手可达；无默认 Chip、PopupMenu 或 ListTile 视觉 |
| M4 曲库与详情 | 歌手、歌单、全部歌曲、全部专辑、全部歌手、收藏 | `EchoMediaDetailHeader`、`EchoTabStrip`、`EchoSortSheet`、`EchoAZIndexRail`、`EchoMediaGrid` | A-Z、排序、吸顶、长按、收藏和下载可用；大曲库滚动稳定；不同媒体类型拥有各自头部身份 |
| M5 下载与数据工具 | 下载管理、离线状态、缓存、播放统计 | `EchoTaskRow`、`EchoStatusSummary`、`EchoProgressTrack`、`EchoStorageMeter`、`EchoMetricBlock` | 所有下载状态和批量操作正确；统计页不再是卡片墙；实时刷新不产生布局跳动 |
| M6 设置、登录和配置 | 登录、应用设置、主题、音质、歌词与封面源、音乐库编辑 | `EchoFormScaffold`、`EchoFormSection`、`EchoField`、`EchoSettingRow`、`EchoChoiceList`、`EchoConfirmation` | 字段、验证、认证方式、服务器探测和危险确认不变；键盘不遮挡；静态强调色与动态专辑色边界清楚 |
| M7 复杂编辑器 | 歌曲元数据编辑与候选选择 | `EchoEditorScaffold`、`EchoMetadataField`、`EchoCandidatePicker`、`EchoDiffSummary`、`EchoStickySaveBar` | 原值、候选值和最终值可核对；未保存退出有保护；键盘和屏幕阅读器完整可用 |
| M8 移动端硬化 | Android、iOS 全页面与状态 | 统一 Skeleton、Empty、Error、Offline、Focus、Haptics | 紧凑手机、大屏手机、动态字体、明暗模式和减少动效通过；默认 Material 视觉出口清零 |
| M9 桌面与 Web | Windows、macOS、Linux、Web | 导航轨、侧栏、双栏和 Hover/Focus 变体 | 保持同一设计系统和 IA，只改变结构与密度；键盘、Hover、窗口缩放完成验证 |

## 15. First Vertical Slice

第一轮只完整实现以下链路：

```text
MainScaffold
  → 音乐流
  → 专辑详情
  → 播放歌曲
  → MiniPlayer
  → 全屏播放器
  → 歌词 / 队列 / 歌曲操作弹层
```

这条链路同时验证：

- 全局壳层与导航
- 页面顶栏与内容区节奏
- 专辑网格与歌曲长列表
- 媒体详情头部
- 动态封面取色
- MiniPlayer 与 Hero 连续性
- 全屏播放器控制
- 底部弹层与操作行
- 加载、缺封面、错误和减少动效状态

样板链路经视觉确认后再扩散到其余页面。这样剩余迁移主要是复用设计系统，而不是在二十多个页面中同时探索。

## 16. Pull Request Strategy

建议按能力边界拆分提交和 PR，不按“全项目改完再提交”：

1. 设计文档、截图基线和检查脚本。
2. tokens、ThemeExtension、图标入口和基础 primitive。
3. 应用壳层、底部导航、MiniPlayer 容器和路由转场。
4. 垂直样板链路。
5. 探索、搜索和资料库。
6. 曲库列表、媒体详情和收藏。
7. 下载、缓存、统计和状态组件。
8. 登录、设置、音乐库配置和复杂表单。
9. 元数据编辑器。
10. 无障碍、性能、视觉回归与 Material 出口清零。
11. 桌面与 Web 结构适配。

每个 PR 只迁移一组页面与其所需公共组件。禁止在 UI PR 中顺手重构 repository、provider 或 API 行为。

### 16.1 Reviewable Commit Series

当前工作必须按以下依赖顺序拆分，禁止再以单个巨大工作区交付：

1. **P0 contract:** `PRODUCT.md`、`DESIGN.md`、实施计划与 clean-room 验收规则。
2. **P1 foundations:** Echo tokens、基础 primitive、主题桥接、独立重做的 `AppIcons` 与组件测试。
3. **P2 shell and player:** 应用壳层、抽屉、底部导航、MiniPlayer、全屏播放器及其邻接弹层。
4. **P3 primary and library:** 音乐流、探索、搜索、资料库与媒体详情。
5. **P4 forms and settings:** 登录、音乐库编辑、设置、主题、音质与提供商页面。
6. **P4b metadata editor:** 歌曲元数据编辑、候选选择、差异核对、未保存退出保护与编辑器专项测试。
7. **P5 resilience:** 下载、离线、加载、空内容、错误、弱网和相关 UI 回归测试。
8. **P6 docs and build:** README、截图、UI 导出、Android 签名与纯构建配置。

每个提交只包含本阶段文件；共享依赖必须先进入更早阶段。最终验收在完整提交序列上运行，但每个提交都应保持可分析、可测试，或在提交说明中明确其唯一后继依赖。

UI 迁移暴露出的 service、repository、provider、API 或播放行为缺陷必须使用独立 `fix(...)` 提交处理，不计入 P2-P6 的 UI 提交。需要某项行为修复才能验证当前 UI 阶段时，先提交并验证该修复，再继续对应 UI 提交。

## 17. Quality Gates

### 17.1 Visual and Component Gates

- 业务页面默认 Material 视觉构造器直接使用量降为零。
- 颜色、圆角、间距、阴影、动画时长和触控尺寸不在 feature 页面散落硬编码。
- 同一操作在不同页面使用相同组件、图标、状态和反馈。
- 不出现全局毛玻璃、嵌套卡片、装饰渐变光球或每屏多个主要按钮。
- 明暗模式均完成页面级截图检查。

### 17.2 Accessibility Gates

- 正文与占位文本对比度至少 4.5:1，大字号与关键非文本控件至少 3:1。
- 主要触控目标至少 48dp。
- 100%、130% 与 200% 字体缩放下关键流程可完成。
- TalkBack 与 VoiceOver 能读出页面标题、按钮名称、播放状态、进度、下载状态和错误恢复动作。
- 焦点顺序与视觉顺序一致，弹层关闭后焦点返回触发位置。
- 颜色、触觉和手势都不是唯一的信息渠道。

### 17.3 Device Gates

至少覆盖：

- 360 × 800 紧凑 Android 手机
- 430 × 932 大屏手机
- 600 × 960 小型平板或折叠屏展开态
- Android 与 iOS 明暗模式
- 竖屏与播放器横屏
- Compact、Medium、Expanded 三档布局

### 17.4 Performance Gates

- 调色板按封面资源键缓存，不在 rebuild 中重复计算。
- 长列表不使用持续 blur、重阴影、逐项无限动画或昂贵的嵌套裁剪。
- 封面按显示尺寸解码，并对复杂媒体区域使用合理的 `RepaintBoundary`。
- 高频下载进度更新只重建对应行，不重建整个页面。
- 使用 profile 模式检查音乐流、全部歌曲、下载管理和播放器转场的帧时间与图片内存。
- 页面加载骨架预留最终尺寸，避免明显布局跳动。

### 17.5 Regression Gates

- `flutter analyze`
- `flutter test`
- 修改生成器输入时运行 `dart run build_runner build --delete-conflicting-outputs`
- 为 tokens、主题插值、调色板归一化与响应式规则添加单元测试
- 为壳层、媒体行、设置行、弹层和关键页面添加明暗模式 golden tests
- 为返回导航、MiniPlayer 展开、播放器手势、下载操作和设置保存保留集成测试

### 17.6 Clean-room Provenance Gate

- `feature-glass-like` 与 `origin/feature-glass-like` 的 UI 提交不得 merge、cherry-pick 或作为补丁来源。
- 当前代码不得保留只在上述分支新增的独有实现行；共同 `main` 业务基线不受此限制。
- `MusicChrome`、`MusicGlassSurface`、`MusicGradientBackdrop`、`MusicChromeTheme`、`glassBlur`、`BackdropFilter` 与背景 `ImageFilter.blur` 保持为零。
- `AppIcons` 的语义名称与 glyph 映射必须依据当前导航和操作语义独立建立；不得沿用历史别名表后只修改命名风格。
- 每个阶段提交前运行来源审计；最终提交序列完成后再次对两个 Glasslike 分支执行行级比对。任何无法证明独立来源的片段按未完成处理。
- P2-P6 的实现工作区必须从已验收的前一阶段提交单分支克隆，并且不包含 Glasslike refs、Glasslike Git 对象、旧污染 stash 或可访问这些对象的 remote。阶段完成后只把提交对象带回主仓库执行来源审计。
- 来源脚本是检测已知血缘和文本指纹的辅助门禁，不得把“脚本通过”单独表述为已经证明 zero reuse；每个阶段仍需对照 `main` 业务基线、设计合同和当前提交进行人工归因审查。

若后续增加图标或视觉测试依赖，Flutter 与 Dart 包缓存继续使用 D 盘的 `PUB_CACHE`，不在系统盘创建新的工具缓存。

## 18. Risk Register

| 风险 | 处理方式 |
|---|---|
| 把 Material token 重新命名后继续使用默认控件 | 先建立 Echo primitive 与机械 allowlist，再迁移页面 |
| 动态颜色扩散到整个应用 | 使用 `EchoMediaPaletteScope` 限定作用域，普通页面不订阅当前歌曲颜色 |
| 重构播放器导致 Hero 与手势回退 | 播放器先做行为基线测试，视觉改造围绕现有交互逐层替换 |
| 全局毛玻璃导致性能和同质化 | 明确 No Global Glass 规则，只允许播放器邻接场景有限使用 |
| 过早抽象万能组件 | 先做领域组件，至少出现三次稳定模式后再下沉 primitive |
| 设置与表单为追求个性而变得陌生 | 保留标准表单语义，只重做排版、层级、状态和触感 |
| 自由主题色破坏对比度 | 将种子色改为受约束的静态强调色，自动归一化前景与色度 |
| UI PR 混入业务行为变化 | 每个 PR 限定页面和组件范围，业务修复单独提交 |
| 移动端完成后桌面出现第二套视觉 | 桌面只扩展布局和交互状态，不建立新的 token 或组件语言 |

## 19. Completion Criteria

只有同时满足以下条件，才能认为“完全取代 Material Design”完成：

- 24 个现有页面、关键弹层和全状态均已迁移到 Echo 组件。
- 应用壳层、MiniPlayer 与全屏播放器形成连续而稳定的体验。
- 首页、探索、资料库、详情、下载、设置和编辑器共享同一排版、色彩、图标、状态和动效语法。
- `lib/features/**` 中默认 Material 视觉构造器通过机械检查降为零。
- 明暗模式、200% 字体、减少动效、读屏和 48dp 触控目标通过验收。
- 长列表、调色板、封面解码、下载进度和播放器转场没有明显性能回退。
- Android 与 iOS 完整通过后，才进入桌面与 Web 的结构适配阶段。
- README 与截图更新为新的 UI，不再将设计描述为“Material 3 + 自定义主题色”。

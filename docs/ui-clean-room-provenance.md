# Echo UI Clean-room Provenance

## Authority

Echo 当前 UI 的唯一设计与实施依据是：

1. `PRODUCT.md`
2. `DESIGN.md`
3. `docs/echo-ui-overhaul-plan.md`
4. `main` 在 UI 重构前已经存在的业务行为与数据模型

`feature-glass-like`、`origin/feature-glass-like` 以及其他历史视觉实验分支仅用于确认需要避开的实现，不是代码来源。

## Frozen Git Objects

来源审计使用固定对象而不是可移动分支名作为证据基线：

- UI 重构前的 `main`：`f34dbd5221b71a8539e7fac8559602ade876ed23`
- 本地 Glasslike tip：`bf74e2ca9848c7dcb8e325c313e42aae46234880`
- 远端 Glasslike tip：`ed3d2df1cac27f5c6b59b1838cf1d1de0274c317`

门禁扫描两个 Glasslike tip 从共同基线开始的全部 UI 提交历史，而不只比较分支最终文件。若命名分支移动，审计直接失败，必须先审查新增历史并显式更新本节与检查脚本。

`main` 的缓存清理提交 `9ddc28df` 与本地 Glasslike 的 `e0d5d29d` 补丁等价；该补丁只删除误提交缓存并更新忽略规则，不包含 `lib/`、`test/` 或 UI 实现，因此不属于本设计系统的代码来源。

## Baseline Audit

在 clean-room 重写开始前，审计确认当前未提交工作区存在以下历史血缘：

- `AppIcons` 的多数 glyph 选择与 Glasslike 映射相同。
- `AppTheme`、主题颜色选择器和少量页面结构保留了可归因于 Glasslike UI 提交的实现行。
- Glasslike 的运行时玻璃 primitive 已经清零，但“没有玻璃效果”不等于“没有复用代码”。

这些片段必须依据当前设计合同重新实现，不能通过重命名、移动文件或格式化来规避来源审计。

## Acceptance Standard

clean-room 完成需要同时满足：

- 两个 Glasslike 分支的 UI 提交均不在当前分支祖先中。
- 排除共同 `main` 基线后，当前实现不保留 Glasslike 独有实现行。
- 标志性 Glass/MusicChrome API 搜索结果为零。
- Remix Icons 的使用有当前语义依据，映射表由 Echo 操作清单独立生成。
- 完整提交序列通过 `flutter analyze`、`flutter test` 与关键设备验收。

## Commit Boundaries

提交顺序固定为 P0 contract、P1 foundations、P2 shell/player、P3 primary/library、P4 forms/settings、P4b metadata editor、P5 resilience、P6 docs/build。后续阶段不能把本应属于前置阶段的共享实现混入页面提交。

UI 阶段发现的 service、repository、provider、API 或播放行为缺陷必须独立提交，不得借 P5 resilience 混入 UI 提交。

P2-P6 必须在只包含当前 clean-room 分支历史的隔离 clone 中实现。该 clone 不得包含 Glasslike refs、Glasslike Git 对象、旧污染 stash 或指向含这些对象仓库的 remote；阶段完成后仅导出提交到主仓库进行来源审计。

## Final Audit - 2026-07-15

最终 UI 代码审计对象为：

- 分支：`codex/zero-reuse-ui`
- 代码 HEAD：`f9615e727660b85429a168994f23767db020f539`

跨仓只读冻结对象扫描结果：

- Glasslike UI 提交祖先交集：`0 / 6`
- stable patch-id 交集：`0 / 6`
- Glasslike UI 新 blob：89 个，隔离仓存在 `0`
- 三行来源窗口命中：`0`
- 36-token 精确窗口命中：`0`
- 52-token canonical 窗口命中：`0`
- legacy mechanical structure 命中：`0`
- `Icons.*`：`0`
- 明列禁用 Material 构造器：`0`
- Glass / MusicChrome runtime 标记：`0`

对象隔离检查覆盖 206 个 Glasslike 范围对象，其中 205 个在隔离仓中不存在。唯一共享对象仍是已批准的 `.gitignore` 缓存清理 blob，对应 Glasslike `e0d5d29d` 与主线 `9ddc28df`，不含 UI、业务源码或测试实现。

在 `98c1f788` 的最终预审中，门禁曾发现 `app_drawer.dart` 的“切换线路”条目有一个三行窗口与 Glasslike 历史完全相同。该片段没有获得例外豁免，而是在 `f9615e72` 中依据当前业务语义独立改写，并重新执行全部门禁；最终所有来源窗口计数均为零。

隔离仓按设计不含两条 Glasslike ref，因此直接运行依赖本地 ref 的审计入口会返回退出码 `2`。最终结论使用相同扫描口径，从主仓冻结对象只读生成 Glasslike 集合，再与隔离仓进行比较；没有向隔离仓导入 ref、commit、tree、blob、remote 或 stash。

## Final Verification

在代码 HEAD `f9615e72` 上完成：

- `flutter analyze`：0 个问题
- `flutter test`：225 / 225 通过，0 跳过，0 失败
- `git diff --check`：通过
- `test/widgets/app_drawer_test.dart`：3 / 3 通过

在此前 UI HEAD `98c1f788` 上已完成 Debug 与 Release APK 构建。`f9615e72` 只改变抽屉副标题的等价表达，不涉及构建、签名或可见 UI；完整分析与测试已在该代码 HEAD 上重新通过。

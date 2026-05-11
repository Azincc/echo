import 'package:echoes/data/models/music_library.dart';
import 'package:echoes/data/models/server_address.dart';
import 'package:echoes/features/download/pages/download_manager_page.dart';
import 'package:echoes/features/offline/pages/offline_download_status_page.dart';
import 'package:echoes/features/settings/pages/app_settings_page.dart';
import 'package:echoes/features/settings/pages/playback_stats_page.dart';
import 'package:echoes/providers/api_provider.dart';
import 'package:echoes/providers/library_provider.dart';
import 'package:flutter/material.dart';
import 'package:echoes/core/theme/app_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/auth_provider.dart';
import '../providers/music_provider.dart';
import '../providers/offline_download_provider.dart';
import '../providers/player_provider.dart';
import '../providers/playlist_provider.dart';
import 'music_chrome.dart';

/// 应用侧栏
class AppDrawer extends ConsumerStatefulWidget {
  const AppDrawer({super.key});

  @override
  ConsumerState<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends ConsumerState<AppDrawer> {
  bool _showLibraries = false;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final activeLibrary = authState.currentLibrary;
    final activeAddress = ref.watch(activeAddressProvider);

    final theme = Theme.of(context);

    return Drawer(
      backgroundColor: theme.colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildHeader(context, activeLibrary, activeAddress),
            Expanded(
              child: _showLibraries
                  ? _buildLibraryList(context, activeLibrary)
                  : _buildNavigationList(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    MusicLibrary? activeLibrary,
    ServerAddress? activeAddress,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final primary = colorScheme.primary;
    final primaryContainer = colorScheme.primaryContainer;
    final avatarUrl = _resolveAvatarUrl(activeLibrary);

    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
      child: MusicGlassSurface(
        borderRadius: BorderRadius.circular(20),
        padding: const EdgeInsets.all(14),
        color: Color.lerp(
          colorScheme.surfaceContainer,
          primaryContainer,
          theme.brightness == Brightness.dark ? 0.28 : 0.44,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: primary.withValues(alpha: 0.16),
              foregroundImage: avatarUrl != null
                  ? NetworkImage(avatarUrl)
                  : null,
              child: avatarUrl == null
                  ? Icon(AppIcons.person, size: 30, color: primary)
                  : null,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activeLibrary?.username ?? 'Guest',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    activeLibrary?.name ?? '未选择',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: activeAddress == null
                              ? colorScheme.outline
                              : _statusColor(context, activeAddress.status),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.5),
                            width: 1,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          activeAddress?.label ?? '未连接',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                            fontSize: 11,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                _showLibraries
                    ? AppIcons.keyboard_arrow_up
                    : AppIcons.keyboard_arrow_down,
              ),
              tooltip: '切换音乐库视图',
              onPressed: () {
                setState(() {
                  _showLibraries = !_showLibraries;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Color _statusColor(BuildContext context, ServerAddressStatus status) {
    switch (status) {
      case ServerAddressStatus.ok:
        return Colors.greenAccent.shade400;
      case ServerAddressStatus.failed:
        return Theme.of(context).colorScheme.error;
      case ServerAddressStatus.unknown:
        return Theme.of(context).colorScheme.outline;
    }
  }

  Widget _drawerSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 6),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _drawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
    bool selected = false,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final iconColor = selected ? colorScheme.primary : colorScheme.onSurface;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      child: Material(
        color: selected
            ? colorScheme.primary.withValues(
                alpha: theme.brightness == Brightness.dark ? 0.18 : 0.1,
              )
            : Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: iconColor.withValues(
                      alpha: selected
                          ? (theme.brightness == Brightness.dark ? 0.2 : 0.12)
                          : (theme.brightness == Brightness.dark ? 0.12 : 0.08),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, size: 20, color: iconColor),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: selected
                              ? FontWeight.w800
                              : FontWeight.w700,
                        ),
                      ),
                      if (subtitle != null && subtitle.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (trailing != null) ...[const SizedBox(width: 8), trailing],
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _resolveAvatarUrl(MusicLibrary? library) {
    if (library == null) return null;
    final raw = library.extensions['avatarUrl'];
    if (raw is! String || raw.trim().isEmpty) return null;
    final uri = Uri.tryParse(raw.trim());
    if (uri == null || (!uri.hasScheme && !uri.hasAbsolutePath)) return null;
    return raw.trim();
  }

  Widget _buildLibraryList(BuildContext context, MusicLibrary? activeLibrary) {
    final asyncLibraries = ref.watch(librariesProvider);

    return asyncLibraries.when(
      data: (libs) {
        return ListView(
          padding: const EdgeInsets.fromLTRB(0, 4, 0, 24),
          children: [
            _drawerSectionTitle(context, '音乐库'),
            ...libs.map((lib) {
              final isActive = lib.id == activeLibrary?.id;
              return _drawerItem(
                context,
                icon: isActive ? AppIcons.check_circle : AppIcons.library_music,
                title: lib.name,
                subtitle: lib.addresses.firstOrNull?.url ?? 'No Address',
                selected: isActive,
                onTap: () {
                  if (!isActive) {
                    _switchLibrary(lib);
                  }
                  setState(() {
                    _showLibraries = false;
                  });
                  Navigator.pop(context);
                },
                trailing: IconButton(
                  icon: const Icon(AppIcons.edit),
                  onPressed: () {
                    context.push('/library/edit/${lib.id}');
                  },
                ),
              );
            }),
            const SizedBox(height: 8),
            _drawerItem(
              context,
              icon: AppIcons.add,
              title: '添加新音乐库',
              onTap: () {
                context.push('/login?add=true');
              },
            ),
          ],
        );
      },
      error: (err, stack) => Center(child: Text('Error: $err')),
      loading: () => const MusicLoadingPane(minHeight: 96),
    );
  }

  Widget _buildNavigationList(BuildContext context) {
    final downloadSummary = ref.watch(offlineDownloadSummaryProvider);

    return ListView(
      padding: const EdgeInsets.fromLTRB(0, 4, 0, 24),
      children: [
        _drawerSectionTitle(context, '连接'),
        Consumer(
          builder: (context, ref, child) {
            final activeAddress = ref.watch(activeAddressProvider);
            return _drawerItem(
              context,
              icon: AppIcons.router,
              title: '切换线路',
              subtitle: activeAddress?.label ?? '自动选择',
              trailing: const Icon(AppIcons.chevron_right),
              onTap: () {
                Navigator.pop(context);
                _showRouteSelectionDialog(context);
              },
            );
          },
        ),
        _drawerSectionTitle(context, '资料'),
        _drawerItem(
          context,
          icon: AppIcons.analytics_outlined,
          title: '统计信息',
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PlaybackStatsPage(),
              ),
            );
          },
        ),
        _drawerItem(
          context,
          icon: AppIcons.download_outlined,
          title: '下载管理',
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DownloadManagerPage(),
              ),
            );
          },
        ),
        _drawerItem(
          context,
          icon: AppIcons.offline_pin_outlined,
          title: '离线下载状态',
          subtitle: downloadSummary.total == 0
              ? '暂无任务'
              : '进行中 ${downloadSummary.active} · 完成 ${downloadSummary.completed} · 失败 ${downloadSummary.failed}',
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const OfflineDownloadStatusPage(),
              ),
            );
          },
        ),
        _drawerSectionTitle(context, '应用'),
        _drawerItem(
          context,
          icon: AppIcons.settings_outlined,
          title: '设置',
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AppSettingsPage()),
            );
          },
        ),
      ],
    );
  }

  Future<void> _switchLibrary(MusicLibrary lib) async {
    final repo = ref.read(libraryRepositoryProvider);
    await repo.setActiveLibrary(lib.id);
    ref.read(authStateProvider.notifier).switchLibrary(lib);

    ref.invalidate(playerProvider);
    ref.invalidate(randomSongsProvider);
    ref.invalidate(recentAlbumsProvider);
    ref.invalidate(frequentAlbumsProvider);
    ref.invalidate(playlistsProvider);
    ref.invalidate(starredProvider);
  }

  Future<void> _showRouteSelectionDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => Consumer(
        builder: (context, ref, _) {
          final authState = ref.watch(authStateProvider);
          final activeLibId = authState.currentLibrary?.id;
          final librariesAsync = ref.watch(librariesProvider);
          final activeAddress = ref.watch(activeAddressProvider);
          final addressPool = ref.read(addressPoolProvider);

          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('切换线路'),
                IconButton(
                  icon: const Icon(AppIcons.refresh),
                  tooltip: '检测延迟',
                  onPressed: () {
                    addressPool.probeAll();
                  },
                ),
              ],
            ),
            content: librariesAsync.when(
              data: (libs) {
                // 使用 addressPool 中的实时地址状态，而非 DB 中可能过期的快照
                final poolAddresses = addressPool.addresses;
                final addresses = List<ServerAddress>.from(
                  poolAddresses.isNotEmpty
                      ? poolAddresses
                      : libs
                            .firstWhere(
                              (l) => l.id == activeLibId,
                              orElse: () => libs.first,
                            )
                            .addresses,
                )..sort((a, b) => a.priority.compareTo(b.priority));

                final isAuto = !addresses.any(
                  (a) => a.isLocked && a.id == activeAddress?.id,
                );

                return SizedBox(
                  width: double.maxFinite,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      MusicSelectionTile(
                        leading: const Icon(AppIcons.hdr_auto),
                        selected: isAuto,
                        title: '自动选择',
                        subtitle: isAuto ? '当前: ${activeAddress?.label}' : null,
                        onTap: () {
                          addressPool.setAutoMode();
                          Navigator.pop(context);
                        },
                      ),
                      ...addresses.map((addr) {
                        final isSelected =
                            activeAddress?.id == addr.id && addr.isLocked;
                        return MusicSelectionTile(
                          title: addr.label,
                          subtitle:
                              '${addr.url}\n延迟: ${addr.lastLatencyMs != null ? "${addr.lastLatencyMs}ms" : "未知"}',
                          selected: isSelected,
                          trailing: isSelected
                              ? Icon(
                                  AppIcons.check,
                                  color: Theme.of(context).colorScheme.primary,
                                )
                              : _getStatusIcon(addr.status),
                          onTap: () {
                            addressPool.setManualMode(addr);
                            Navigator.pop(context);
                          },
                        );
                      }),
                    ],
                  ),
                );
              },
              loading: () => const MusicLoadingPane(minHeight: 100),
              error: (err, stack) => Text('Error: $err'),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('取消'),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _getStatusIcon(ServerAddressStatus status) {
    switch (status) {
      case ServerAddressStatus.ok:
        return Icon(
          AppIcons.circle,
          color: Colors.greenAccent.shade400,
          size: 12,
        );
      case ServerAddressStatus.failed:
        return const Icon(AppIcons.error, color: Colors.red, size: 12);
      case ServerAddressStatus.unknown:
        return const Icon(AppIcons.help, color: Colors.grey, size: 12);
    }
  }
}

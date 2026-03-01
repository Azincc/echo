import 'package:echoes/data/models/music_library.dart';
import 'package:echoes/data/models/server_address.dart';
import 'package:echoes/features/download/pages/download_manager_page.dart';
import 'package:echoes/features/offline/pages/offline_download_status_page.dart';
import 'package:echoes/features/settings/pages/app_settings_page.dart';
import 'package:echoes/features/settings/pages/playback_stats_page.dart';
import 'package:echoes/providers/api_provider.dart';
import 'package:echoes/providers/library_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/auth_provider.dart';
import '../providers/music_provider.dart';
import '../providers/offline_download_provider.dart';
import '../providers/player_provider.dart';
import '../providers/playlist_provider.dart';

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

    return Drawer(
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
    );
  }

  Widget _buildHeader(
    BuildContext context,
    MusicLibrary? activeLibrary,
    ServerAddress? activeAddress,
  ) {
    final primary = Theme.of(context).colorScheme.primary;
    final primaryContainer = Theme.of(context).colorScheme.primaryContainer;
    final onPrimary = Theme.of(context).colorScheme.onPrimary;
    final avatarUrl = _resolveAvatarUrl(activeLibrary);

    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
      decoration: BoxDecoration(
        color: primary,
        gradient: LinearGradient(
          colors: [primary, primaryContainer],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: onPrimary,
            foregroundImage: avatarUrl != null ? NetworkImage(avatarUrl) : null,
            child: avatarUrl == null
                ? Icon(Icons.person, size: 32, color: primary)
                : null,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activeLibrary?.username ?? 'Guest',
                  style: TextStyle(
                    color: onPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  activeLibrary?.name ?? '未选择',
                  style: TextStyle(
                    color: onPrimary.withValues(alpha: 0.9),
                    fontSize: 13,
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
                            ? Colors.grey.shade300
                            : (activeAddress.status == ServerAddressStatus.ok
                                  ? Colors.greenAccent
                                  : Colors.redAccent),
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
                        style: TextStyle(
                          color: onPrimary.withValues(alpha: 0.8),
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
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down,
              color: onPrimary,
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
          padding: EdgeInsets.zero,
          children: [
            ...libs.map((lib) {
              final isActive = lib.id == activeLibrary?.id;
              return ListTile(
                leading: isActive
                    ? const Icon(Icons.check, color: Colors.green)
                    : const Icon(Icons.library_music),
                title: Text(lib.name),
                subtitle: Text(lib.addresses.firstOrNull?.url ?? 'No Address'),
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
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    context.push('/library/edit/${lib.id}');
                  },
                ),
              );
            }),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('添加新音乐库'),
              onTap: () {
                context.push('/login?add=true');
              },
            ),
          ],
        );
      },
      error: (err, stack) => Center(child: Text('Error: $err')),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildNavigationList(BuildContext context) {
    final downloadSummary = ref.watch(offlineDownloadSummaryProvider);

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        ListTile(
          leading: const Icon(Icons.router),
          title: const Text('切换线路'),
          subtitle: Consumer(
            builder: (context, ref, child) {
              final activeAddress = ref.watch(activeAddressProvider);
              return Text(
                activeAddress?.label ?? '自动选择',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 10),
              );
            },
          ),
          onTap: () {
            Navigator.pop(context);
            _showRouteSelectionDialog(context);
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.analytics_outlined),
          title: const Text('统计信息'),
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
        ListTile(
          leading: const Icon(Icons.download_outlined),
          title: const Text('下载管理'),
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
        ListTile(
          leading: const Icon(Icons.offline_pin_outlined),
          title: const Text('离线下载状态'),
          subtitle: Text(
            downloadSummary.total == 0
                ? '暂无任务'
                : '进行中 ${downloadSummary.active} · 完成 ${downloadSummary.completed} · 失败 ${downloadSummary.failed}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 10),
          ),
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
        const Divider(),
        ListTile(
          leading: const Icon(Icons.settings_outlined),
          title: const Text('设置'),
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
                  icon: const Icon(Icons.refresh),
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
                      ListTile(
                        leading: const Icon(Icons.hdr_auto),
                        title: const Text('自动选择'),
                        subtitle: isAuto
                            ? Text('当前: ${activeAddress?.label}')
                            : null,
                        trailing: isAuto
                            ? const Icon(Icons.check, color: Colors.green)
                            : null,
                        onTap: () {
                          addressPool.setAutoMode();
                          Navigator.pop(context);
                        },
                      ),
                      const Divider(),
                      ...addresses.map((addr) {
                        final isSelected =
                            activeAddress?.id == addr.id && addr.isLocked;
                        return ListTile(
                          title: Text(addr.label),
                          subtitle: Text(
                            '${addr.url}\n延迟: ${addr.lastLatencyMs != null ? "${addr.lastLatencyMs}ms" : "未知"}',
                          ),
                          isThreeLine: true,
                          trailing: isSelected
                              ? const Icon(Icons.check, color: Colors.green)
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
              loading: () => const SizedBox(
                height: 100,
                child: Center(child: CircularProgressIndicator()),
              ),
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
        return const Icon(Icons.circle, color: Colors.green, size: 12);
      case ServerAddressStatus.failed:
        return const Icon(Icons.error, color: Colors.red, size: 12);
      case ServerAddressStatus.unknown:
        return const Icon(Icons.help, color: Colors.grey, size: 12);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:echoes/data/models/music_library.dart';
import 'package:echoes/data/models/server_address.dart';
import 'package:echoes/providers/api_provider.dart';
import 'package:echoes/providers/library_provider.dart';
import 'package:echoes/data/sources/local_storage.dart';
import '../providers/auth_provider.dart';
import '../providers/player_provider.dart';
import '../providers/playlist_provider.dart';
import '../providers/music_provider.dart';
import '../features/settings/pages/lyrics_providers_page.dart';
import '../features/settings/pages/cover_providers_page.dart';
import '../features/settings/pages/audio_quality_page.dart';
import '../features/download/pages/download_manager_page.dart';
import '../providers/audio_cache_provider.dart';

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
          // 左侧：头像
          CircleAvatar(
            radius: 28,
            backgroundColor: onPrimary,
            foregroundImage: avatarUrl != null ? NetworkImage(avatarUrl) : null,
            child: avatarUrl == null
                ? Icon(Icons.person, size: 32, color: primary)
                : null,
          ),
          const SizedBox(width: 16),
          // 中间：信息
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
                          color: Colors.white.withOpacity(0.5),
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
          // 右侧：箭头
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

  Widget _buildDefaultAvatar(Color bg, Color fg) {
    return ColoredBox(
      color: bg,
      child: Icon(Icons.person, size: 40, color: fg),
    );
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
                  // Close drawer or switch back?
                  // Usually Material Drawer stays open or toggles back.
                  // Let's toggle back to nav after switch?
                  setState(() {
                    _showLibraries = false;
                  });
                  Navigator.pop(context); // Close drawer to reflect changes
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
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        // 切换线路
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
            Navigator.pop(context); // Optional: keep drawer open?
            // Usually switch route is a quick action, maybe keep drawer open or use dialog on top.
            // User requested "appdrawer添加...功能", implying inside appdrawer or accessible from it.
            // Let's close drawer and show dialog for better UX.
            _showRouteSelectionDialog(context);
          },
        ),

        // 歌词提供商
        ListTile(
          leading: const Icon(Icons.lyrics),
          title: const Text('歌词提供商'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LyricsProvidersPage(),
              ),
            );
          },
        ),

        // 封面提供商
        ListTile(
          leading: const Icon(Icons.image),
          title: const Text('封面提供商'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CoverProvidersPage(),
              ),
            );
          },
        ),

        // 音质设置
        ListTile(
          leading: const Icon(Icons.high_quality_outlined),
          title: const Text('音质设置'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AudioQualityPage()),
            );
          },
        ),

        const Divider(),

        // 统计信息
        ListTile(
          leading: const Icon(Icons.analytics_outlined),
          title: const Text('统计信息'),
          onTap: () {
            Navigator.pop(context);
            _showComingSoonDialog(context, '统计信息');
          },
        ),

        // 下载管理
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

        const Divider(),

        // 设置
        ListTile(
          leading: const Icon(Icons.settings_outlined),
          title: const Text('设置'),
          onTap: () {
            Navigator.pop(context);
            _showSettingsDialog(context);
          },
        ),

        // 关于
        ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text('关于'),
          onTap: () {
            Navigator.pop(context);
            _showAboutDialog(context);
          },
        ),
      ],
    );
  }

  Future<void> _switchLibrary(MusicLibrary lib) async {
    final repo = ref.read(libraryRepositoryProvider);
    await repo.setActiveLibrary(lib.id);
    // Update AuthState to reflect change
    ref.read(authStateProvider.notifier).switchLibrary(lib);

    // 切换库后停止音乐并刷新所有数据
    ref.invalidate(playerProvider);
    ref.invalidate(randomSongsProvider);
    ref.invalidate(recentAlbumsProvider);
    ref.invalidate(frequentAlbumsProvider);
    ref.invalidate(playlistsProvider);
    ref.invalidate(starredProvider);
  }

  /// 显示"即将推出"对话框
  void _showComingSoonDialog(BuildContext context, String feature) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(feature),
        content: const Text('该功能即将推出，敬请期待！'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  /// 显示设置对话框
  void _showSettingsDialog(BuildContext context) {
    final authState = ref.read(authStateProvider);
    final library = authState.currentLibrary;
    final activeAddress = ref.read(activeAddressProvider);

    showDialog(
      context: context,
      builder: (context) => Consumer(
        builder: (context, ref, _) {
          final autoFallback = ref.watch(autoFallbackProvider);

          return AlertDialog(
            title: const Text('设置'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 服务器信息
                  Text(
                    '服务器信息',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildInfoRow('当前连接', activeAddress?.label ?? '未连接'),
                  _buildInfoRow('服务器地址', activeAddress?.url ?? '未设置'),
                  _buildInfoRow('用户名', library?.username ?? '未设置'),
                  _buildInfoRow(
                    '认证方式',
                    library?.authType == MusicLibraryAuthType.apiKey
                        ? 'API Key'
                        : '密码',
                  ),
                  const Divider(height: 24),

                  // 应用设置
                  Text(
                    '应用设置',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('线路自动回退'),
                    subtitle: const Text(
                      '手动选择线路后，若该线路不可用，自动切换到其他可用线路',
                      style: TextStyle(fontSize: 12),
                    ),
                    value: autoFallback,
                    onChanged: (value) async {
                      ref.read(autoFallbackProvider.notifier).state = value;
                      ref.read(addressPoolProvider).autoFallback = value;
                      await LocalStorage.setAutoFallback(value);
                    },
                  ),
                  const Divider(height: 24),

                  // 缓存管理
                  Text(
                    '缓存管理',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Consumer(
                    builder: (context, ref, _) {
                      final sizeAsync = ref.watch(cacheSizeProvider);
                      return sizeAsync.when(
                        data: (size) {
                          final mb = size / (1024 * 1024);
                          final gb = mb / 1024;
                          String sizeStr;
                          if (gb >= 1) {
                            sizeStr = '${gb.toStringAsFixed(2)} GB';
                          } else {
                            sizeStr = '${mb.toStringAsFixed(1)} MB';
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildInfoRow('当前占用', sizeStr),
                              const SizedBox(height: 8),
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton.icon(
                                  onPressed: () async {
                                    final confirmed = await showDialog<bool>(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('清除缓存'),
                                        content: const Text('确定要清除所有音频缓存吗？'),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, false),
                                            child: const Text('取消'),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, true),
                                            child: const Text('清除'),
                                          ),
                                        ],
                                      ),
                                    );

                                    if (confirmed == true) {
                                      await ref
                                          .read(audioCacheServiceProvider)
                                          .clearAll();
                                      ref.invalidate(cacheSizeProvider);
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text('缓存已清除'),
                                          ),
                                        );
                                      }
                                    }
                                  },
                                  icon: const Icon(Icons.delete_outline),
                                  label: const Text('清除缓存'),
                                ),
                              ),
                            ],
                          );
                        },
                        loading: () => const Text('正在计算缓存大小...'),
                        error: (error, stackTrace) => const Text('无法获取缓存大小'),
                      );
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('关闭'),
              ),
            ],
          );
        },
      ),
    );
  }

  /// 显示关于对话框
  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Echo',
      applicationVersion: '1.0.0',
      applicationIcon: const FlutterLogo(size: 48),
      applicationLegalese: '© 2026 Echo Music Player',
      children: [
        const SizedBox(height: 16),
        const Text(
          'Echo 是一个基于 Subsonic API 的音乐播放器，'
          '支持 Navidrome、Airsonic 等服务器。',
        ),
        const SizedBox(height: 16),
        const Text('功能特性：'),
        const Text('• 支持多种音频格式（APE/M4A/FLAC 等）'),
        const Text('• 自动转码不支持的格式'),
        const Text('• 后台播放和通知栏控制'),
        const Text('• 收藏和播放列表管理'),
        const Text('• 多服务器地址自动切换 (v0.2.0)'),
      ],
    );
  }

  /// 构建信息行
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 12))),
        ],
      ),
    );
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
                    addressPool
                        .probeAll(); // Trigger probe, UI updates via Stream
                  },
                ),
              ],
            ),
            content: librariesAsync.when(
              data: (libs) {
                final lib = libs.firstWhere(
                  (l) => l.id == activeLibId,
                  orElse: () => libs.first, // Fallback
                );
                final addresses = List<ServerAddress>.from(lib.addresses)
                  ..sort((a, b) => a.priority.compareTo(b.priority));

                final isAuto = !addresses.any(
                  (a) => a.isLocked && a.id == activeAddress?.id,
                );

                return SizedBox(
                  width: double.maxFinite,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      // 自动选择选项
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
                      // 地址列表
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

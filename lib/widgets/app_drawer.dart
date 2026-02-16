import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:echoes/data/models/music_library.dart';
import 'package:echoes/data/models/server_address.dart';
import 'package:echoes/providers/api_provider.dart';
import 'package:echoes/providers/library_provider.dart';
import '../providers/auth_provider.dart';
import '../providers/player_provider.dart';
import '../providers/playlist_provider.dart';
import '../providers/music_provider.dart';
import '../features/settings/pages/lyrics_providers_page.dart';
import '../features/settings/pages/cover_providers_page.dart';
import '../features/settings/pages/audio_quality_page.dart';
import '../features/settings/pages/app_settings_page.dart';
import '../features/download/pages/download_manager_page.dart';

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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AppSettingsPage()),
            );
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

  /// 显示关于对话框
  void _showAboutDialog(BuildContext context) {
    const githubHome = 'https://github.com/Azincc/echo';
    const githubIssues = 'https://github.com/Azincc/echo/issues';

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
        const SizedBox(height: 16),
        const Text('项目地址：'),
        _buildLinkRow(context, 'GitHub 首页', githubHome),
        const SizedBox(height: 8),
        const Text('反馈问题：'),
        _buildLinkRow(context, 'GitHub Issues', githubIssues),
      ],
    );
  }

  Widget _buildLinkRow(BuildContext context, String label, String url) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 2),
              SelectableText(
                url,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          tooltip: '打开链接',
          onPressed: () async {
            await _openExternalUrl(context, url);
          },
          icon: const Icon(Icons.arrow_outward, size: 18),
        ),
      ],
    );
  }

  Future<void> _openExternalUrl(BuildContext context, String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) {
      if (context.mounted) {
        ScaffoldMessenger.maybeOf(
          context,
        )?.showSnackBar(const SnackBar(content: Text('链接格式无效')));
      }
      return;
    }

    try {
      final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!opened && context.mounted) {
        ScaffoldMessenger.maybeOf(
          context,
        )?.showSnackBar(const SnackBar(content: Text('无法打开链接')));
      }
    } on MissingPluginException {
      if (context.mounted) {
        ScaffoldMessenger.maybeOf(
          context,
        )?.showSnackBar(const SnackBar(content: Text('请完整重启应用后再试')));
      }
    } on PlatformException {
      if (context.mounted) {
        ScaffoldMessenger.maybeOf(
          context,
        )?.showSnackBar(const SnackBar(content: Text('无法打开浏览器，请稍后重试')));
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.maybeOf(
          context,
        )?.showSnackBar(const SnackBar(content: Text('打开链接失败')));
      }
    }
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

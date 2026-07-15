import 'dart:async';

import 'package:echoes/core/design/echo_design.dart';
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
import 'echo_app_shell/echo_drawer.dart';

/// Echo's application drawer. [Scaffold] still supplies platform drawer
/// routing, focus, and back behavior; every visible surface is owned here.
class AppDrawer extends ConsumerStatefulWidget {
  const AppDrawer({super.key, this.onReturnFocus});

  final VoidCallback? onReturnFocus;

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

    return EchoDrawerFrame(
      header: EchoDrawerIdentityHeader(
        username: activeLibrary?.username ?? 'Guest',
        libraryName: activeLibrary?.name ?? '未选择',
        addressLabel: activeAddress?.label ?? '没有活动线路',
        connectionState: _connectionState(activeAddress),
        avatarUrl: resolveEchoDrawerAvatarUrl(activeLibrary),
        showingLibraries: _showLibraries,
        onToggleLibraries: () {
          setState(() {
            _showLibraries = !_showLibraries;
          });
        },
      ),
      child: _showLibraries
          ? _buildLibraryList(activeLibrary)
          : _buildNavigationList(activeAddress),
    );
  }

  Widget _buildLibraryList(MusicLibrary? activeLibrary) {
    final libraries = ref.watch(librariesProvider);

    return libraries.when(
      data: (items) {
        if (items.isEmpty) {
          return EchoEmptyState(
            title: '还没有音乐库',
            description: '添加一个 Navidrome、Subsonic 或 OpenSubsonic 音乐库后即可开始聆听。',
            icon: AppIcons.library,
            actionLabel: '添加音乐库',
            onAction: () => _closeDrawerAndPushLocation('/login?add=true'),
          );
        }

        return ListView.builder(
          key: const PageStorageKey<String>('echo-drawer-libraries'),
          padding: EdgeInsets.symmetric(vertical: context.echoSpacing.xs),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemCount: items.length + 2,
          itemBuilder: (context, index) {
            if (index < items.length) {
              final library = items[index];
              final isActive = library.id == activeLibrary?.id;
              return Padding(
                padding: EdgeInsets.only(bottom: context.echoSpacing.xs),
                child: EchoDrawerLibraryRow(
                  title: library.name,
                  subtitle: library.addresses.firstOrNull?.url ?? '未配置服务器地址',
                  selected: isActive,
                  onSelected: () {
                    if (!isActive) {
                      _switchLibrary(library);
                    }
                    setState(() {
                      _showLibraries = false;
                    });
                    Navigator.of(context).pop();
                  },
                  onEdit: () => _closeDrawerAndPushLocation(
                    '/library/edit/${library.id}',
                  ),
                ),
              );
            }

            if (index == items.length) {
              return Padding(
                padding: EdgeInsets.fromLTRB(
                  context.echoSpacing.md,
                  context.echoSpacing.xxs,
                  context.echoSpacing.md,
                  context.echoSpacing.sm,
                ),
                child: const EchoDivider(),
              );
            }

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: context.echoSpacing.xs),
              child: EchoActionRow(
                icon: AppIcons.add,
                title: '添加新音乐库',
                subtitle: '连接另一台服务器或另一个账户',
                onPressed: () => _closeDrawerAndPushLocation('/login?add=true'),
              ),
            );
          },
        );
      },
      loading: () => const _DrawerSkeletonList(),
      error: (error, stackTrace) => EchoErrorState(
        title: '无法读取音乐库',
        description: '音乐库列表暂时不可用。重试不会影响当前正在播放的内容。',
        actionLabel: '重试',
        onAction: () => ref.invalidate(librariesProvider),
      ),
    );
  }

  Widget _buildNavigationList(ServerAddress? activeAddress) {
    final downloadSummary = ref.watch(offlineDownloadSummaryProvider);
    final routeLabel = activeAddress?.label.trim();
    final entries = <_DrawerNavigationEntry?>[
      _DrawerNavigationEntry(
        title: '切换线路',
        icon: AppIcons.router,
        subtitle: routeLabel == null || routeLabel.isEmpty
            ? '自动选择'
            : routeLabel,
        onPressed: _closeDrawerAndShowRouteSelection,
      ),
      null,
      _DrawerNavigationEntry(
        icon: AppIcons.analytics,
        title: '统计信息',
        onPressed: () =>
            _closeDrawerAndPushPage((context) => const PlaybackStatsPage()),
      ),
      _DrawerNavigationEntry(
        icon: AppIcons.downloadOutline,
        title: '下载管理',
        onPressed: () =>
            _closeDrawerAndPushPage((context) => const DownloadManagerPage()),
      ),
      _DrawerNavigationEntry(
        icon: AppIcons.offline,
        title: '离线下载状态',
        subtitle: downloadSummary.total == 0
            ? '暂无任务'
            : '进行中 ${downloadSummary.active} · 完成 ${downloadSummary.completed} · '
                  '失败 ${downloadSummary.failed}',
        onPressed: () => _closeDrawerAndPushPage(
          (context) => const OfflineDownloadStatusPage(),
        ),
      ),
      null,
      _DrawerNavigationEntry(
        icon: AppIcons.settings,
        title: '设置',
        onPressed: () =>
            _closeDrawerAndPushPage((context) => const AppSettingsPage()),
      ),
    ];

    return ListView.builder(
      key: const PageStorageKey<String>('echo-drawer-navigation'),
      padding: EdgeInsets.symmetric(vertical: context.echoSpacing.xs),
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final entry = entries[index];
        if (entry == null) {
          return Padding(
            padding: EdgeInsets.fromLTRB(
              context.echoSpacing.md,
              context.echoSpacing.xxs,
              context.echoSpacing.md,
              context.echoSpacing.xs,
            ),
            child: const EchoDivider(),
          );
        }

        return Padding(
          padding: EdgeInsets.fromLTRB(
            context.echoSpacing.xs,
            0,
            context.echoSpacing.xs,
            context.echoSpacing.xs,
          ),
          child: EchoActionRow(
            icon: entry.icon,
            title: entry.title,
            subtitle: entry.subtitle,
            trailing: Icon(
              AppIcons.chevronRight,
              size: context.echoInteraction.smallIconSize,
              color: context.echoColors.muted,
            ),
            onPressed: entry.onPressed,
          ),
        );
      },
    );
  }

  Future<void> _switchLibrary(MusicLibrary library) async {
    final repository = ref.read(libraryRepositoryProvider);
    await repository.setActiveLibrary(library.id);
    ref.read(authStateProvider.notifier).switchLibrary(library);

    ref.invalidate(playerProvider);
    ref.invalidate(randomSongsProvider);
    ref.invalidate(recentAlbumsProvider);
    ref.invalidate(frequentAlbumsProvider);
    ref.invalidate(playlistsProvider);
    ref.invalidate(starredProvider);
  }

  void _closeDrawerAndPushPage(WidgetBuilder builder) {
    final navigator = Navigator.of(context);
    navigator.pop();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!navigator.mounted) return;
      navigator.push(
        EchoPageRoute<void>(context: navigator.context, builder: builder),
      );
    });
  }

  void _closeDrawerAndPushLocation(String location) {
    final router = GoRouter.of(context);
    final navigator = Navigator.of(context);
    navigator.pop();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!navigator.mounted) return;
      router.push(location);
    });
  }

  void _closeDrawerAndShowRouteSelection() {
    final navigator = Navigator.of(context);
    final onReturnFocus = widget.onReturnFocus;
    navigator.pop();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!navigator.mounted) return;
      unawaited(
        _showRouteSelectionSheet(navigator.context, onClosed: onReturnFocus),
      );
    });
  }

  Future<void> _showRouteSelectionSheet(
    BuildContext hostContext, {
    VoidCallback? onClosed,
  }) async {
    try {
      await showEchoBottomSheet<void>(
        context: hostContext,
        useRootNavigator: true,
        isScrollControlled: true,
        builder: (sheetContext) {
          return Consumer(
            builder: (context, ref, child) {
              final authState = ref.watch(authStateProvider);
              final activeLibraryId = authState.currentLibrary?.id;
              final libraries = ref.watch(librariesProvider);
              final activeAddress = ref.watch(activeAddressProvider);
              final addressPool = ref.read(addressPoolProvider);

              return EchoBottomSheet(
                title: '切换线路',
                subtitle: '手动锁定一条线路，或让 Echo 根据可用性和延迟自动选择。',
                constrainToAvailableHeight: true,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    EchoButton.ghost(
                      label: '重新检测延迟',
                      leadingIcon: AppIcons.refresh,
                      expand: true,
                      onPressed: () {
                        addressPool.probeAll();
                      },
                    ),
                    SizedBox(height: context.echoSpacing.sm),
                    Flexible(
                      child: libraries.when(
                        data: (items) {
                          final fallbackLibrary =
                              items
                                  .where(
                                    (library) => library.id == activeLibraryId,
                                  )
                                  .firstOrNull ??
                              items.firstOrNull;
                          final poolAddresses = addressPool.addresses;
                          final addresses =
                              List<ServerAddress>.from(
                                poolAddresses.isNotEmpty
                                    ? poolAddresses
                                    : fallbackLibrary?.addresses ??
                                          const <ServerAddress>[],
                              )..sort(
                                (first, second) =>
                                    first.priority.compareTo(second.priority),
                              );

                          if (addresses.isEmpty) {
                            return const SingleChildScrollView(
                              child: EchoEmptyState(
                                title: '没有可用线路',
                                description: '请先在音乐库设置中添加至少一个服务器地址。',
                                icon: AppIcons.route,
                                padding: EdgeInsets.all(24),
                              ),
                            );
                          }

                          final isAuto = !addresses.any(
                            (address) =>
                                address.isLocked &&
                                address.id == activeAddress?.id,
                          );

                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: addresses.length + 2,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return EchoActionRow(
                                  icon: AppIcons.route,
                                  title: '自动选择',
                                  subtitle: isAuto
                                      ? '当前已开启${activeAddress == null ? '' : ' · ${activeAddress.label}'}'
                                      : '根据可用性和延迟选择线路',
                                  selected: isAuto,
                                  trailing: isAuto
                                      ? Icon(
                                          AppIcons.check,
                                          color: context.echoColors.accent,
                                        )
                                      : null,
                                  onPressed: () {
                                    addressPool.setAutoMode();
                                    Navigator.of(sheetContext).pop();
                                  },
                                );
                              }

                              if (index == 1) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: context.echoSpacing.xs,
                                  ),
                                  child: const EchoDivider(),
                                );
                              }

                              final address = addresses[index - 2];
                              final isSelected =
                                  activeAddress?.id == address.id &&
                                  address.isLocked;
                              final status = _addressStatusPresentation(
                                address,
                              );
                              return Padding(
                                padding: EdgeInsets.only(
                                  bottom: context.echoSpacing.xs,
                                ),
                                child: EchoActionRow(
                                  icon: AppIcons.signalTower,
                                  title: address.label,
                                  subtitle:
                                      '${address.url}\n${status.label} · '
                                      '延迟 ${address.lastLatencyMs == null ? '未知' : '${address.lastLatencyMs}ms'}',
                                  selected: isSelected,
                                  trailing: Semantics(
                                    label: status.label,
                                    child: Icon(
                                      isSelected ? AppIcons.check : status.icon,
                                      size: 20,
                                      color: isSelected
                                          ? context.echoColors.accent
                                          : status.color(context),
                                    ),
                                  ),
                                  onPressed: () {
                                    addressPool.setManualMode(address);
                                    Navigator.of(sheetContext).pop();
                                  },
                                ),
                              );
                            },
                          );
                        },
                        loading: () => const _DrawerSkeletonList(itemCount: 3),
                        error: (error, stackTrace) => SingleChildScrollView(
                          child: EchoErrorState(
                            title: '无法读取线路',
                            description: '线路信息暂时不可用。请重试，或稍后打开音乐库设置检查地址。',
                            actionLabel: '重试',
                            onAction: () => ref.invalidate(librariesProvider),
                            padding: const EdgeInsets.all(24),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    } finally {
      onClosed?.call();
    }
  }
}

@visibleForTesting
String? resolveEchoDrawerAvatarUrl(MusicLibrary? library) {
  if (library == null) return null;
  final raw = library.extensions['avatarUrl'];
  if (raw is! String || raw.trim().isEmpty) return null;
  final uri = Uri.tryParse(raw.trim());
  if (uri == null || (!uri.hasScheme && !uri.hasAbsolutePath)) return null;
  return raw.trim();
}

EchoDrawerConnectionState _connectionState(ServerAddress? address) {
  if (address == null) return EchoDrawerConnectionState.disconnected;
  return switch (address.status) {
    ServerAddressStatus.ok => EchoDrawerConnectionState.connected,
    ServerAddressStatus.failed => EchoDrawerConnectionState.failed,
    ServerAddressStatus.unknown => EchoDrawerConnectionState.unknown,
  };
}

_AddressStatusPresentation _addressStatusPresentation(ServerAddress address) {
  return switch (address.status) {
    ServerAddressStatus.ok => const _AddressStatusPresentation(
      label: '连接正常',
      icon: AppIcons.checkCircle,
      kind: _AddressStatusKind.connected,
    ),
    ServerAddressStatus.failed => const _AddressStatusPresentation(
      label: '连接失败',
      icon: AppIcons.error,
      kind: _AddressStatusKind.failed,
    ),
    ServerAddressStatus.unknown => const _AddressStatusPresentation(
      label: '等待检测',
      icon: AppIcons.help,
      kind: _AddressStatusKind.unknown,
    ),
  };
}

class _DrawerNavigationEntry {
  const _DrawerNavigationEntry({
    required this.icon,
    required this.title,
    required this.onPressed,
    this.subtitle,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onPressed;
}

enum _AddressStatusKind { connected, failed, unknown }

class _AddressStatusPresentation {
  const _AddressStatusPresentation({
    required this.label,
    required this.icon,
    required this.kind,
  });

  final String label;
  final IconData icon;
  final _AddressStatusKind kind;

  Color color(BuildContext context) {
    return switch (kind) {
      _AddressStatusKind.connected => context.echoColors.accent,
      _AddressStatusKind.failed => context.echoColors.error,
      _AddressStatusKind.unknown => context.echoColors.muted,
    };
  }
}

class _DrawerSkeletonList extends StatelessWidget {
  const _DrawerSkeletonList({this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: context.echoSpacing.md,
        vertical: context.echoSpacing.sm,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: context.echoSpacing.md),
          child: Row(
            children: <Widget>[
              const EchoSkeleton.circle(),
              SizedBox(width: context.echoSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    EchoSkeleton.line(
                      width: index.isEven ? 140 : 112,
                      height: 16,
                    ),
                    SizedBox(height: context.echoSpacing.xs),
                    const EchoSkeleton.line(width: 196),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:echo/data/models/music_library.dart';
import 'package:echo/data/models/server_address.dart';
import 'package:echo/features/library/widgets/address_dialog.dart';
import 'package:echo/providers/library_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:echo/providers/api_provider.dart';
import 'package:echo/providers/auth_provider.dart';
import 'package:echo/providers/player_provider.dart';
import 'package:go_router/go_router.dart';

class EditLibraryPage extends ConsumerStatefulWidget {
  final String libraryId;

  const EditLibraryPage({super.key, required this.libraryId});

  @override
  ConsumerState<EditLibraryPage> createState() => _EditLibraryPageState();
}

class _EditLibraryPageState extends ConsumerState<EditLibraryPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late TextEditingController _apiKeyController; // Assuming API key support

  @override
  void initState() {
    super.initState();
    // Initialize with empty, will populate in build or use a separate provider for form state
    // But since we need to edit, we should load initial data.
    // Using simple approach: read initial data in build if not set, or use a "loaded" flag.
    // Better: use a provider that fetches the specific library.
    _nameController = TextEditingController();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _apiKeyController = TextEditingController();
  }

  bool _initialized = false;

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _apiKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final librariesAsync = ref.watch(librariesProvider);

    return librariesAsync.when(
      data: (libraries) {
        final library = libraries.cast<MusicLibrary?>().firstWhere(
          (l) => l!.id == widget.libraryId,
          orElse: () => null,
        );

        // 库已被删除，等待导航跳转
        if (library == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!_initialized) {
          _nameController.text = library.name;
          _usernameController.text = library.username ?? '';
          _passwordController.text =
              library.password ?? ''; // Be careful showing password
          _apiKeyController.text = library.apiKey ?? '';
          _initialized = true;
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('编辑音乐库'),
            actions: [
              IconButton(
                icon: const Icon(Icons.check),
                onPressed: () => _saveLibrary(library),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBasicInfoSection(context),
                  const SizedBox(height: 24),
                  _buildAddressesSection(context, library),
                  const SizedBox(height: 24),
                  _buildDeleteSection(context, library),
                ],
              ),
            ),
          ),
        );
      },
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (err, stack) => Scaffold(body: Center(child: Text('Error: $err'))),
    );
  }

  Widget _buildBasicInfoSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '基本信息',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(
            labelText: '库名称',
            border: OutlineInputBorder(),
          ),
          validator: (value) => value?.isEmpty ?? true ? '请输入名称' : null,
        ),
        // Auth fields (Generic for now, ideally depends on AuthType)
        /* 
        const SizedBox(height: 16),
        TextFormField(
           controller: _usernameController,
           decoration: const InputDecoration(labelText: '用户名'),
        ),
        */
        // Hide sensitive info for now or allow changing password only
      ],
    );
  }

  Widget _buildAddressesSection(BuildContext context, MusicLibrary library) {
    // Sort addresses by priority
    final sortedAddresses = List<ServerAddress>.from(library.addresses)
      ..sort((a, b) => a.priority.compareTo(b.priority));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  '服务器地址',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                if (library.isActive)
                  IconButton(
                    icon: const Icon(Icons.refresh, size: 20),
                    tooltip: '检测延迟',
                    onPressed: () async {
                      await ref.read(addressPoolProvider).probeAll();
                      ref.invalidate(librariesProvider);
                    },
                  ),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: () => _showAddressDialog(context),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (sortedAddresses.isEmpty)
          const Text('暂无地址，请添加服务器地址。')
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: sortedAddresses.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final address = sortedAddresses[index];
              return ListTile(
                title: Text(address.label),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(address.url),
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _getStatusColor(address.status),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${address.status.name} ${address.lastLatencyMs != null ? '(${address.lastLatencyMs}ms)' : ''}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '优先级: ${address.priority}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, size: 20),
                      onPressed: () =>
                          _showAddressDialog(context, address: address),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete,
                        size: 20,
                        color: Colors.red,
                      ),
                      onPressed: () => _deleteAddress(address),
                    ),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }

  Color _getStatusColor(ServerAddressStatus status) {
    switch (status) {
      case ServerAddressStatus.ok:
        return Colors.green;
      case ServerAddressStatus.failed:
        return Colors.red;
      case ServerAddressStatus.unknown:
        return Colors.grey;
    }
  }

  Widget _buildDeleteSection(BuildContext context, MusicLibrary library) {
    return Center(
      child: TextButton.icon(
        onPressed: () => _confirmDelete(library),
        icon: const Icon(Icons.delete, color: Colors.red),
        label: const Text('删除此音乐库', style: TextStyle(color: Colors.red)),
      ),
    );
  }

  Future<void> _showAddressDialog(
    BuildContext context, {
    ServerAddress? address,
  }) async {
    final result = await showDialog<ServerAddress>(
      context: context,
      builder: (context) =>
          AddressDialog(libraryId: widget.libraryId, initialAddress: address),
    );

    if (result != null) {
      final libraries = await ref.read(librariesProvider.future);
      if (!mounted) return;
      final library = libraries.firstWhere((l) => l.id == widget.libraryId);

      // Verify server identity if it's a new address or URL changed
      if (address == null || address.url != result.url) {
        // Show loading indicator?
        if (mounted) {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('正在验证服务器一致性...'),
              duration: Duration(seconds: 1),
            ),
          );
        }

        final isValid = await ref
            .read(authRepositoryProvider)
            .verifyServerIdentity(result, library);

        if (!mounted) return;

        if (!isValid) {
          if (mounted) {
            await showDialog(
              // ignore: use_build_context_synchronously
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('验证失败'),
                content: const Text(
                  '新地址似乎指向了不同的服务器或验证失败。\n即添加的线路必须属于同一个服务器（相同的音乐库内容）。',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('确定'),
                  ),
                ],
              ),
            );
          }
          return;
        }
      }

      final repo = ref.read(libraryRepositoryProvider);
      if (address != null) {
        await repo.updateAddress(result);
      } else {
        await repo.addAddress(result);
      }

      // Force refresh of library data
      ref.invalidate(librariesProvider);
      // Wait for libraries to update
      await Future.delayed(const Duration(milliseconds: 100));
      // Invalidate active library logic to pick up new addresses if needed
      ref.invalidate(activeLibraryProvider);
      // Trigger probe immediately by invalidating address pool or synchronizer?
      // Actually activeLibrarySynchronizerProvider watches activeLibraryProvider and calls setAddresses.
      // So once activeLibraryProvider updates, addressPool should update.
      // But we might want to manually trigger a probe on the pool.
      final pool = ref.read(addressPoolProvider);
      // pool.probeAll(); // The synchronizer does this if active address is null.
      // If we just added an address, we might want to probe it.
      // Let's force a probe.
      pool.probeAll();
    }
  }

  Future<void> _deleteAddress(ServerAddress address) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除地址'),
        content: Text('确定要删除地址 "${address.label}" 吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('删除'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      // 如果删除的是当前使用的线路，停止音乐
      final activeAddress = ref.read(activeAddressProvider);
      if (activeAddress?.id == address.id) {
        ref.invalidate(playerProvider);
      }

      final repo = ref.read(libraryRepositoryProvider);
      await repo.deleteAddress(address.id);
      ref.invalidate(librariesProvider); // 刷新 UI
    }
  }

  Future<void> _saveLibrary(MusicLibrary original) async {
    if (_formKey.currentState!.validate()) {
      final repo = ref.read(libraryRepositoryProvider);
      final updated = original.copyWith(
        name: _nameController.text,
        // Update other fields as needed
        updatedAt: DateTime.now(),
      );
      await repo.updateLibrary(updated);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('保存成功')));
        context.pop();
      }
    }
  }

  Future<void> _confirmDelete(MusicLibrary library) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除音乐库'),
        content: Text('确定要删除音乐库 "${library.name}" 吗？此操作不可恢复。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('删除'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      final repo = ref.read(libraryRepositoryProvider);

      // 删除当前库时停止音乐
      if (library.isActive) {
        ref.invalidate(playerProvider);
      }

      // 先查剩余库，再删除，避免删除后 stream 更新导致 build 异常
      final allLibraries = await ref.read(librariesProvider.future);
      final remaining = allLibraries.where((l) => l.id != library.id).toList();

      await repo.deleteLibrary(library.id);
      if (!mounted) return;

      if (remaining.isEmpty) {
        // 最后一个库被删除，清除认证状态后跳转到初始化页面
        await ref.read(authStateProvider.notifier).logout();
        if (!mounted) return;
        context.go('/login');
      } else {
        // 还有其他库，切换到第一个
        final next = remaining.first;
        await repo.setActiveLibrary(next.id);
        ref.read(authStateProvider.notifier).switchLibrary(next);
        if (!mounted) return;
        context.go('/home');
      }
    }
  }
}

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'package:echoes/core/utils/server_url_security.dart';
import 'package:echoes/data/models/server_address.dart';

class AddressDialog extends StatefulWidget {
  final String libraryId;
  final ServerAddress? initialAddress;

  const AddressDialog({
    super.key,
    required this.libraryId,
    this.initialAddress,
  });

  @override
  State<AddressDialog> createState() => _AddressDialogState();
}

class _AddressDialogState extends State<AddressDialog> {
  static const _httpHintMessage = '优先使用 HTTPS。只有在可信局域网中才建议使用 HTTP。';

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _labelController;
  late final TextEditingController _urlController;

  bool get _showsHttpWarning => isInsecureHttpUrl(_urlController.text);

  @override
  void initState() {
    super.initState();
    _labelController = TextEditingController(
      text: widget.initialAddress?.label,
    );
    _urlController = TextEditingController(text: widget.initialAddress?.url);
    _urlController.addListener(_handleUrlChanged);
  }

  @override
  void dispose() {
    _urlController.removeListener(_handleUrlChanged);
    _labelController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  void _handleUrlChanged() {
    if (!mounted) return;
    setState(() {});
  }

  Future<void> _showHttpHint() async {
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('HTTP 使用提示'),
        content: const Text(_httpHintMessage),
        actions: [
          FilledButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('知道了'),
          ),
        ],
      ),
    );
  }

  Future<bool> _confirmHttpSave(String normalizedUrl) async {
    final confirmed =
        await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('保存不安全的 HTTP 地址'),
            content: Text(
              '当前地址使用的是 HTTP：\n$normalizedUrl\n\n'
              'HTTP 不会加密传输。凭据、令牌以及媒体请求都可能暴露给同一网络中的其他人。'
              '仅当该服务器位于可信网络中时才保存。',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('取消'),
              ),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('保存'),
              ),
            ],
          ),
        ) ??
        false;

    return confirmed;
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.initialAddress != null;

    return AlertDialog(
      title: Text(isEditing ? '编辑地址' : '添加地址'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _labelController,
                decoration: const InputDecoration(
                  labelText: '标签',
                  hintText: '例如：OpenSubsonic',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '请输入标签';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _urlController,
                decoration: InputDecoration(
                  labelText: '服务器地址',
                  hintText: '例如：http://192.168.1.5:4533',
                  suffixIcon: _showsHttpWarning
                      ? IconButton(
                          tooltip: 'HTTP 使用提示',
                          icon: const Icon(
                            Icons.warning_amber_rounded,
                            color: Colors.orange,
                          ),
                          onPressed: _showHttpHint,
                        )
                      : null,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '请输入服务器地址';
                  }
                  if (!isSupportedServerUrl(value)) {
                    return '请输入有效的 URL（包含 http/https）';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('取消'),
        ),
        FilledButton(
          onPressed: () async {
            if (!_formKey.currentState!.validate()) return;

            final normalizedUrl = _urlController.text.trim();
            final requiresConfirmation =
                isInsecureHttpUrl(normalizedUrl) &&
                (!isEditing ||
                    widget.initialAddress!.url.trim() != normalizedUrl);
            if (requiresConfirmation) {
              final confirmed = await _confirmHttpSave(normalizedUrl);
              if (!confirmed || !context.mounted) {
                return;
              }
            }

            final newAddress = ServerAddress(
              id: widget.initialAddress?.id ?? const Uuid().v4(),
              libraryId: widget.libraryId,
              label: _labelController.text.trim(),
              url: normalizedUrl,
              priority: widget.initialAddress?.priority ?? 10,
              isLocked: widget.initialAddress?.isLocked ?? false,
            );
            Navigator.of(context).pop(newAddress);
          },
          child: const Text('保存'),
        ),
      ],
    );
  }
}

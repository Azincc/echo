import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../core/design/echo_design.dart';
import '../../../core/utils/server_url_security.dart';
import '../../../data/models/server_address.dart';

class AddressDialog extends StatefulWidget {
  const AddressDialog({
    super.key,
    required this.libraryId,
    this.initialAddress,
  });

  final String libraryId;
  final ServerAddress? initialAddress;

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
    if (mounted) setState(() {});
  }

  Future<void> _showHttpHint() async {
    await showEchoBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      builder: (sheetContext) => EchoBottomSheet(
        title: 'HTTP 使用提示',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              _httpHintMessage,
              style: context.echoTypography.body.copyWith(
                color: context.echoColors.muted,
              ),
            ),
            SizedBox(height: context.echoSpacing.lg),
            EchoButton.primary(
              label: '知道了',
              expand: true,
              onPressed: () => Navigator.of(sheetContext).pop(),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _confirmHttpSave(String normalizedUrl) async {
    final confirmed = await showEchoBottomSheet<bool>(
      context: context,
      useRootNavigator: true,
      builder: (sheetContext) => EchoBottomSheet(
        title: '保存不安全的 HTTP 地址',
        subtitle: normalizedUrl,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'HTTP 不会加密传输。凭据、令牌以及媒体请求都可能暴露给同一网络中的其他人。'
              '仅当该服务器位于可信网络中时才保存。',
              style: context.echoTypography.body.copyWith(
                color: context.echoColors.muted,
              ),
            ),
            SizedBox(height: context.echoSpacing.lg),
            EchoButton.destructive(
              label: '仍然保存',
              expand: true,
              onPressed: () => Navigator.of(sheetContext).pop(true),
            ),
            SizedBox(height: context.echoSpacing.xs),
            EchoButton.ghost(
              label: '取消',
              expand: true,
              onPressed: () => Navigator.of(sheetContext).pop(false),
            ),
          ],
        ),
      ),
    );
    return confirmed == true;
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final isEditing = widget.initialAddress != null;
    final normalizedUrl = _urlController.text.trim();
    final requiresConfirmation =
        isInsecureHttpUrl(normalizedUrl) &&
        (!isEditing || widget.initialAddress!.url.trim() != normalizedUrl);
    if (requiresConfirmation) {
      final confirmed = await _confirmHttpSave(normalizedUrl);
      if (!confirmed || !mounted) return;
    }

    final address = ServerAddress(
      id: widget.initialAddress?.id ?? const Uuid().v4(),
      libraryId: widget.libraryId,
      label: _labelController.text.trim(),
      url: normalizedUrl,
      priority: widget.initialAddress?.priority ?? 10,
      isLocked: widget.initialAddress?.isLocked ?? false,
    );
    if (mounted) Navigator.of(context).pop(address);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.initialAddress != null;
    final keyboardInset = MediaQuery.viewInsetsOf(context).bottom;

    return EchoBottomSheet(
      title: isEditing ? '编辑地址' : '添加地址',
      subtitle: '同一音乐库可以配置多条线路，并按优先级自动选择。',
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.74,
        ),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.only(bottom: keyboardInset),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                EchoTextField(
                  controller: _labelController,
                  label: '标签',
                  hintText: '例如：OpenSubsonic',
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return '请输入标签';
                    }
                    return null;
                  },
                ),
                SizedBox(height: context.echoSpacing.md),
                EchoTextField(
                  controller: _urlController,
                  label: '服务器地址',
                  hintText: '例如：https://music.example.com',
                  helperText: _httpHintMessage,
                  leadingIcon: AppIcons.router,
                  trailing: _showsHttpWarning
                      ? EchoIconButton(
                          icon: AppIcons.warning,
                          label: 'HTTP 使用提示',
                          foregroundColor: context.echoColors.warning,
                          onPressed: _showHttpHint,
                        )
                      : null,
                  keyboardType: TextInputType.url,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _save(),
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
                SizedBox(height: context.echoSpacing.lg),
                EchoButton.primary(
                  label: '保存地址',
                  leadingIcon: AppIcons.save,
                  expand: true,
                  onPressed: _save,
                ),
                SizedBox(height: context.echoSpacing.xs),
                EchoButton.ghost(
                  label: '取消',
                  expand: true,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

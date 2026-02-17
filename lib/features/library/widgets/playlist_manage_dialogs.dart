import 'package:flutter/material.dart';

class PlaylistFormResult {
  final String name;
  final String comment;
  final bool isPublic;

  const PlaylistFormResult({
    required this.name,
    required this.comment,
    required this.isPublic,
  });
}

Future<PlaylistFormResult?> showPlaylistFormDialog({
  required BuildContext context,
  required String title,
  required String confirmText,
  String initialName = '',
  String initialComment = '',
  bool initialPublic = false,
}) async {
  return showDialog<PlaylistFormResult>(
    context: context,
    builder: (dialogContext) => _PlaylistFormDialog(
      title: title,
      confirmText: confirmText,
      initialName: initialName,
      initialComment: initialComment,
      initialPublic: initialPublic,
    ),
  );
}

Future<bool> showDeletePlaylistConfirmDialog({
  required BuildContext context,
  required String playlistName,
}) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('删除歌单'),
      content: Text('确定要删除歌单「$playlistName」吗？此操作不可恢复。'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('取消'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('删除'),
        ),
      ],
    ),
  );

  return confirmed ?? false;
}

class _PlaylistFormDialog extends StatefulWidget {
  final String title;
  final String confirmText;
  final String initialName;
  final String initialComment;
  final bool initialPublic;

  const _PlaylistFormDialog({
    required this.title,
    required this.confirmText,
    required this.initialName,
    required this.initialComment,
    required this.initialPublic,
  });

  @override
  State<_PlaylistFormDialog> createState() => _PlaylistFormDialogState();
}

class _PlaylistFormDialogState extends State<_PlaylistFormDialog> {
  late final TextEditingController _nameController;
  late final TextEditingController _commentController;
  late bool _isPublic;
  String? _nameError;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _commentController = TextEditingController(text: widget.initialComment);
    _isPublic = widget.initialPublic;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  void _submit() {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      setState(() {
        _nameError = '歌单名称不能为空';
      });
      return;
    }

    Navigator.of(context).pop(
      PlaylistFormResult(
        name: name,
        comment: _commentController.text.trim(),
        isPublic: _isPublic,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              autofocus: true,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: '歌单名称',
                hintText: '请输入歌单名称',
                errorText: _nameError,
              ),
              onChanged: (_) {
                if (_nameError == null) return;
                setState(() {
                  _nameError = null;
                });
              },
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _commentController,
              textInputAction: TextInputAction.done,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: '简介（可选）',
                hintText: '例如：通勤歌单',
              ),
            ),
            const SizedBox(height: 12),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('公开歌单'),
              value: _isPublic,
              onChanged: (value) {
                setState(() {
                  _isPublic = value;
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('取消'),
        ),
        FilledButton(onPressed: _submit, child: Text(widget.confirmText)),
      ],
    );
  }
}

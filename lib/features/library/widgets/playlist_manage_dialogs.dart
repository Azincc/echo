import 'package:flutter/material.dart';

import '../../../core/design/echo_design.dart';

class PlaylistFormResult {
  const PlaylistFormResult({
    required this.name,
    required this.comment,
    required this.isPublic,
  });

  final String name;
  final String comment;
  final bool isPublic;
}

Future<PlaylistFormResult?> showPlaylistFormDialog({
  required BuildContext context,
  required String title,
  required String confirmText,
  String initialName = '',
  String initialComment = '',
  bool initialPublic = false,
}) async {
  return showEchoBottomSheet<PlaylistFormResult>(
    context: context,
    useRootNavigator: true,
    isScrollControlled: true,
    builder: (sheetContext) => _PlaylistFormSheet(
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
  final confirmed = await showEchoBottomSheet<bool>(
    context: context,
    useRootNavigator: true,
    isScrollControlled: true,
    builder: (sheetContext) => EchoBottomSheet(
      title: '删除歌单',
      subtitle: '此操作不可恢复。',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            '确定要删除歌单「$playlistName」吗？',
            style: sheetContext.echoTypography.body.copyWith(
              color: sheetContext.echoColors.muted,
            ),
          ),
          SizedBox(height: sheetContext.echoSpacing.lg),
          Row(
            children: <Widget>[
              Expanded(
                child: EchoButton.secondary(
                  label: '取消',
                  onPressed: () => Navigator.of(sheetContext).pop(false),
                ),
              ),
              SizedBox(width: sheetContext.echoSpacing.sm),
              Expanded(
                child: EchoButton.destructive(
                  label: '删除',
                  onPressed: () => Navigator.of(sheetContext).pop(true),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );

  return confirmed ?? false;
}

class _PlaylistFormSheet extends StatefulWidget {
  const _PlaylistFormSheet({
    required this.title,
    required this.confirmText,
    required this.initialName,
    required this.initialComment,
    required this.initialPublic,
  });

  final String title;
  final String confirmText;
  final String initialName;
  final String initialComment;
  final bool initialPublic;

  @override
  State<_PlaylistFormSheet> createState() => _PlaylistFormSheetState();
}

class _PlaylistFormSheetState extends State<_PlaylistFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _commentController;
  late bool _isPublic;

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
    if (!(_formKey.currentState?.validate() ?? false)) return;
    Navigator.of(context).pop(
      PlaylistFormResult(
        name: _nameController.text.trim(),
        comment: _commentController.text.trim(),
        isPublic: _isPublic,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final keyboardInset = MediaQuery.viewInsetsOf(context).bottom;
    final motion = context.echoMotion;

    return AnimatedPadding(
      duration: motion.resolve(context, motion.state),
      curve: motion.easeOut,
      padding: EdgeInsets.only(bottom: keyboardInset),
      child: EchoBottomSheet(
        title: widget.title,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).height * 0.72,
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  EchoTextField(
                    controller: _nameController,
                    label: '歌单名称',
                    hintText: '请输入歌单名称',
                    leadingIcon: AppIcons.playlist,
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    validator: (value) => value == null || value.trim().isEmpty
                        ? '歌单名称不能为空'
                        : null,
                    onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                  ),
                  SizedBox(height: context.echoSpacing.md),
                  EchoTextField(
                    controller: _commentController,
                    label: '简介（可选）',
                    hintText: '例如：通勤歌单',
                    leadingIcon: AppIcons.fileText,
                    minLines: 2,
                    maxLines: 4,
                    textInputAction: TextInputAction.newline,
                  ),
                  SizedBox(height: context.echoSpacing.md),
                  _EchoToggleRow(
                    title: '公开歌单',
                    description: _isPublic
                        ? '服务器上的其他用户可以看到这个歌单。'
                        : '只有当前账户可以看到这个歌单。',
                    value: _isPublic,
                    onChanged: (value) => setState(() => _isPublic = value),
                  ),
                  SizedBox(height: context.echoSpacing.lg),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: EchoButton.secondary(
                          label: '取消',
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                      SizedBox(width: context.echoSpacing.sm),
                      Expanded(
                        child: EchoButton.primary(
                          label: widget.confirmText,
                          onPressed: _submit,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _EchoToggleRow extends StatelessWidget {
  const _EchoToggleRow({
    required this.title,
    required this.description,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String description;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.echoColors;
    final motion = context.echoMotion;

    return EchoPressable(
      semanticLabel: '$title，${value ? '已开启' : '已关闭'}，$description',
      selected: value,
      onPressed: () => onChanged(!value),
      minimumSize: const Size(double.infinity, 72),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.echoSpacing.sm,
          vertical: context.echoSpacing.xs,
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title, style: context.echoTypography.title),
                  SizedBox(height: context.echoSpacing.xxs),
                  Text(
                    description,
                    style: context.echoTypography.body.copyWith(
                      color: colors.muted,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: context.echoSpacing.sm),
            AnimatedContainer(
              duration: motion.resolve(context, motion.state),
              curve: motion.easeOut,
              width: 52,
              height: 30,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: value ? colors.accent : colors.raised,
                borderRadius: context.echoRadii.pill,
                border: Border.all(
                  color: value ? colors.accent : colors.controlBoundary,
                ),
              ),
              child: AnimatedAlign(
                duration: motion.resolve(context, motion.state),
                curve: motion.easeOut,
                alignment: value
                    ? AlignmentDirectional.centerEnd
                    : AlignmentDirectional.centerStart,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: value ? colors.onAccent : colors.muted,
                    shape: BoxShape.circle,
                  ),
                  child: const SizedBox.square(dimension: 22),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

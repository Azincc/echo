import 'package:echo/data/models/server_address.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

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
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _labelController;
  late TextEditingController _urlController;
  late TextEditingController _priorityController;

  @override
  void initState() {
    super.initState();
    _labelController = TextEditingController(
      text: widget.initialAddress?.label,
    );
    _urlController = TextEditingController(text: widget.initialAddress?.url);
    _priorityController = TextEditingController(
      text: widget.initialAddress?.priority.toString() ?? '10',
    );
  }

  @override
  void dispose() {
    _labelController.dispose();
    _urlController.dispose();
    _priorityController.dispose();
    super.dispose();
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
                  if (value == null || value.isEmpty) {
                    return '请输入标签';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _urlController,
                decoration: const InputDecoration(
                  labelText: '服务器地址',
                  hintText: '例如：http://192.168.1.5:4533',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入服务器地址';
                  }
                  final uri = Uri.tryParse(value);
                  if (uri == null || !uri.hasScheme || !uri.hasAuthority) {
                    return '请输入有效的 URL (包含 http/https)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _priorityController,
                decoration: const InputDecoration(
                  labelText: '优先级',
                  hintText: '数字越小优先级越高',
                  helperText: '0 最高，默认 10',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入优先级';
                  }
                  if (int.tryParse(value) == null) {
                    return '请输入有效的数字';
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
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final newAddress = ServerAddress(
                id: widget.initialAddress?.id ?? const Uuid().v4(),
                libraryId: widget.libraryId,
                label: _labelController.text,
                url: _urlController.text,
                priority: int.parse(_priorityController.text),
                isLocked: widget.initialAddress?.isLocked ?? false,
              );
              Navigator.of(context).pop(newAddress);
            }
          },
          child: const Text('保存'),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/color_scheme.dart';
import '../../../providers/theme_provider.dart';

class ThemeSettingsPage extends ConsumerWidget {
  const ThemeSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(themeSettingsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('主题设置')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            '外观模式',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          RadioGroup<ThemeMode>(
            groupValue: settings.mode,
            onChanged: (value) {
              if (value == null) return;
              ref.read(themeSettingsProvider.notifier).setThemeMode(value);
            },
            child: Column(
              children: const [
                RadioListTile<ThemeMode>(
                  contentPadding: EdgeInsets.zero,
                  title: Text('跟随系统'),
                  value: ThemeMode.system,
                ),
                RadioListTile<ThemeMode>(
                  contentPadding: EdgeInsets.zero,
                  title: Text('白色'),
                  value: ThemeMode.light,
                ),
                RadioListTile<ThemeMode>(
                  contentPadding: EdgeInsets.zero,
                  title: Text('黑色'),
                  value: ThemeMode.dark,
                ),
              ],
            ),
          ),
          const Divider(height: 24),
          Text(
            '主色调',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: settings.seedColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  '当前颜色 ${_toHex(settings.seedColor)}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              FilledButton.icon(
                onPressed: () =>
                    _openColorPicker(context, ref, settings.seedColor),
                icon: const Icon(Icons.palette_outlined),
                label: const Text('自由选择'),
              ),
              OutlinedButton(
                onPressed: () {
                  ref.read(themeSettingsProvider.notifier).resetSeedColor();
                },
                child: const Text('恢复默认紫色'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text('预设色', style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 8),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _presetColors.map((color) {
              final selected =
                  settings.seedColor.toARGB32() == color.toARGB32();
              return InkWell(
                onTap: () {
                  ref.read(themeSettingsProvider.notifier).setSeedColor(color);
                },
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: selected
                          ? Theme.of(context).colorScheme.onSurface
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Future<void> _openColorPicker(
    BuildContext context,
    WidgetRef ref,
    Color initialColor,
  ) async {
    final selected = await showDialog<Color>(
      context: context,
      builder: (context) => _ColorPickerDialog(initialColor: initialColor),
    );
    if (selected != null) {
      ref.read(themeSettingsProvider.notifier).setSeedColor(selected);
    }
  }
}

const List<Color> _presetColors = [
  AppColorScheme.defaultSeedColor,
  Color(0xFF0EA5E9),
  Color(0xFF22C55E),
  Color(0xFFF59E0B),
  Color(0xFFEF4444),
  Color(0xFFEC4899),
  Color(0xFF14B8A6),
  Color(0xFF6B7280),
];

class _ColorPickerDialog extends StatefulWidget {
  final Color initialColor;

  const _ColorPickerDialog({required this.initialColor});

  @override
  State<_ColorPickerDialog> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<_ColorPickerDialog> {
  late HSVColor _hsv;

  @override
  void initState() {
    super.initState();
    _hsv = HSVColor.fromColor(widget.initialColor);
  }

  @override
  Widget build(BuildContext context) {
    final color = _hsv.toColor();

    return AlertDialog(
      title: const Text('选择主色调'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text('HEX: ${_toHex(color)}'),
            const SizedBox(height: 12),
            _SliderLine(
              label: '色相',
              value: _hsv.hue,
              min: 0,
              max: 360,
              onChanged: (v) => setState(() => _hsv = _hsv.withHue(v)),
            ),
            _SliderLine(
              label: '饱和度',
              value: _hsv.saturation,
              min: 0,
              max: 1,
              onChanged: (v) => setState(() => _hsv = _hsv.withSaturation(v)),
            ),
            _SliderLine(
              label: '明度',
              value: _hsv.value,
              min: 0,
              max: 1,
              onChanged: (v) => setState(() => _hsv = _hsv.withValue(v)),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('取消'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, color),
          child: const Text('应用'),
        ),
      ],
    );
  }
}

class _SliderLine extends StatelessWidget {
  final String label;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  const _SliderLine({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Slider(
          value: value.clamp(min, max),
          min: min,
          max: max,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

String _toHex(Color color) {
  final value = color
      .toARGB32()
      .toRadixString(16)
      .padLeft(8, '0')
      .toUpperCase();
  return '#${value.substring(2)}';
}

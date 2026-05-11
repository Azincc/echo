import 'package:flutter/material.dart';
import 'package:echoes/core/theme/app_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/color_scheme.dart';
import '../../../providers/theme_provider.dart';
import '../../../widgets/music_chrome.dart';

class ThemeSettingsPage extends ConsumerWidget {
  const ThemeSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(themeSettingsProvider);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: MusicChrome.maxContentWidth,
            ),
            child: ListView(
              padding: EdgeInsets.fromLTRB(
                20,
                0,
                20,
                24 + MediaQuery.of(context).padding.bottom,
              ),
              children: [
                MusicPageHeader(
                  padding: const EdgeInsets.fromLTRB(0, 14, 0, 16),
                  title: '主题设置',
                  subtitle: '调整外观模式与全局强调色',
                  leading: MusicIconButton(
                    icon: AppIcons.arrow_back_ios_new,
                    tooltip: '返回',
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                _section(
                  context,
                  title: '外观模式',
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      children: [
                        MusicRadioTile<ThemeMode>(
                          value: ThemeMode.system,
                          groupValue: settings.mode,
                          icon: AppIcons.hdr_auto,
                          title: '跟随系统',
                          subtitle: '自动匹配系统浅色或深色模式',
                          onChanged: (value) {
                            ref
                                .read(themeSettingsProvider.notifier)
                                .setThemeMode(value);
                          },
                        ),
                        MusicRadioTile<ThemeMode>(
                          value: ThemeMode.light,
                          groupValue: settings.mode,
                          icon: AppIcons.cloud_outlined,
                          title: '白色',
                          subtitle: '明亮背景，更适合白天浏览',
                          onChanged: (value) {
                            ref
                                .read(themeSettingsProvider.notifier)
                                .setThemeMode(value);
                          },
                        ),
                        MusicRadioTile<ThemeMode>(
                          value: ThemeMode.dark,
                          groupValue: settings.mode,
                          icon: AppIcons.music_note_outlined,
                          title: '黑色',
                          subtitle: '沉浸式深色界面，更接近音乐应用',
                          onChanged: (value) {
                            ref
                                .read(themeSettingsProvider.notifier)
                                .setThemeMode(value);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                _section(
                  context,
                  title: '主色调',
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: settings.seedColor,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: settings.seedColor.withValues(
                                      alpha: 0.28,
                                    ),
                                    blurRadius: 18,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                                border: Border.all(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.outlineVariant,
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '当前颜色',
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(fontWeight: FontWeight.w800),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    _toHex(settings.seedColor),
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSurfaceVariant,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            FilledButton.icon(
                              onPressed: () => _openColorPicker(
                                context,
                                ref,
                                settings.seedColor,
                              ),
                              icon: const Icon(AppIcons.palette_outlined),
                              label: const Text('自由选择'),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                ref
                                    .read(themeSettingsProvider.notifier)
                                    .resetSeedColor();
                              },
                              child: const Text('恢复默认红色'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        Text(
                          '预设色',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: _presetColors.map((color) {
                            final selected =
                                settings.seedColor.toARGB32() ==
                                color.toARGB32();
                            return _ColorSwatchButton(
                              color: color,
                              selected: selected,
                              onTap: () {
                                ref
                                    .read(themeSettingsProvider.notifier)
                                    .setSeedColor(color);
                              },
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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

Widget _section(
  BuildContext context, {
  required String title,
  required Widget child,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(2, 0, 2, 8),
          child: Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
        ),
        MusicGlassSurface(
          borderRadius: BorderRadius.circular(18),
          child: child,
        ),
      ],
    ),
  );
}

class _ColorSwatchButton extends StatelessWidget {
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  const _ColorSwatchButton({
    required this.color,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected
                ? Theme.of(context).colorScheme.onSurface
                : Theme.of(context).colorScheme.outlineVariant,
            width: selected ? 3 : 1,
          ),
        ),
        child: selected
            ? Icon(
                AppIcons.check,
                size: 18,
                color: color.computeLuminance() > 0.52
                    ? Colors.black
                    : Colors.white,
              )
            : null,
      ),
    );
  }
}

const List<Color> _presetColors = [
  AppColorScheme.defaultSeedColor,
  AppColorScheme.musicPink,
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

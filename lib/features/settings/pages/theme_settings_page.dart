import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/design/echo_design.dart';
import '../../../core/theme/color_scheme.dart';
import '../../../providers/theme_provider.dart';
import '../widgets/echo_settings_components.dart';

class ThemeSettingsPage extends ConsumerWidget {
  const ThemeSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(themeSettingsProvider);
    final notifier = ref.read(themeSettingsProvider.notifier);

    return EchoScaffold(
      topBar: EchoTopBar.back(context: context, title: '主题设置'),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: ListView(
            padding: EdgeInsets.fromLTRB(
              context.echoSpacing.md,
              context.echoSpacing.sm,
              context.echoSpacing.md,
              context.echoSpacing.xxl,
            ),
            children: <Widget>[
              EchoSettingsSection(
                title: '外观模式',
                description: '跟随设备，或固定使用浅色与深色界面。',
                children: <Widget>[
                  EchoChoiceRow(
                    title: '跟随系统',
                    description: '自动匹配设备的外观设置',
                    selected: settings.mode == ThemeMode.system,
                    onPressed: () => notifier.setThemeMode(ThemeMode.system),
                    icon: AppIcons.settings,
                  ),
                  EchoChoiceRow(
                    title: '浅色',
                    description: '使用明亮、中性的试听空间',
                    selected: settings.mode == ThemeMode.light,
                    onPressed: () => notifier.setThemeMode(ThemeMode.light),
                    icon: AppIcons.image,
                  ),
                  EchoChoiceRow(
                    title: '深色',
                    description: '使用低亮度的夜间试听空间',
                    selected: settings.mode == ThemeMode.dark,
                    onPressed: () => notifier.setThemeMode(ThemeMode.dark),
                    icon: AppIcons.album,
                  ),
                ],
              ),
              SizedBox(height: context.echoSpacing.xl),
              EchoSettingsSection(
                title: '强调色',
                description: '只用于主要操作、当前选择与键盘焦点。专辑颜色不会扩散到普通页面。',
                children: <Widget>[
                  EchoSurface(
                    level: EchoSurfaceLevel.raised,
                    borderColor: context.echoColors.controlBoundary,
                    padding: EdgeInsets.all(context.echoSpacing.md),
                    child: Row(
                      children: <Widget>[
                        _ColorSwatch(color: settings.seedColor, size: 48),
                        SizedBox(width: context.echoSpacing.sm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '当前强调色',
                                style: context.echoTypography.label,
                              ),
                              SizedBox(height: context.echoSpacing.xxs),
                              Text(
                                _toHex(settings.seedColor),
                                style: context.echoTypography.body.copyWith(
                                  color: context.echoColors.muted,
                                  fontFeatures: const <FontFeature>[
                                    FontFeature.tabularFigures(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: context.echoSpacing.md),
                  Wrap(
                    spacing: context.echoSpacing.xs,
                    runSpacing: context.echoSpacing.xs,
                    children: <Widget>[
                      for (final color in _presetColors)
                        _PresetColorButton(
                          color: color,
                          selected:
                              settings.seedColor.toARGB32() == color.toARGB32(),
                          onPressed: () => notifier.setSeedColor(color),
                        ),
                    ],
                  ),
                  SizedBox(height: context.echoSpacing.md),
                  Wrap(
                    spacing: context.echoSpacing.sm,
                    runSpacing: context.echoSpacing.sm,
                    children: <Widget>[
                      EchoButton.primary(
                        label: '精细调整',
                        leadingIcon: AppIcons.palette,
                        onPressed: () =>
                            _openColorPicker(context, ref, settings.seedColor),
                      ),
                      EchoButton.secondary(
                        label: '恢复 Echo Moss',
                        onPressed: notifier.resetSeedColor,
                      ),
                    ],
                  ),
                ],
              ),
            ],
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
    final selected = await showEchoBottomSheet<Color>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (_) => _ColorPickerSheet(initialColor: initialColor),
    );
    if (selected != null) {
      ref.read(themeSettingsProvider.notifier).setSeedColor(selected);
    }
  }
}

const List<Color> _presetColors = <Color>[
  AppColorScheme.defaultSeedColor,
  Color(0xFF3D7188),
  Color(0xFF6B6F9A),
  Color(0xFF8A633D),
  Color(0xFF8B4F53),
  Color(0xFF7A5576),
  Color(0xFF39796F),
  Color(0xFF626A72),
];

class _ColorPickerSheet extends StatefulWidget {
  const _ColorPickerSheet({required this.initialColor});

  final Color initialColor;

  @override
  State<_ColorPickerSheet> createState() => _ColorPickerSheetState();
}

class _ColorPickerSheetState extends State<_ColorPickerSheet> {
  late HSVColor _hsv;

  @override
  void initState() {
    super.initState();
    _hsv = HSVColor.fromColor(widget.initialColor);
  }

  @override
  Widget build(BuildContext context) {
    final color = _hsv.toColor();

    return EchoBottomSheet(
      title: '调整强调色',
      subtitle: '系统会在保存时校准对比度和色度。',
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.7,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Align(child: _ColorSwatch(color: color, size: 72)),
              SizedBox(height: context.echoSpacing.sm),
              Text(
                _toHex(color),
                textAlign: TextAlign.center,
                style: context.echoTypography.title.copyWith(
                  fontFeatures: const <FontFeature>[
                    FontFeature.tabularFigures(),
                  ],
                ),
              ),
              SizedBox(height: context.echoSpacing.lg),
              _ColorSliderLine(
                label: '色相',
                valueLabel: '${_hsv.hue.round()}°',
                value: _hsv.hue,
                min: 0,
                max: 360,
                activeColor: HSVColor.fromAHSV(
                  1,
                  _hsv.hue,
                  0.72,
                  0.78,
                ).toColor(),
                onChanged: (value) =>
                    setState(() => _hsv = _hsv.withHue(value)),
              ),
              _ColorSliderLine(
                label: '饱和度',
                valueLabel: '${(_hsv.saturation * 100).round()}%',
                value: _hsv.saturation,
                min: 0,
                max: 1,
                activeColor: color,
                onChanged: (value) =>
                    setState(() => _hsv = _hsv.withSaturation(value)),
              ),
              _ColorSliderLine(
                label: '明度',
                valueLabel: '${(_hsv.value * 100).round()}%',
                value: _hsv.value,
                min: 0,
                max: 1,
                activeColor: color,
                onChanged: (value) =>
                    setState(() => _hsv = _hsv.withValue(value)),
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
                      label: '应用',
                      onPressed: () => Navigator.of(context).pop(color),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ColorSliderLine extends StatelessWidget {
  const _ColorSliderLine({
    required this.label,
    required this.valueLabel,
    required this.value,
    required this.min,
    required this.max,
    required this.activeColor,
    required this.onChanged,
  });

  final String label;
  final String valueLabel;
  final double value;
  final double min;
  final double max;
  final Color activeColor;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.echoSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(child: Text(label, style: context.echoTypography.label)),
              Text(
                valueLabel,
                style: context.echoTypography.metadata.copyWith(
                  color: context.echoColors.muted,
                  fontFeatures: const <FontFeature>[
                    FontFeature.tabularFigures(),
                  ],
                ),
              ),
            ],
          ),
          EchoSlider(
            value: value,
            min: min,
            max: max,
            activeColor: activeColor,
            thumbColor: activeColor,
            semanticLabel: label,
            semanticValue: valueLabel,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class _PresetColorButton extends StatelessWidget {
  const _PresetColorButton({
    required this.color,
    required this.selected,
    required this.onPressed,
  });

  final Color color;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final hex = _toHex(color);
    return EchoPressable(
      semanticLabel: '强调色 $hex${selected ? '，已选择' : ''}',
      selected: selected,
      onPressed: onPressed,
      minimumSize: const Size.square(48),
      borderRadius: context.echoRadii.pill,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            _ColorSwatch(color: color, size: 36, selected: selected),
            if (selected)
              Icon(
                AppIcons.check,
                size: 18,
                color: EchoColors.readableOn(color),
              ),
          ],
        ),
      ),
    );
  }
}

class _ColorSwatch extends StatelessWidget {
  const _ColorSwatch({
    required this.color,
    required this.size,
    this.selected = false,
  });

  final Color color;
  final double size;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: selected
              ? context.echoColors.ink
              : context.echoColors.controlBoundary,
          width: selected ? 3 : 1,
        ),
      ),
      child: SizedBox.square(dimension: size),
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

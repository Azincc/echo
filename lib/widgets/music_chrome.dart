import 'dart:ui';

import 'package:echoes/core/theme/app_icons.dart';
import 'package:flutter/material.dart';

class MusicChrome {
  static const double maxContentWidth = 1400;
  static const double pageHorizontalPadding = 20;
  static const BorderRadius albumRadius = BorderRadius.all(Radius.circular(10));
  static const BorderRadius largeRadius = BorderRadius.all(Radius.circular(18));
  static const double albumGridMaxCrossAxisExtent = 190;
  static const double albumGridChildAspectRatio = 0.72;
  static const double albumGridCrossAxisSpacing = 16;
  static const double albumGridMainAxisSpacing = 18;

  static Color elevatedSurface(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Theme.of(context).brightness == Brightness.dark
        ? scheme.surfaceContainerHigh.withValues(alpha: 0.78)
        : Colors.white.withValues(alpha: 0.82);
  }

  static Color hairline(BuildContext context) {
    return Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.72);
  }

  static Color glassFill(
    BuildContext context, {
    bool selected = false,
    bool emphasized = false,
  }) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    if (selected) {
      return Color.lerp(
            scheme.primary.withValues(alpha: isDark ? 0.24 : 0.13),
            scheme.surfaceContainerHigh.withValues(alpha: isDark ? 0.62 : 0.78),
            0.46,
          ) ??
          scheme.primary.withValues(alpha: isDark ? 0.20 : 0.12);
    }
    if (emphasized) {
      return scheme.surfaceContainerHigh.withValues(
        alpha: isDark ? 0.72 : 0.88,
      );
    }
    return scheme.surfaceContainerHighest.withValues(
      alpha: isDark ? 0.34 : 0.52,
    );
  }

  static Border glassBorder(
    BuildContext context, {
    bool selected = false,
    Color? accent,
  }) {
    final theme = Theme.of(context);
    final color = accent ?? theme.colorScheme.primary;
    return Border.all(
      color: selected
          ? color.withValues(
              alpha: theme.brightness == Brightness.dark ? 0.42 : 0.30,
            )
          : hairline(context),
      width: selected ? 0.9 : 0.7,
    );
  }
}

class MusicGradientBackdrop extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const MusicGradientBackdrop({
    super.key,
    required this.child,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.lerp(scheme.surface, scheme.primary, isDark ? 0.16 : 0.08) ??
                scheme.surface,
            scheme.surface,
            scheme.surface,
          ],
          stops: const [0, 0.34, 1],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -96,
            right: -72,
            child: _MusicGlowOrb(
              size: 220,
              color: scheme.primary.withValues(alpha: isDark ? 0.20 : 0.12),
            ),
          ),
          Positioned(
            top: 92,
            left: -96,
            child: _MusicGlowOrb(
              size: 180,
              color: scheme.secondary.withValues(alpha: isDark ? 0.12 : 0.08),
            ),
          ),
          Padding(padding: padding, child: child),
        ],
      ),
    );
  }
}

class _MusicGlowOrb extends StatelessWidget {
  final double size;
  final Color color;

  const _MusicGlowOrb({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 42, sigmaY: 42),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
      ),
    );
  }
}

class MusicGlassSurface extends StatelessWidget {
  final Widget child;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry padding;
  final Color? color;
  final Border? border;
  final double blur;

  const MusicGlassSurface({
    super.key,
    required this.child,
    this.borderRadius = MusicChrome.largeRadius,
    this.padding = EdgeInsets.zero,
    this.color,
    this.border,
    this.blur = 18,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: color ?? MusicChrome.elevatedSurface(context),
            borderRadius: borderRadius,
            border:
                border ??
                Border.all(color: MusicChrome.hairline(context), width: 0.7),
          ),
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
  }
}

class MusicPageHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? leading;
  final List<Widget> actions;
  final EdgeInsetsGeometry padding;

  const MusicPageHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.actions = const [],
    this.padding = const EdgeInsets.fromLTRB(20, 14, 20, 14),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (leading != null) leading!,
              const Spacer(),
              ...actions,
            ],
          ),
          const SizedBox(height: 14),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.displaySmall?.copyWith(
              fontSize: 34,
              height: 1.02,
              fontWeight: FontWeight.w800,
              letterSpacing: 0,
            ),
          ),
          if (subtitle != null && subtitle!.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              subtitle!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class MusicSectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onViewAll;
  final List<Widget> actions;
  final EdgeInsetsGeometry padding;

  const MusicSectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.onViewAll,
    this.actions = const [],
    this.padding = const EdgeInsets.fromLTRB(0, 18, 0, 10),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0,
                  ),
                ),
                if (subtitle != null && subtitle!.isNotEmpty) ...[
                  const SizedBox(height: 3),
                  Text(
                    subtitle!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (actions.isNotEmpty)
            Row(mainAxisSize: MainAxisSize.min, children: actions)
          else if (onViewAll != null)
            TextButton(onPressed: onViewAll, child: const Text('查看全部')),
        ],
      ),
    );
  }
}

class MusicIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final bool selected;
  final EdgeInsetsGeometry margin;
  final double size;

  const MusicIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.tooltip,
    this.selected = false,
    this.margin = const EdgeInsets.only(left: 6),
    this.size = 44,
  });

  @override
  State<MusicIconButton> createState() => _MusicIconButtonState();
}

class _MusicIconButtonState extends State<MusicIconButton> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (_pressed == value) return;
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final enabled = widget.onPressed != null;
    final primary = theme.colorScheme.primary;
    final borderRadius = BorderRadius.circular(999);

    final button = AnimatedScale(
      scale: _pressed && enabled ? 0.94 : 1,
      duration: const Duration(milliseconds: 110),
      curve: Curves.easeOutCubic,
      child: MusicGlassSurface(
        borderRadius: borderRadius,
        padding: EdgeInsets.zero,
        blur: 20,
        color: MusicChrome.glassFill(
          context,
          selected: widget.selected,
          emphasized: true,
        ).withValues(alpha: enabled ? 1 : 0.58),
        border: MusicChrome.glassBorder(context, selected: widget.selected),
        child: SizedBox.square(
          dimension: widget.size,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapDown: enabled ? (_) => _setPressed(true) : null,
            onTapCancel: enabled ? () => _setPressed(false) : null,
            onTapUp: enabled
                ? (_) {
                    _setPressed(false);
                    widget.onPressed?.call();
                  }
                : null,
            child: Center(
              child: Icon(
                widget.icon,
                size: 22,
                color: !enabled
                    ? theme.colorScheme.onSurface.withValues(alpha: 0.34)
                    : widget.selected
                    ? primary
                    : theme.colorScheme.onSurface,
              ),
            ),
          ),
        ),
      ),
    );

    return Padding(
      padding: widget.margin,
      child: widget.tooltip == null
          ? button
          : Tooltip(message: widget.tooltip!, child: button),
    );
  }
}

class MusicSortButton<T> extends StatelessWidget {
  final String title;
  final T value;
  final List<T> options;
  final String Function(T option) labelBuilder;
  final ValueChanged<T> onSelected;

  const MusicSortButton({
    super.key,
    required this.title,
    required this.value,
    required this.options,
    required this.labelBuilder,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return MusicIconButton(
      icon: AppIcons.sort,
      tooltip: '$title：${labelBuilder(value)}',
      onPressed: () async {
        final selected = await showMusicSelectionSheet<T>(
          context: context,
          title: title,
          options: options,
          selected: value,
          labelBuilder: labelBuilder,
        );
        if (selected != null && selected != value && context.mounted) {
          onSelected(selected);
        }
      },
    );
  }
}

class MusicGlassButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool primary;
  final bool destructive;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  const MusicGlassButton({
    super.key,
    required this.child,
    this.onPressed,
    this.icon,
    this.primary = false,
    this.destructive = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
    this.margin = EdgeInsets.zero,
  });

  const MusicGlassButton.icon({
    super.key,
    required this.child,
    required this.icon,
    this.onPressed,
    this.primary = false,
    this.destructive = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
    this.margin = EdgeInsets.zero,
  });

  @override
  State<MusicGlassButton> createState() => _MusicGlassButtonState();
}

class _MusicGlassButtonState extends State<MusicGlassButton> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (_pressed == value) return;
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final enabled = widget.onPressed != null;
    final accent = widget.destructive
        ? theme.colorScheme.error
        : theme.colorScheme.primary;
    final foreground = widget.primary || widget.destructive
        ? accent
        : theme.colorScheme.onSurface;
    return Padding(
      padding: widget.margin,
      child: AnimatedScale(
        scale: _pressed && enabled ? 0.97 : 1,
        duration: const Duration(milliseconds: 110),
        curve: Curves.easeOutCubic,
        child: MusicGlassSurface(
          borderRadius: BorderRadius.circular(999),
          padding: EdgeInsets.zero,
          blur: 18,
          color: widget.primary || widget.destructive
              ? Color.lerp(
                  accent.withValues(
                    alpha: theme.brightness == Brightness.dark ? 0.22 : 0.13,
                  ),
                  MusicChrome.glassFill(context, emphasized: true),
                  0.42,
                )?.withValues(alpha: enabled ? 1 : 0.52)
              : MusicChrome.glassFill(
                  context,
                  emphasized: true,
                ).withValues(alpha: enabled ? 1 : 0.52),
          border: MusicChrome.glassBorder(
            context,
            selected: widget.primary || widget.destructive,
            accent: accent,
          ),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapDown: enabled ? (_) => _setPressed(true) : null,
            onTapCancel: enabled ? () => _setPressed(false) : null,
            onTapUp: enabled
                ? (_) {
                    _setPressed(false);
                    widget.onPressed?.call();
                  }
                : null,
            child: Padding(
              padding: widget.padding,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.icon != null) ...[
                    Icon(
                      widget.icon,
                      size: 18,
                      color: foreground.withValues(alpha: enabled ? 1 : 0.42),
                    ),
                    const SizedBox(width: 8),
                  ],
                  DefaultTextStyle.merge(
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: foreground.withValues(alpha: enabled ? 1 : 0.42),
                      fontWeight: FontWeight.w800,
                    ),
                    child: widget.child,
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

Future<T?> showMusicSelectionSheet<T>({
  required BuildContext context,
  required String title,
  required List<T> options,
  required T selected,
  required String Function(T option) labelBuilder,
}) {
  final theme = Theme.of(context);
  return showModalBottomSheet<T>(
    context: context,
    useSafeArea: true,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withValues(
      alpha: theme.brightness == Brightness.dark ? 0.48 : 0.30,
    ),
    constraints: const BoxConstraints(maxWidth: 520),
    builder: (sheetContext) {
      final sheetTheme = Theme.of(sheetContext);
      final bottomPadding = MediaQuery.of(sheetContext).padding.bottom;
      return Padding(
        padding: EdgeInsets.fromLTRB(12, 0, 12, 12 + bottomPadding),
        child: MusicGlassSurface(
          borderRadius: BorderRadius.circular(24),
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
          color: sheetTheme.colorScheme.surfaceContainerHigh.withValues(
            alpha: sheetTheme.brightness == Brightness.dark ? 0.90 : 0.94,
          ),
          blur: 26,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: sheetTheme.colorScheme.primary.withValues(
                        alpha: 0.14,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      AppIcons.sort,
                      color: sheetTheme.colorScheme.primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: sheetTheme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          labelBuilder(selected),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: sheetTheme.textTheme.bodySmall?.copyWith(
                            color: sheetTheme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MusicIconButton(
                    icon: AppIcons.close,
                    tooltip: '关闭',
                    onPressed: () => Navigator.of(sheetContext).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.sizeOf(sheetContext).height * 0.56,
                ),
                child: ListView(
                  shrinkWrap: true,
                  children: options.map((option) {
                    final isSelected = option == selected;
                    return MusicSelectionTile(
                      title: labelBuilder(option),
                      selected: isSelected,
                      onTap: () => Navigator.of(sheetContext).pop(option),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class MusicLoadingIndicator extends StatelessWidget {
  final double size;
  final double strokeWidth;
  final bool withSurface;

  const MusicLoadingIndicator({
    super.key,
    this.size = 42,
    this.strokeWidth = 3,
    this.withSurface = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final spinner = SizedBox.square(
      dimension: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            strokeWidth: strokeWidth,
            strokeCap: StrokeCap.round,
            valueColor: AlwaysStoppedAnimation(primary),
            backgroundColor: primary.withValues(
              alpha: theme.brightness == Brightness.dark ? 0.20 : 0.12,
            ),
          ),
          Container(
            width: size * 0.18,
            height: size * 0.18,
            decoration: BoxDecoration(
              color: primary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: primary.withValues(alpha: 0.36),
                  blurRadius: 12,
                ),
              ],
            ),
          ),
        ],
      ),
    );

    if (!withSurface) return spinner;

    return MusicGlassSurface(
      borderRadius: BorderRadius.circular(24),
      padding: const EdgeInsets.all(14),
      color: theme.colorScheme.surfaceContainerHigh.withValues(
        alpha: theme.brightness == Brightness.dark ? 0.74 : 0.86,
      ),
      child: spinner,
    );
  }
}

class MusicLoadingPane extends StatelessWidget {
  final String? message;
  final double minHeight;

  const MusicLoadingPane({super.key, this.message, this.minHeight = 120});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: minHeight),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const MusicLoadingIndicator(),
            if (message != null && message!.isNotEmpty) ...[
              const SizedBox(height: 14),
              Text(
                message!,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class MusicGlassTile extends StatefulWidget {
  final Widget? leading;
  final Widget? trailing;
  final String title;
  final String? subtitle;
  final Widget? titleWidget;
  final Widget? subtitleWidget;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool selected;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;

  const MusicGlassTile({
    super.key,
    this.leading,
    this.trailing,
    required this.title,
    this.subtitle,
    this.titleWidget,
    this.subtitleWidget,
    this.onTap,
    this.onLongPress,
    this.selected = false,
    this.margin = const EdgeInsets.only(bottom: 8),
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
  });

  @override
  State<MusicGlassTile> createState() => _MusicGlassTileState();
}

class _MusicGlassTileState extends State<MusicGlassTile> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (_pressed == value) return;
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final enabled = widget.onTap != null || widget.onLongPress != null;
    final primary = theme.colorScheme.primary;
    final radius = BorderRadius.circular(15);

    return Padding(
      padding: widget.margin,
      child: AnimatedScale(
        scale: _pressed && enabled ? 0.985 : 1,
        duration: const Duration(milliseconds: 110),
        curve: Curves.easeOutCubic,
        child: MusicGlassSurface(
          borderRadius: radius,
          padding: EdgeInsets.zero,
          blur: 14,
          color: MusicChrome.glassFill(context, selected: widget.selected),
          border: MusicChrome.glassBorder(context, selected: widget.selected),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapDown: enabled ? (_) => _setPressed(true) : null,
            onTapCancel: enabled ? () => _setPressed(false) : null,
            onLongPress: widget.onLongPress,
            onTapUp: widget.onTap == null
                ? null
                : (_) {
                    _setPressed(false);
                    widget.onTap?.call();
                  },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              curve: Curves.easeOutCubic,
              padding: widget.padding,
              decoration: BoxDecoration(
                borderRadius: radius,
                gradient: widget.selected
                    ? LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          primary.withValues(
                            alpha: theme.brightness == Brightness.dark
                                ? 0.16
                                : 0.10,
                          ),
                          Colors.transparent,
                        ],
                      )
                    : null,
              ),
              child: Row(
                children: [
                  if (widget.leading != null) ...[
                    widget.leading!,
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.titleWidget ??
                            Text(
                              widget.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: widget.selected ? primary : null,
                              ),
                            ),
                        if (widget.subtitleWidget != null) ...[
                          const SizedBox(height: 3),
                          widget.subtitleWidget!,
                        ] else if (widget.subtitle != null &&
                            widget.subtitle!.isNotEmpty) ...[
                          const SizedBox(height: 3),
                          Text(
                            widget.subtitle!,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                              height: 1.25,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (widget.trailing != null) ...[
                    const SizedBox(width: 12),
                    widget.trailing!,
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MusicGlassPill extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback? onTap;
  final IconData? icon;
  final EdgeInsetsGeometry margin;

  const MusicGlassPill({
    super.key,
    required this.label,
    this.selected = false,
    this.onTap,
    this.icon,
    this.margin = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final foreground = selected ? primary : theme.colorScheme.onSurfaceVariant;
    return Padding(
      padding: margin,
      child: MusicGlassSurface(
        borderRadius: BorderRadius.circular(999),
        padding: EdgeInsets.zero,
        blur: 18,
        color: MusicChrome.glassFill(context, selected: selected),
        border: MusicChrome.glassBorder(context, selected: selected),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            curve: Curves.easeOutCubic,
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              boxShadow: selected
                  ? [
                      BoxShadow(
                        color: primary.withValues(alpha: 0.12),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 15, color: foreground),
                  const SizedBox(width: 6),
                ],
                Text(
                  label,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: foreground,
                    fontWeight: selected ? FontWeight.w800 : FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MusicGlassSearchField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;

  const MusicGlassSearchField({
    super.key,
    required this.controller,
    required this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MusicGlassSurface(
      borderRadius: BorderRadius.circular(18),
      blur: 22,
      padding: EdgeInsets.zero,
      color: MusicChrome.glassFill(context, emphasized: true),
      border: MusicChrome.glassBorder(context),
      child: TextField(
        controller: controller,
        textInputAction: TextInputAction.search,
        style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(
            AppIcons.search,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          suffixIcon: controller.text.isEmpty
              ? null
              : Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: MusicIconButton(
                    icon: AppIcons.clear,
                    tooltip: '清除',
                    size: 34,
                    margin: EdgeInsets.zero,
                    onPressed: onClear,
                  ),
                ),
          filled: false,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
        onChanged: onChanged,
        onSubmitted: onSubmitted,
      ),
    );
  }
}

class MusicRadioTile<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final String title;
  final String? subtitle;
  final IconData? icon;
  final ValueChanged<T>? onChanged;

  const MusicRadioTile({
    super.key,
    required this.value,
    required this.groupValue,
    required this.title,
    this.subtitle,
    this.icon,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selected = value == groupValue;
    final primary = theme.colorScheme.primary;

    return MusicGlassTile(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      title: title,
      subtitle: subtitle,
      selected: selected,
      onTap: onChanged == null ? null : () => onChanged!(value),
      leading: icon == null
          ? null
          : Icon(
              icon,
              size: 20,
              color: selected ? primary : theme.colorScheme.onSurfaceVariant,
            ),
      trailing: AnimatedSwitcher(
        duration: const Duration(milliseconds: 150),
        child: Icon(
          selected
              ? AppIcons.radio_button_checked
              : AppIcons.radio_button_unchecked,
          key: ValueKey(selected),
          color: selected
              ? primary
              : theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.76),
        ),
      ),
    );
  }
}

class MusicSelectionTile extends StatelessWidget {
  final Widget? leading;
  final String title;
  final String? subtitle;
  final bool selected;
  final VoidCallback? onTap;
  final Widget? trailing;

  const MusicSelectionTile({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.selected = false,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    return MusicGlassTile(
      leading: leading,
      title: title,
      subtitle: subtitle,
      selected: selected,
      onTap: onTap,
      trailing:
          trailing ??
          Icon(
            selected ? AppIcons.check_circle : AppIcons.circle,
            color: selected
                ? primary
                : theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.48),
            size: selected ? 22 : 13,
          ),
    );
  }
}

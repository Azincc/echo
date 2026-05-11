import 'dart:ui';

import 'package:echoes/core/theme/app_icons.dart';
import 'package:flutter/material.dart';

class MusicChrome {
  static const double maxContentWidth = 1400;
  static const double pageHorizontalPadding = 20;
  static const BorderRadius albumRadius = BorderRadius.all(Radius.circular(10));
  static const BorderRadius largeRadius = BorderRadius.all(Radius.circular(18));

  static Color elevatedSurface(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Theme.of(context).brightness == Brightness.dark
        ? scheme.surfaceContainerHigh.withValues(alpha: 0.78)
        : Colors.white.withValues(alpha: 0.82);
  }

  static Color hairline(BuildContext context) {
    return Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.72);
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

class MusicIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;

  const MusicIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6),
      child: Material(
        color: Theme.of(context).colorScheme.surfaceContainerHigh.withValues(
          alpha: Theme.of(context).brightness == Brightness.dark ? 0.7 : 0.86,
        ),
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: IconButton(
          tooltip: tooltip,
          icon: Icon(icon),
          onPressed: onPressed,
        ),
      ),
    );
  }
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onChanged == null ? null : () => onChanged!(value),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOutCubic,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
            decoration: BoxDecoration(
              color: selected
                  ? primary.withValues(
                      alpha: theme.brightness == Brightness.dark ? 0.18 : 0.10,
                    )
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: selected
                    ? primary.withValues(alpha: 0.42)
                    : Colors.transparent,
              ),
            ),
            child: Row(
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    size: 20,
                    color: selected
                        ? primary
                        : theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: selected ? primary : null,
                        ),
                      ),
                      if (subtitle != null && subtitle!.isNotEmpty) ...[
                        const SizedBox(height: 3),
                        Text(
                          subtitle!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 150),
                  child: Icon(
                    selected
                        ? AppIcons.radio_button_checked
                        : AppIcons.radio_button_unchecked,
                    key: ValueKey(selected),
                    color: selected
                        ? primary
                        : theme.colorScheme.onSurfaceVariant.withValues(
                            alpha: 0.76,
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: selected
            ? primary.withValues(
                alpha: theme.brightness == Brightness.dark ? 0.18 : 0.10,
              )
            : theme.colorScheme.surfaceContainerHighest.withValues(
                alpha: theme.brightness == Brightness.dark ? 0.38 : 0.50,
              ),
        borderRadius: BorderRadius.circular(15),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
            child: Row(
              children: [
                if (leading != null) ...[leading!, const SizedBox(width: 12)],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      if (subtitle != null && subtitle!.isNotEmpty) ...[
                        const SizedBox(height: 3),
                        Text(
                          subtitle!,
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
                const SizedBox(width: 12),
                trailing ??
                    Icon(
                      selected ? AppIcons.check_circle : AppIcons.circle,
                      color: selected
                          ? primary
                          : theme.colorScheme.onSurfaceVariant.withValues(
                              alpha: 0.48,
                            ),
                      size: selected ? 22 : 13,
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

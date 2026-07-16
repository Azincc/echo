import 'package:flutter/material.dart';

import '../../../core/design/echo_design.dart';

class EchoSettingsSection extends StatelessWidget {
  const EchoSettingsSection({
    super.key,
    required this.title,
    required this.children,
    this.description,
  });

  final String title;
  final String? description;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        EchoSectionHeader(title: title, description: description),
        SizedBox(height: context.echoSpacing.xs),
        ...children,
      ],
    );
  }
}

class EchoSettingRow extends StatelessWidget {
  const EchoSettingRow({
    super.key,
    required this.icon,
    required this.title,
    this.description,
    this.value,
    this.trailing,
    this.onPressed,
    this.selected = false,
    this.destructive = false,
    this.semanticLabel,
  });

  final IconData icon;
  final String title;
  final String? description;
  final String? value;
  final Widget? trailing;
  final VoidCallback? onPressed;
  final bool selected;
  final bool destructive;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final colors = context.echoColors;
    final accent = destructive ? colors.error : colors.accent;
    final label =
        semanticLabel ??
        <String>[
          title,
          if (value != null) value!,
          if (description != null) description!,
          if (selected) '已选择',
        ].join('，');

    return Padding(
      padding: EdgeInsets.only(bottom: context.echoSpacing.xs),
      child: EchoPressable(
        semanticLabel: label,
        selected: selected,
        onPressed: onPressed,
        minimumSize: const Size(double.infinity, 72),
        child: AnimatedContainer(
          duration: context.echoMotion.resolve(
            context,
            context.echoMotion.state,
          ),
          curve: context.echoMotion.easeOut,
          padding: EdgeInsets.symmetric(
            horizontal: context.echoSpacing.sm,
            vertical: context.echoSpacing.xs,
          ),
          decoration: BoxDecoration(
            color: selected
                ? accent.withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: context.echoRadii.control,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox.square(
                dimension: context.echoInteraction.minimumTouchTarget,
                child: Center(child: Icon(icon, size: 22, color: accent)),
              ),
              SizedBox(width: context.echoSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: context.echoTypography.title.copyWith(
                        color: destructive ? colors.error : colors.ink,
                      ),
                    ),
                    if (description != null || value != null) ...<Widget>[
                      SizedBox(height: context.echoSpacing.xxs),
                      Text(
                        <String>[
                          if (value != null) value!,
                          if (description != null) description!,
                        ].join(' · '),
                        style: context.echoTypography.body.copyWith(
                          color: colors.muted,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(width: context.echoSpacing.sm),
              trailing ??
                  Icon(AppIcons.chevronRight, size: 20, color: colors.muted),
            ],
          ),
        ),
      ),
    );
  }
}

class EchoToggleSettingRow extends StatelessWidget {
  const EchoToggleSettingRow({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
    this.description,
  });

  final IconData icon;
  final String title;
  final String? description;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return EchoSettingRow(
      icon: icon,
      title: title,
      description: description,
      selected: value,
      semanticLabel:
          '$title，${value ? '已开启' : '已关闭'}${description == null ? '' : '，$description'}',
      onPressed: () => onChanged(!value),
      trailing: _EchoToggle(value: value),
    );
  }
}

class EchoChoiceRow extends StatelessWidget {
  const EchoChoiceRow({
    super.key,
    required this.title,
    required this.selected,
    required this.onPressed,
    this.description,
    this.icon = AppIcons.radio,
  });

  final String title;
  final String? description;
  final bool selected;
  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return EchoSettingRow(
      icon: icon,
      title: title,
      description: description,
      selected: selected,
      onPressed: onPressed,
      trailing: Icon(
        selected ? AppIcons.radioSelected : AppIcons.radio,
        size: 22,
        color: selected ? context.echoColors.accent : context.echoColors.muted,
      ),
    );
  }
}

class EchoProviderSettingRow extends StatelessWidget {
  const EchoProviderSettingRow({
    super.key,
    required this.index,
    required this.title,
    required this.description,
    required this.enabled,
    required this.onChanged,
    this.onConfigure,
    this.configureLabel = '配置',
  });

  final int index;
  final String title;
  final String description;
  final bool enabled;
  final ValueChanged<bool> onChanged;
  final VoidCallback? onConfigure;
  final String configureLabel;

  @override
  Widget build(BuildContext context) {
    final colors = context.echoColors;
    final spacing = context.echoSpacing;

    return Padding(
      padding: EdgeInsets.only(bottom: spacing.xs),
      child: AnimatedContainer(
        duration: context.echoMotion.resolve(context, context.echoMotion.state),
        curve: context.echoMotion.easeOut,
        padding: EdgeInsets.symmetric(
          horizontal: spacing.xs,
          vertical: spacing.xs,
        ),
        decoration: BoxDecoration(
          color: enabled
              ? colors.accent.withValues(alpha: 0.08)
              : Colors.transparent,
          borderRadius: context.echoRadii.control,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final dragHandle = ReorderableDragStartListener(
              index: index,
              child: Semantics(
                button: true,
                label: '按住并拖动$title，调整优先顺序',
                child: SizedBox.square(
                  dimension: context.echoInteraction.minimumTouchTarget,
                  child: Center(
                    child: Icon(
                      AppIcons.dragHandle,
                      size: 22,
                      color: colors.muted,
                    ),
                  ),
                ),
              ),
            );
            final details = Padding(
              padding: EdgeInsets.symmetric(vertical: spacing.xxs),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title, style: context.echoTypography.title),
                  SizedBox(height: spacing.xxs),
                  Text(
                    description,
                    style: context.echoTypography.body.copyWith(
                      color: colors.muted,
                    ),
                  ),
                  SizedBox(height: spacing.xxs),
                  Text(
                    enabled ? '已启用' : '已停用',
                    style: context.echoTypography.metadata.copyWith(
                      color: enabled ? colors.accent : colors.muted,
                    ),
                  ),
                ],
              ),
            );
            final configureButton = onConfigure == null
                ? null
                : EchoIconButton(
                    icon: AppIcons.settings,
                    label: '$configureLabel$title',
                    onPressed: onConfigure,
                  );
            final toggle = EchoPressable(
              semanticLabel: '${enabled ? '停用' : '启用'}$title',
              selected: enabled,
              onPressed: () => onChanged(!enabled),
              minimumSize: const Size(60, 48),
              borderRadius: context.echoRadii.pill,
              child: Center(child: _EchoToggle(value: enabled)),
            );
            final textScale = MediaQuery.textScalerOf(context).scale(1);
            final stackActions = constraints.maxWidth < 420 || textScale >= 1.4;

            if (stackActions) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      dragHandle,
                      SizedBox(width: spacing.xs),
                      Expanded(child: details),
                    ],
                  ),
                  SizedBox(height: spacing.xs),
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      start:
                          context.echoInteraction.minimumTouchTarget +
                          spacing.xs,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        if (configureButton != null) ...<Widget>[
                          configureButton,
                          SizedBox(width: spacing.xs),
                        ],
                        toggle,
                      ],
                    ),
                  ),
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                dragHandle,
                SizedBox(width: spacing.xs),
                Expanded(child: details),
                if (configureButton != null) ...<Widget>[
                  SizedBox(width: spacing.xs),
                  configureButton,
                ],
                SizedBox(width: spacing.xs),
                toggle,
              ],
            );
          },
        ),
      ),
    );
  }
}

class EchoProviderListSkeleton extends StatelessWidget {
  const EchoProviderListSkeleton({super.key, this.count = 4, this.padding});

  final int count;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding:
          padding ??
          EdgeInsets.fromLTRB(
            context.echoSpacing.md,
            context.echoSpacing.sm,
            context.echoSpacing.md,
            context.echoSpacing.xxl,
          ),
      itemCount: count + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: EdgeInsets.only(bottom: context.echoSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const EchoSkeleton.line(width: 120, height: 22),
                SizedBox(height: context.echoSpacing.xs),
                const EchoSkeleton.line(width: 260),
              ],
            ),
          );
        }

        return Padding(
          padding: EdgeInsets.only(bottom: context.echoSpacing.md),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const EchoSkeleton.circle(size: 48),
              SizedBox(width: context.echoSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const EchoSkeleton.line(height: 17),
                    SizedBox(height: context.echoSpacing.xs),
                    const EchoSkeleton.line(),
                    SizedBox(height: context.echoSpacing.xs),
                    const EchoSkeleton.line(width: 72, height: 10),
                  ],
                ),
              ),
              SizedBox(width: context.echoSpacing.sm),
              const EchoSkeleton(width: 60, height: 30),
            ],
          ),
        );
      },
    );
  }
}

class EchoMetricBlock extends StatelessWidget {
  const EchoMetricBlock({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.detail,
  });

  final IconData icon;
  final String label;
  final String value;
  final String? detail;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: <String>[label, value, if (detail != null) detail!].join('，'),
      child: ExcludeSemantics(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: context.echoSpacing.sm),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox.square(
                dimension: context.echoInteraction.minimumTouchTarget,
                child: Center(
                  child: Icon(icon, size: 22, color: context.echoColors.accent),
                ),
              ),
              SizedBox(width: context.echoSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      value,
                      style: context.echoTypography.headline.copyWith(
                        fontFeatures: const <FontFeature>[
                          FontFeature.tabularFigures(),
                        ],
                      ),
                    ),
                    SizedBox(height: context.echoSpacing.xxs),
                    Text(label, style: context.echoTypography.label),
                    if (detail != null) ...<Widget>[
                      SizedBox(height: context.echoSpacing.xxs),
                      Text(
                        detail!,
                        style: context.echoTypography.metadata.copyWith(
                          color: context.echoColors.muted,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EchoToggle extends StatelessWidget {
  const _EchoToggle({required this.value});

  final bool value;

  @override
  Widget build(BuildContext context) {
    final colors = context.echoColors;
    final motion = context.echoMotion;

    return AnimatedContainer(
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
    );
  }
}

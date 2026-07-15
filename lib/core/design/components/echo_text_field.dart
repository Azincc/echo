import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/app_icons.dart';
import '../echo_context.dart';

class EchoTextField extends StatefulWidget {
  const EchoTextField({
    super.key,
    required this.controller,
    required this.label,
    this.focusNode,
    this.hintText,
    this.helperText,
    this.leadingIcon,
    this.trailing,
    this.enabled = true,
    this.obscureText = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.maxLines = 1,
    this.minLines,
    this.autofocus = false,
    this.autofillHints,
    this.inputFormatters,
    this.onChanged,
    this.onSubmitted,
    this.onSaved,
    this.validator,
    this.autovalidateMode = AutovalidateMode.disabled,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;
  final String label;
  final String? hintText;
  final String? helperText;
  final IconData? leadingIcon;
  final Widget? trailing;
  final bool enabled;
  final bool obscureText;
  final bool autocorrect;
  final bool enableSuggestions;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final int? maxLines;
  final int? minLines;
  final bool autofocus;
  final Iterable<String>? autofillHints;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode autovalidateMode;

  @override
  State<EchoTextField> createState() => _EchoTextFieldState();
}

class _EchoTextFieldState extends State<EchoTextField> {
  final GlobalKey<FormFieldState<String>> _fieldKey =
      GlobalKey<FormFieldState<String>>();
  FocusNode? _ownedFocusNode;
  late String _resetValue;

  FocusNode get _focusNode => widget.focusNode ?? _ownedFocusNode!;

  @override
  void initState() {
    super.initState();
    _resetValue = widget.controller.text;
    if (widget.focusNode == null) _ownedFocusNode = FocusNode();
    widget.controller.addListener(_syncFormValue);
  }

  @override
  void didUpdateWidget(covariant EchoTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_syncFormValue);
      _resetValue = widget.controller.text;
      widget.controller.addListener(_syncFormValue);
      WidgetsBinding.instance.addPostFrameCallback((_) => _syncFormValue());
    }
    if (oldWidget.focusNode != widget.focusNode) {
      if (oldWidget.focusNode == null) {
        _ownedFocusNode?.dispose();
        _ownedFocusNode = null;
      }
      if (widget.focusNode == null) _ownedFocusNode = FocusNode();
    }
    if (oldWidget.enabled && !widget.enabled) _focusNode.unfocus();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_syncFormValue);
    _ownedFocusNode?.dispose();
    super.dispose();
  }

  void _syncFormValue() {
    final field = _fieldKey.currentState;
    if (field != null && field.value != widget.controller.text) {
      field.didChange(widget.controller.text);
    }
  }

  void _resetController() {
    final resetValue = TextEditingValue(text: _resetValue);
    if (widget.controller.value != resetValue) {
      widget.controller.value = resetValue;
    }
    widget.onChanged?.call(_resetValue);
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      key: _fieldKey,
      initialValue: widget.controller.text,
      enabled: widget.enabled,
      validator: widget.validator,
      onSaved: widget.onSaved,
      onReset: _resetController,
      autovalidateMode: widget.autovalidateMode,
      builder: (field) => _buildField(context, field),
    );
  }

  Widget _buildField(BuildContext context, FormFieldState<String> field) {
    final colors = context.echoColors;
    final typography = context.echoTypography;
    final spacing = context.echoSpacing;
    final motion = context.echoMotion;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ExcludeSemantics(
          child: Text(
            widget.label,
            style: typography.label.copyWith(
              color: widget.enabled ? colors.ink : colors.onDisabled,
            ),
          ),
        ),
        SizedBox(height: spacing.xs),
        ListenableBuilder(
          listenable: _focusNode,
          builder: (context, child) {
            final focused = _focusNode.hasFocus;
            final hasError = field.errorText != null;
            final borderColor = hasError
                ? colors.error
                : focused
                ? colors.accent
                : colors.controlBoundary;
            final background = widget.enabled
                ? colors.raised
                : Color.alphaBlend(
                    colors.canvas.withValues(alpha: 0.2),
                    colors.raised,
                  );

            return Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: widget.enabled ? _focusNode.requestFocus : null,
                canRequestFocus: false,
                excludeFromSemantics: true,
                splashFactory: NoSplash.splashFactory,
                overlayColor: const WidgetStatePropertyAll<Color>(
                  Colors.transparent,
                ),
                borderRadius: context.echoRadii.control,
                child: AnimatedContainer(
                  duration: motion.resolve(context, motion.state),
                  curve: motion.easeOut,
                  constraints: BoxConstraints(
                    minHeight: context.echoInteraction.inputHeight,
                  ),
                  decoration: BoxDecoration(
                    color: background,
                    borderRadius: context.echoRadii.control,
                    border: Border.all(
                      color: borderColor,
                      width: focused || hasError ? 2 : 1,
                    ),
                  ),
                  child: Focus(
                    canRequestFocus: widget.enabled,
                    descendantsAreFocusable: widget.enabled,
                    child: Row(
                      crossAxisAlignment: widget.maxLines == 1
                          ? CrossAxisAlignment.center
                          : CrossAxisAlignment.start,
                      children: <Widget>[
                        if (widget.leadingIcon != null) ...<Widget>[
                          Padding(
                            padding: EdgeInsetsDirectional.only(
                              start: spacing.sm,
                              top: widget.maxLines == 1 ? 0 : spacing.sm,
                            ),
                            child: ExcludeSemantics(
                              child: Icon(
                                widget.leadingIcon,
                                size: 20,
                                color: focused ? colors.accent : colors.muted,
                              ),
                            ),
                          ),
                          SizedBox(width: spacing.xs),
                        ] else
                          SizedBox(width: spacing.md),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: spacing.sm),
                            child: Semantics(
                              textField: true,
                              enabled: widget.enabled,
                              readOnly: !widget.enabled,
                              obscured: widget.obscureText,
                              label: widget.label,
                              child: DefaultSelectionStyle(
                                cursorColor: colors.accent,
                                selectionColor: colors.accent.withValues(
                                  alpha: 0.24,
                                ),
                                child: ValueListenableBuilder<TextEditingValue>(
                                  valueListenable: widget.controller,
                                  // 仅借用 Flutter 的原生文本选择、菜单和手势；
                                  // Echo 的可见轮廓仍由外层组件完整控制。
                                  child: TextField(
                                    controller: widget.controller,
                                    focusNode: _focusNode,
                                    decoration: null,
                                    style: typography.body.copyWith(
                                      color: widget.enabled
                                          ? colors.ink
                                          : colors.onDisabled,
                                    ),
                                    cursorColor: colors.accent,
                                    keyboardType: widget.keyboardType,
                                    textInputAction: widget.textInputAction,
                                    textCapitalization:
                                        widget.textCapitalization,
                                    maxLines: widget.maxLines,
                                    minLines: widget.minLines,
                                    autofocus: widget.autofocus,
                                    enabled: widget.enabled,
                                    readOnly: !widget.enabled,
                                    showCursor: widget.enabled ? null : false,
                                    obscureText: widget.obscureText,
                                    autocorrect: widget.autocorrect,
                                    enableSuggestions: widget.enableSuggestions,
                                    enableInteractiveSelection: widget.enabled,
                                    autofillHints: widget.autofillHints,
                                    inputFormatters: widget.inputFormatters,
                                    onChanged: widget.onChanged,
                                    onSubmitted: widget.onSubmitted,
                                    keyboardAppearance:
                                        MediaQuery.platformBrightnessOf(
                                          context,
                                        ),
                                  ),
                                  builder: (context, value, editor) {
                                    return Stack(
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                      children: <Widget>[
                                        if (value.text.isEmpty &&
                                            widget.hintText != null)
                                          IgnorePointer(
                                            child: Text(
                                              widget.hintText!,
                                              maxLines: widget.maxLines,
                                              overflow: widget.maxLines == 1
                                                  ? TextOverflow.ellipsis
                                                  : null,
                                              style: typography.body.copyWith(
                                                color: colors.muted,
                                              ),
                                            ),
                                          ),
                                        editor!,
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (widget.trailing != null) ...<Widget>[
                          SizedBox(width: spacing.xs),
                          widget.trailing!,
                        ] else
                          SizedBox(width: spacing.md),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        if (field.errorText != null) ...<Widget>[
          SizedBox(height: spacing.xs),
          Semantics(
            liveRegion: true,
            label: '错误：${field.errorText}',
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(AppIcons.error, size: 16, color: colors.error),
                SizedBox(width: spacing.xxs),
                Expanded(
                  child: Text(
                    field.errorText!,
                    style: typography.metadata.copyWith(color: colors.error),
                  ),
                ),
              ],
            ),
          ),
        ] else if (widget.helperText != null) ...<Widget>[
          SizedBox(height: spacing.xs),
          Text(
            widget.helperText!,
            style: typography.metadata.copyWith(color: colors.muted),
          ),
        ],
      ],
    );
  }
}

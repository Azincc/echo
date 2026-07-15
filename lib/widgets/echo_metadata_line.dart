import 'package:flutter/material.dart';

import '../core/design/echo_design.dart';

/// A single, wrapping metadata sentence with consistent visual and spoken
/// separators.
class EchoMetadataLine extends StatelessWidget {
  const EchoMetadataLine({
    super.key,
    required this.items,
    this.separator = '·',
    this.style,
    this.maxLines,
    this.textAlign,
  });

  final Iterable<String?> items;
  final String separator;
  final TextStyle? style;
  final int? maxLines;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final normalizedItems = items
        .map((item) => item?.trim() ?? '')
        .where((item) => item.isNotEmpty)
        .toList(growable: false);

    if (normalizedItems.isEmpty) return const SizedBox.shrink();

    return Text(
      normalizedItems.join(' $separator '),
      semanticsLabel: normalizedItems.join('，'),
      style:
          style ??
          context.echoTypography.metadata.copyWith(
            color: context.echoColors.muted,
          ),
      maxLines: maxLines,
      overflow: maxLines == null ? TextOverflow.visible : TextOverflow.ellipsis,
      softWrap: true,
      textAlign: textAlign,
    );
  }
}

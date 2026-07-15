import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:palette_generator/palette_generator.dart';

import '../tokens/echo_colors.dart';

/// Semantic, artwork-derived colours for media-led surfaces.
///
/// The model deliberately describes usage instead of exposing palette swatch
/// names. Consumers can therefore render a coherent player stage, compact
/// playback surface, or adjacent panel without deciding whether a particular
/// cover should use its dominant, vibrant, or muted colour.
@immutable
class EchoMediaVisuals {
  const EchoMediaVisuals._({
    required this.stageBase,
    required this.stageGlow,
    required this.stageBottom,
    required this.foreground,
    required this.mutedForeground,
    required this.controlAccent,
    required this.miniSurface,
    required this.panelSurface,
  });

  /// Resolves semantic media colours from all useful PaletteGenerator roles.
  ///
  /// Missing and empty palettes use Echo's stable content tint. Bright covers
  /// remain bright and receive dark ink; dark covers receive light ink. Every
  /// text surface is normalized to WCAG AA, while [controlAccent] maintains at
  /// least 3:1 against the same surfaces.
  factory EchoMediaVisuals.fromPalette(
    PaletteGenerator? palette, {
    Color fallbackSeed = EchoColors.contentTintFallback,
  }) {
    final candidates = _MediaCandidates.fromPalette(palette);
    final seed = _normalizeSeed(
      candidates.stageSeed ?? fallbackSeed,
      maximumSaturation: 0.82,
    );
    final foreground = _foregroundFor(seed);

    final stageBase = _readableSurface(seed, foreground);
    final stageGlow = _readableSurface(
      _stageGlowColor(
        base: stageBase,
        candidate: candidates.glowSeed ?? candidates.accentSeed ?? seed,
        foreground: foreground,
      ),
      foreground,
    );
    final stageBottom = _readableSurface(
      _stageBottomColor(
        base: stageBase,
        candidate: candidates.bottomSeed ?? seed,
        foreground: foreground,
      ),
      foreground,
    );
    final miniSurface = _readableSurface(
      _quietSurface(
        stageBase,
        foreground: foreground,
        saturationFactor: 0.62,
        lightnessShift: 0.035,
      ),
      foreground,
    );
    final panelSurface = _readableSurface(
      _quietSurface(
        stageBase,
        foreground: foreground,
        saturationFactor: 0.48,
        lightnessShift: 0.065,
      ),
      foreground,
    );

    final surfaces = <Color>[
      stageBase,
      stageGlow,
      stageBottom,
      miniSurface,
      panelSurface,
    ];
    final mutedCandidate = Color.lerp(foreground, stageBase, 0.26)!;
    final mutedForeground = _ensureContrastAcrossToward(
      mutedCandidate,
      target: foreground,
      backgrounds: surfaces,
      minimumRatio: 4.5,
    );
    final controlCandidate = _normalizeSeed(
      candidates.accentSeed ?? candidates.stageSeed ?? fallbackSeed,
      maximumSaturation: 0.78,
    );
    final controlAccent = _ensureContrastAcrossToward(
      controlCandidate,
      target: foreground,
      backgrounds: surfaces,
      minimumRatio: 3,
    );

    return EchoMediaVisuals._(
      stageBase: stageBase,
      stageGlow: stageGlow,
      stageBottom: stageBottom,
      foreground: foreground,
      mutedForeground: mutedForeground,
      controlAccent: controlAccent,
      miniSurface: miniSurface,
      panelSurface: panelSurface,
    );
  }

  /// Stable media visuals used before artwork is available or has no palette.
  factory EchoMediaVisuals.fallback({
    Color seed = EchoColors.contentTintFallback,
  }) {
    return EchoMediaVisuals.fromPalette(null, fallbackSeed: seed);
  }

  final Color stageBase;
  final Color stageGlow;
  final Color stageBottom;
  final Color foreground;
  final Color mutedForeground;

  /// A foreground-only accent for glyphs, progress tracks, and boundaries.
  ///
  /// This is not a filled-control surface. No contrast guarantee is made for
  /// [foreground] drawn on top of this colour.
  final Color controlAccent;
  final Color miniSurface;
  final Color panelSurface;

  @override
  bool operator ==(Object other) {
    return other is EchoMediaVisuals &&
        other.stageBase == stageBase &&
        other.stageGlow == stageGlow &&
        other.stageBottom == stageBottom &&
        other.foreground == foreground &&
        other.mutedForeground == mutedForeground &&
        other.controlAccent == controlAccent &&
        other.miniSurface == miniSurface &&
        other.panelSurface == panelSurface;
  }

  @override
  int get hashCode => Object.hash(
    stageBase,
    stageGlow,
    stageBottom,
    foreground,
    mutedForeground,
    controlAccent,
    miniSurface,
    panelSurface,
  );
}

const Color _lightMediaInk = Color(0xFFF7F9FA);
const Color _darkMediaInk = Color(0xFF101316);

Color _foregroundFor(Color background) {
  final lightRatio = EchoColors.contrastRatio(_lightMediaInk, background);
  final darkRatio = EchoColors.contrastRatio(_darkMediaInk, background);
  return lightRatio >= darkRatio ? _lightMediaInk : _darkMediaInk;
}

Color _readableSurface(Color color, Color foreground) {
  return EchoColors.ensureForegroundContrast(
    color.withValues(alpha: 1),
    foreground: foreground,
    minimumRatio: 4.5,
  );
}

Color _stageGlowColor({
  required Color base,
  required Color candidate,
  required Color foreground,
}) {
  final blended = Color.lerp(base, candidate, 0.44)!;
  final hsl = HSLColor.fromColor(blended);
  final isDarkStage = foreground.computeLuminance() > 0.5;
  final saturationBoost = hsl.saturation < 0.06
      ? 0.0
      : math.min(0.08, hsl.saturation * 0.35);
  return hsl
      .withSaturation(math.min(0.82, hsl.saturation + saturationBoost))
      .withLightness(
        (hsl.lightness + (isDarkStage ? 0.045 : 0.035)).clamp(0.04, 0.96),
      )
      .toColor()
      .withValues(alpha: 1);
}

Color _stageBottomColor({
  required Color base,
  required Color candidate,
  required Color foreground,
}) {
  final blended = Color.lerp(base, candidate, 0.36)!;
  final hsl = HSLColor.fromColor(blended);
  final isDarkStage = foreground.computeLuminance() > 0.5;
  return hsl
      .withSaturation(math.min(0.76, hsl.saturation))
      .withLightness(
        (hsl.lightness - (isDarkStage ? 0.05 : 0.035)).clamp(0.04, 0.96),
      )
      .toColor()
      .withValues(alpha: 1);
}

Color _quietSurface(
  Color base, {
  required Color foreground,
  required double saturationFactor,
  required double lightnessShift,
}) {
  final hsl = HSLColor.fromColor(base);
  final isDarkStage = foreground.computeLuminance() > 0.5;
  return hsl
      .withSaturation(hsl.saturation * saturationFactor)
      .withLightness(
        (hsl.lightness + (isDarkStage ? lightnessShift : -lightnessShift))
            .clamp(0.04, 0.96),
      )
      .toColor()
      .withValues(alpha: 1);
}

Color _normalizeSeed(Color color, {required double maximumSaturation}) {
  final hsl = HSLColor.fromColor(color.withValues(alpha: 1));
  return hsl
      .withSaturation(math.min(maximumSaturation, hsl.saturation))
      .withLightness(hsl.lightness.clamp(0.04, 0.96))
      .toColor()
      .withValues(alpha: 1);
}

Color _ensureContrastAcrossToward(
  Color color, {
  required Color target,
  required Iterable<Color> backgrounds,
  required double minimumRatio,
}) {
  final surfaces = backgrounds.toList(growable: false);
  assert(surfaces.isNotEmpty);

  bool passes(Color candidate) => surfaces.every(
    (surface) => EchoColors.contrastRatio(candidate, surface) >= minimumRatio,
  );

  final opaque = color.withValues(alpha: 1);
  if (passes(opaque)) return opaque;
  if (!passes(target)) return target;

  var failing = 0.0;
  var passing = 1.0;
  for (var iteration = 0; iteration < 20; iteration += 1) {
    final midpoint = (failing + passing) / 2;
    final candidate = Color.lerp(opaque, target, midpoint)!;
    if (passes(candidate)) {
      passing = midpoint;
    } else {
      failing = midpoint;
    }
  }
  return Color.lerp(opaque, target, passing)!.withValues(alpha: 1);
}

class _MediaCandidates {
  const _MediaCandidates({
    this.stageSeed,
    this.glowSeed,
    this.bottomSeed,
    this.accentSeed,
  });

  factory _MediaCandidates.fromPalette(PaletteGenerator? palette) {
    if (palette == null || palette.paletteColors.isEmpty) {
      return const _MediaCandidates();
    }

    final dominant = palette.dominantColor;
    final expressive = _bestExpressiveSwatch(palette);
    final stageSeed = _blendDominantWithIdentity(dominant, expressive);
    final lightVibrant = _meaningfulSwatch(palette.lightVibrantColor, dominant);
    final vibrant = _meaningfulSwatch(palette.vibrantColor, dominant);
    final darkVibrant = _meaningfulSwatch(palette.darkVibrantColor, dominant);
    final lightMuted = _meaningfulSwatch(palette.lightMutedColor, dominant);
    final muted = _meaningfulSwatch(palette.mutedColor, dominant);
    final darkMuted = _meaningfulSwatch(palette.darkMutedColor, dominant);

    return _MediaCandidates(
      stageSeed: stageSeed,
      glowSeed:
          lightVibrant?.color ??
          vibrant?.color ??
          lightMuted?.color ??
          expressive?.color,
      bottomSeed:
          darkMuted?.color ??
          darkVibrant?.color ??
          muted?.color ??
          dominant?.color,
      accentSeed:
          vibrant?.color ??
          lightVibrant?.color ??
          darkVibrant?.color ??
          expressive?.color ??
          dominant?.color,
    );
  }

  final Color? stageSeed;
  final Color? glowSeed;
  final Color? bottomSeed;
  final Color? accentSeed;
}

PaletteColor? _bestExpressiveSwatch(PaletteGenerator palette) {
  final dominantPopulation = math.max(
    1,
    palette.dominantColor?.population ?? 1,
  );
  final candidates = <(PaletteColor?, double)>[
    (palette.vibrantColor, 0.44),
    (palette.lightVibrantColor, 0.34),
    (palette.darkVibrantColor, 0.34),
    (palette.mutedColor, 0.28),
    (palette.lightMutedColor, 0.18),
    (palette.darkMutedColor, 0.18),
    for (final swatch in palette.paletteColors) (swatch, 0.10),
  ];

  PaletteColor? best;
  var bestScore = double.negativeInfinity;
  final seen = <Color>{};
  for (final (swatch, roleWeight) in candidates) {
    if (swatch == null || !seen.add(swatch.color)) continue;
    final population = (swatch.population / dominantPopulation).clamp(0, 1);
    if (swatch.color != palette.dominantColor?.color &&
        population < _minimumExpressivePopulationRatio) {
      continue;
    }
    final hsl = HSLColor.fromColor(swatch.color);
    final extremePenalty = (hsl.lightness - 0.5).abs() * 0.08;
    final score =
        roleWeight + hsl.saturation * 0.34 + population * 0.26 - extremePenalty;
    if (score > bestScore) {
      best = swatch;
      bestScore = score;
    }
  }
  return best;
}

Color? _blendDominantWithIdentity(
  PaletteColor? dominant,
  PaletteColor? expressive,
) {
  if (dominant == null) return expressive?.color;
  if (expressive == null || expressive.color == dominant.color) {
    return dominant.color;
  }

  final populationRatio =
      (expressive.population / math.max(1, dominant.population)).clamp(
        0.0,
        1.0,
      );
  if (populationRatio < _minimumExpressivePopulationRatio) {
    return dominant.color;
  }

  final dominantHsl = HSLColor.fromColor(dominant.color);
  final expressiveHsl = HSLColor.fromColor(expressive.color);
  var influence = 0.26;
  influence +=
      math.max(0, expressiveHsl.saturation - dominantHsl.saturation) * 0.34;
  if (dominantHsl.saturation < 0.10) influence += 0.10;
  if (dominantHsl.lightness < 0.08 || dominantHsl.lightness > 0.92) {
    influence += 0.08;
  }
  influence *= math.sqrt(populationRatio);
  return Color.lerp(
    dominant.color,
    expressive.color,
    influence.clamp(0.0, 0.60),
  );
}

const double _minimumExpressivePopulationRatio = 0.02;

PaletteColor? _meaningfulSwatch(PaletteColor? swatch, PaletteColor? dominant) {
  if (swatch == null || dominant == null || swatch.color == dominant.color) {
    return swatch;
  }
  final ratio = swatch.population / math.max(1, dominant.population);
  return ratio >= _minimumExpressivePopulationRatio ? swatch : null;
}

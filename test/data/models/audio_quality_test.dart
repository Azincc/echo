import 'package:flutter_test/flutter_test.dart';
import 'package:echoes/data/models/audio_quality.dart';

void main() {
  // -------------------------------------------------------------------------
  // AudioQualityLevel
  // -------------------------------------------------------------------------

  group('AudioQualityLevel.maxBitRate', () {
    test('original → null (no limit)', () {
      expect(AudioQualityLevel.original.maxBitRate, isNull);
    });

    test('high → 320', () {
      expect(AudioQualityLevel.high.maxBitRate, 320);
    });

    test('standard → 192', () {
      expect(AudioQualityLevel.standard.maxBitRate, 192);
    });

    test('dataSaver → 128', () {
      expect(AudioQualityLevel.dataSaver.maxBitRate, 128);
    });
  });

  group('AudioQualityLevel.displayName', () {
    test('all levels have non-empty display names', () {
      for (final level in AudioQualityLevel.values) {
        expect(level.displayName.isNotEmpty, true);
      }
    });
  });

  group('AudioQualityLevel.rank', () {
    test('original is highest rank', () {
      expect(AudioQualityLevel.original.rank, 3);
    });

    test('dataSaver is lowest rank', () {
      expect(AudioQualityLevel.dataSaver.rank, 0);
    });

    test('rank ordering: dataSaver < standard < high < original', () {
      expect(
        AudioQualityLevel.dataSaver.rank <
            AudioQualityLevel.standard.rank,
        true,
      );
      expect(
        AudioQualityLevel.standard.rank < AudioQualityLevel.high.rank,
        true,
      );
      expect(
        AudioQualityLevel.high.rank < AudioQualityLevel.original.rank,
        true,
      );
    });
  });

  group('AudioQualityLevelExt.fromString', () {
    test('parses known values', () {
      expect(
        AudioQualityLevelExt.fromString('high'),
        AudioQualityLevel.high,
      );
      expect(
        AudioQualityLevelExt.fromString('dataSaver'),
        AudioQualityLevel.dataSaver,
      );
    });

    test('defaults to original for unknown value', () {
      expect(
        AudioQualityLevelExt.fromString('unknown'),
        AudioQualityLevel.original,
      );
    });
  });

  // -------------------------------------------------------------------------
  // AudioQualitySettings
  // -------------------------------------------------------------------------

  group('AudioQualitySettings', () {
    test('default constructor has expected defaults', () {
      const settings = AudioQualitySettings();

      expect(settings.wifiQuality, AudioQualityLevel.original);
      expect(settings.mobileQuality, AudioQualityLevel.standard);
      expect(settings.autoSwitch, true);
    });

    test('copyWith changes only specified field', () {
      const settings = AudioQualitySettings();
      final copy = settings.copyWith(mobileQuality: AudioQualityLevel.dataSaver);

      expect(copy.mobileQuality, AudioQualityLevel.dataSaver);
      expect(copy.wifiQuality, AudioQualityLevel.original); // unchanged
      expect(copy.autoSwitch, true); // unchanged
    });
  });

  group('AudioQualitySettings serialization', () {
    test('toJson → fromJson round-trip', () {
      const original = AudioQualitySettings(
        wifiQuality: AudioQualityLevel.high,
        mobileQuality: AudioQualityLevel.dataSaver,
        autoSwitch: false,
      );

      final json = original.toJson();
      final restored = AudioQualitySettings.fromJson(json);

      expect(restored.wifiQuality, original.wifiQuality);
      expect(restored.mobileQuality, original.mobileQuality);
      expect(restored.autoSwitch, original.autoSwitch);
    });

    test('toJsonString → fromJsonString round-trip', () {
      const original = AudioQualitySettings(
        wifiQuality: AudioQualityLevel.standard,
        mobileQuality: AudioQualityLevel.high,
        autoSwitch: true,
      );

      final jsonStr = original.toJsonString();
      final restored = AudioQualitySettings.fromJsonString(jsonStr);

      expect(restored.wifiQuality, original.wifiQuality);
      expect(restored.mobileQuality, original.mobileQuality);
      expect(restored.autoSwitch, original.autoSwitch);
    });

    test('fromJson with missing fields uses defaults', () {
      final settings = AudioQualitySettings.fromJson({});

      expect(settings.wifiQuality, AudioQualityLevel.original);
      expect(settings.mobileQuality, AudioQualityLevel.standard);
      expect(settings.autoSwitch, true);
    });
  });
}

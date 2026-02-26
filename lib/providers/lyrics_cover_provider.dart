import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/provider_config.dart';
import '../data/models/lyrics.dart';
import '../data/repositories/lyrics_repository.dart';
import '../data/repositories/cover_repository.dart';
import '../data/sources/database/app_database.dart';
import '../data/sources/database/database_provider.dart';
import '../data/sources/lyrics/lyrics_source.dart';
import '../data/sources/lyrics/subsonic_lyrics_source.dart';
import '../data/sources/lyrics/lrclib_lyrics_source.dart';
import '../data/sources/lyrics/netease_lyrics_source.dart';
import '../data/sources/lyrics/custom_lyrics_source.dart';
import '../data/sources/covers/cover_source.dart';
import '../data/sources/covers/subsonic_cover_source.dart';
import '../data/sources/covers/fanart_cover_source.dart';
import '../data/sources/covers/musicbrainz_cover_source.dart';
import '../data/sources/covers/custom_cover_source.dart';
import '../core/utils/lrc_parser.dart';
import 'api_provider.dart';
import 'library_provider.dart';
import 'player_provider.dart';
import 'gd_music_provider.dart';

// ======== 提供商配置 Providers ========

final lyricsProviderConfigsProvider = StreamProvider<List<ProviderConfig>>((
  ref,
) {
  final db = ref.watch(appDatabaseProvider);
  return (db.select(
    db.lyricsProviderConfigs,
  )..orderBy([(t) => OrderingTerm.asc(t.priority)])).watch().map(
    (rows) => rows
        .map(
          (r) => ProviderConfig(
            id: r.id,
            sourceId: r.sourceId,
            enabled: r.enabled,
            priority: r.priority,
            config: r.config != null
                ? jsonDecode(r.config!) as Map<String, dynamic>?
                : null,
          ),
        )
        .toList(),
  );
});

final coverProviderConfigsProvider = StreamProvider<List<ProviderConfig>>((
  ref,
) {
  final db = ref.watch(appDatabaseProvider);
  return (db.select(
    db.coverProviderConfigs,
  )..orderBy([(t) => OrderingTerm.asc(t.priority)])).watch().map(
    (rows) => rows
        .map(
          (r) => ProviderConfig(
            id: r.id,
            sourceId: r.sourceId,
            enabled: r.enabled,
            priority: r.priority,
            config: r.config != null
                ? jsonDecode(r.config!) as Map<String, dynamic>?
                : null,
          ),
        )
        .toList(),
  );
});

// ======== 歌词相关 Providers ========

LyricsSource _createLyricsSource(
  String sourceId,
  Map<String, dynamic>? config,
  SubsonicLyricsSource subsonicSource,
) {
  switch (sourceId) {
    case 'subsonic':
      return subsonicSource;
    case 'lrclib':
      return LrclibLyricsSource();
    case 'netease':
      return NeteaseLyricsSource();
    case 'custom':
      final urlTemplate = config?['url'] as String? ?? '';
      return CustomLyricsSource(urlTemplate: urlTemplate);
    default:
      return LrclibLyricsSource();
  }
}

List<String> _extractOpenSubsonicExtensions(
  Map<String, dynamic>? extensionsMap,
) {
  if (extensionsMap == null || extensionsMap.isEmpty) return const [];

  // Current persisted shape: {'supported': ['songLyrics', ...], 'serverFingerprint': ...}
  final supported = extensionsMap['supported'];
  if (supported is List) {
    return supported.whereType<String>().toList();
  }

  // Backward-compat fallback: extension names stored as top-level keys.
  return extensionsMap.keys
      .where((k) => k != 'supported' && k != 'serverFingerprint')
      .toList();
}

final lyricsRepositoryProvider = Provider<LyricsRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final apiClient = ref.watch(subsonicApiClientProvider);
  final activeLib = ref.watch(activeLibraryProvider);
  final configs = ref.watch(lyricsProviderConfigsProvider).valueOrNull ?? [];

  final extensions = _extractOpenSubsonicExtensions(activeLib?.extensions);
  final subsonicSource = SubsonicLyricsSource(apiClient, extensions);

  final sources = configs
      .where((c) => c.enabled)
      .map((c) => _createLyricsSource(c.sourceId, c.config, subsonicSource))
      .toList();

  return LyricsRepository(sources: sources, db: db);
});

final currentLyricsProvider = FutureProvider<Lyrics?>((ref) async {
  // 只监听当前歌曲变化，不监听播放位置等其他状态
  // 避免每次 position 更新（~200ms）都重新拉取歌词
  final song = ref.watch(playerProvider.select((s) => s.currentSong));
  if (song == null) return null;

  if (song.isPreview) {
    final source = song.previewSource?.trim() ?? '';
    final lyricId = (song.previewLyricId ?? song.previewTrackId ?? '').trim();
    if (source.isNotEmpty && lyricId.isNotEmpty) {
      try {
        final client = ref.watch(gdMusicApiClientProvider);
        final lyric = await client.fetchLyrics(
          source: source,
          lyricId: lyricId,
        );
        if (lyric != null && lyric.lyric.trim().isNotEmpty) {
          final entries = [LrcParser.parse(lyric.lyric)];
          final tlyric = lyric.translation?.trim();
          if (tlyric != null && tlyric.isNotEmpty) {
            entries.add(LrcParser.parse(tlyric));
          }
          return Lyrics(sourceId: 'gd_$source', entries: entries);
        }
      } catch (_) {
        // 试听歌词失败后回退到常规歌词源，尽量保证可用性。
      }
    }
  }

  final repo = ref.watch(lyricsRepositoryProvider);
  return repo.getLyrics(
    songId: song.id,
    title: song.title,
    artist: song.artist ?? '',
    album: song.album,
    duration: song.duration != null ? Duration(seconds: song.duration!) : null,
  );
});

// ======== 封面相关 Providers ========

CoverSource _createCoverSource(
  String sourceId,
  Map<String, dynamic>? config,
  SubsonicCoverSource subsonicSource,
) {
  switch (sourceId) {
    case 'subsonic':
      return subsonicSource;
    case 'fanart':
      final apiKey = config?['apiKey'] as String? ?? '';
      return FanartCoverSource(apiKey: apiKey);
    case 'musicbrainz':
      return MusicbrainzCoverSource();
    case 'custom':
      final urlTemplate = config?['url'] as String? ?? '';
      return CustomCoverSource(urlTemplate: urlTemplate);
    default:
      return subsonicSource;
  }
}

final coverRepositoryProvider = Provider<CoverRepository>((ref) {
  final apiClient = ref.watch(subsonicApiClientProvider);
  final configs = ref.watch(coverProviderConfigsProvider).valueOrNull ?? [];

  final subsonicSource = SubsonicCoverSource(apiClient);

  final sources = configs
      .where((c) => c.enabled)
      .map((c) => _createCoverSource(c.sourceId, c.config, subsonicSource))
      .toList();

  return CoverRepository(sources: sources);
});

// ======== 提供商配置管理 ========

Future<void> updateLyricsProviderOrder(
  AppDatabase db,
  List<ProviderConfig> configs,
) async {
  for (int i = 0; i < configs.length; i++) {
    await (db.update(db.lyricsProviderConfigs)
          ..where((t) => t.id.equals(configs[i].id)))
        .write(LyricsProviderConfigsCompanion(priority: Value(i)));
  }
}

Future<void> updateCoverProviderOrder(
  AppDatabase db,
  List<ProviderConfig> configs,
) async {
  for (int i = 0; i < configs.length; i++) {
    await (db.update(db.coverProviderConfigs)
          ..where((t) => t.id.equals(configs[i].id)))
        .write(CoverProviderConfigsCompanion(priority: Value(i)));
  }
}

Future<void> toggleLyricsProvider(
  AppDatabase db,
  String id,
  bool enabled,
) async {
  await (db.update(db.lyricsProviderConfigs)..where((t) => t.id.equals(id)))
      .write(LyricsProviderConfigsCompanion(enabled: Value(enabled)));
}

Future<void> toggleCoverProvider(
  AppDatabase db,
  String id,
  bool enabled,
) async {
  await (db.update(db.coverProviderConfigs)..where((t) => t.id.equals(id)))
      .write(CoverProviderConfigsCompanion(enabled: Value(enabled)));
}

Future<void> updateCoverProviderConfig(
  AppDatabase db,
  String id,
  Map<String, dynamic>? config,
) async {
  final hasValidEntry =
      config != null &&
      config.values.any((v) {
        if (v == null) return false;
        if (v is String) return v.trim().isNotEmpty;
        return true;
      });
  await (db.update(
    db.coverProviderConfigs,
  )..where((t) => t.id.equals(id))).write(
    CoverProviderConfigsCompanion(
      config: Value(hasValidEntry ? jsonEncode(config) : null),
    ),
  );
}

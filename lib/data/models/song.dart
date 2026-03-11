/// 歌曲模型
class Song {
  final String id;
  final String title;
  final String? album;
  final String? albumId;
  final String? artist;
  final String? artistId;
  final int? track;
  final int? year;
  final String? genre;
  final String? coverArt;
  final int? size;
  final String? contentType;
  final String? suffix;
  final int? duration; // 秒
  final int? bitRate;
  final int? bitDepth;
  final int? samplingRate;
  final int? channelCount;
  final String? path;
  final bool? isVideo;
  final int? playCount;
  final DateTime? created;
  final bool starred;
  final int? discNumber;
  final String? type;
  final bool isPreview;
  final String? previewSource;
  final String? previewTrackId;
  final String? previewLyricId;
  final String? previewPicId;
  final String? previewStreamUrl;
  final String? previewCoverUrl;
  final String? previewQualityLabel;
  final Map<String, String> previewRequestHeaders;

  Song({
    required this.id,
    required this.title,
    this.album,
    this.albumId,
    this.artist,
    this.artistId,
    this.track,
    this.year,
    this.genre,
    this.coverArt,
    this.size,
    this.contentType,
    this.suffix,
    this.duration,
    this.bitRate,
    this.bitDepth,
    this.samplingRate,
    this.channelCount,
    this.path,
    this.isVideo,
    this.playCount,
    this.created,
    this.starred = false,
    this.discNumber,
    this.type,
    this.isPreview = false,
    this.previewSource,
    this.previewTrackId,
    this.previewLyricId,
    this.previewPicId,
    this.previewStreamUrl,
    this.previewCoverUrl,
    this.previewQualityLabel,
    this.previewRequestHeaders = const {},
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Song && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  Song copyWith({
    String? id,
    String? title,
    String? album,
    String? albumId,
    String? artist,
    String? artistId,
    int? track,
    int? year,
    String? genre,
    String? coverArt,
    int? size,
    String? contentType,
    String? suffix,
    int? duration,
    int? bitRate,
    int? bitDepth,
    int? samplingRate,
    int? channelCount,
    String? path,
    bool? isVideo,
    int? playCount,
    DateTime? created,
    bool? starred,
    int? discNumber,
    String? type,
    bool? isPreview,
    String? previewSource,
    String? previewTrackId,
    String? previewLyricId,
    String? previewPicId,
    String? previewStreamUrl,
    String? previewCoverUrl,
    String? previewQualityLabel,
    Map<String, String>? previewRequestHeaders,
  }) {
    return Song(
      id: id ?? this.id,
      title: title ?? this.title,
      album: album ?? this.album,
      albumId: albumId ?? this.albumId,
      artist: artist ?? this.artist,
      artistId: artistId ?? this.artistId,
      track: track ?? this.track,
      year: year ?? this.year,
      genre: genre ?? this.genre,
      coverArt: coverArt ?? this.coverArt,
      size: size ?? this.size,
      contentType: contentType ?? this.contentType,
      suffix: suffix ?? this.suffix,
      duration: duration ?? this.duration,
      bitRate: bitRate ?? this.bitRate,
      bitDepth: bitDepth ?? this.bitDepth,
      samplingRate: samplingRate ?? this.samplingRate,
      channelCount: channelCount ?? this.channelCount,
      path: path ?? this.path,
      isVideo: isVideo ?? this.isVideo,
      playCount: playCount ?? this.playCount,
      created: created ?? this.created,
      starred: starred ?? this.starred,
      discNumber: discNumber ?? this.discNumber,
      type: type ?? this.type,
      isPreview: isPreview ?? this.isPreview,
      previewSource: previewSource ?? this.previewSource,
      previewTrackId: previewTrackId ?? this.previewTrackId,
      previewLyricId: previewLyricId ?? this.previewLyricId,
      previewPicId: previewPicId ?? this.previewPicId,
      previewStreamUrl: previewStreamUrl ?? this.previewStreamUrl,
      previewCoverUrl: previewCoverUrl ?? this.previewCoverUrl,
      previewQualityLabel: previewQualityLabel ?? this.previewQualityLabel,
      previewRequestHeaders:
          previewRequestHeaders ?? this.previewRequestHeaders,
    );
  }

  /// 从 JSON 反序列化
  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'] as String,
      title: json['title'] as String,
      album: json['album'] as String?,
      albumId: json['albumId'] as String?,
      artist: json['artist'] as String?,
      artistId: json['artistId'] as String?,
      track: json['track'] as int?,
      year: json['year'] as int?,
      genre: json['genre'] as String?,
      coverArt: json['coverArt'] as String?,
      size: json['size'] as int?,
      contentType: json['contentType'] as String?,
      suffix: json['suffix'] as String?,
      duration: json['duration'] as int?,
      bitRate: json['bitRate'] as int?,
      bitDepth: json['bitDepth'] as int?,
      samplingRate: json['samplingRate'] as int?,
      channelCount: json['channelCount'] as int?,
      path: json['path'] as String?,
      isVideo: json['isVideo'] as bool?,
      playCount: json['playCount'] as int?,
      created: json['created'] != null
          ? DateTime.parse(json['created'] as String)
          : null,
      starred: json['starred'] != null,
      discNumber: json['discNumber'] as int?,
      type: json['type'] as String?,
      isPreview: json['isPreview'] as bool? ?? false,
      previewSource: json['previewSource'] as String?,
      previewTrackId: json['previewTrackId'] as String?,
      previewLyricId: json['previewLyricId'] as String?,
      previewPicId: json['previewPicId'] as String?,
      previewStreamUrl: json['previewStreamUrl'] as String?,
      previewCoverUrl: json['previewCoverUrl'] as String?,
      previewQualityLabel: json['previewQualityLabel'] as String?,
      previewRequestHeaders:
          (json['previewRequestHeaders'] as Map?)?.map(
            (key, value) => MapEntry(key.toString(), value.toString()),
          ) ??
          const {},
    );
  }

  /// 序列化为 JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'album': album,
      'albumId': albumId,
      'artist': artist,
      'artistId': artistId,
      'track': track,
      'year': year,
      'genre': genre,
      'coverArt': coverArt,
      'size': size,
      'contentType': contentType,
      'suffix': suffix,
      'duration': duration,
      'bitRate': bitRate,
      'bitDepth': bitDepth,
      'samplingRate': samplingRate,
      'channelCount': channelCount,
      'path': path,
      'isVideo': isVideo,
      'playCount': playCount,
      'created': created?.toIso8601String(),
      'starred': starred,
      'discNumber': discNumber,
      'type': type,
      'isPreview': isPreview,
      'previewSource': previewSource,
      'previewTrackId': previewTrackId,
      'previewLyricId': previewLyricId,
      'previewPicId': previewPicId,
      'previewStreamUrl': previewStreamUrl,
      'previewCoverUrl': previewCoverUrl,
      'previewQualityLabel': previewQualityLabel,
      'previewRequestHeaders': previewRequestHeaders,
    };
  }

  /// 获取时长字符串（格式：mm:ss）
  String get durationString {
    if (duration == null) return '--:--';
    final minutes = duration! ~/ 60;
    final seconds = duration! % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}

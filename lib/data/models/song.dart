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
  final String? path;
  final bool? isVideo;
  final int? playCount;
  final DateTime? created;
  final bool starred;
  final int? discNumber;
  final String? type;

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
    this.path,
    this.isVideo,
    this.playCount,
    this.created,
    this.starred = false,
    this.discNumber,
    this.type,
  });

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
      path: json['path'] as String?,
      isVideo: json['isVideo'] as bool?,
      playCount: json['playCount'] as int?,
      created: json['created'] != null
          ? DateTime.parse(json['created'] as String)
          : null,
      starred: json['starred'] != null,
      discNumber: json['discNumber'] as int?,
      type: json['type'] as String?,
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
      'path': path,
      'isVideo': isVideo,
      'playCount': playCount,
      'created': created?.toIso8601String(),
      'starred': starred,
      'discNumber': discNumber,
      'type': type,
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

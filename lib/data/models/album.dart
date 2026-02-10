/// 专辑模型
class Album {
  final String id;
  final String name;
  final String? artist;
  final String? artistId;
  final String? coverArt;
  final int songCount;
  final int duration; // 秒
  final int? playCount;
  final DateTime? created;
  final int? year;
  final String? genre;
  final bool starred;

  Album({
    required this.id,
    required this.name,
    this.artist,
    this.artistId,
    this.coverArt,
    required this.songCount,
    required this.duration,
    this.playCount,
    this.created,
    this.year,
    this.genre,
    this.starred = false,
  });

  /// 从 JSON 反序列化
  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'] as String,
      name: json['name'] as String,
      artist: json['artist'] as String?,
      artistId: json['artistId'] as String?,
      coverArt: json['coverArt'] as String?,
      songCount: json['songCount'] as int? ?? 0,
      duration: json['duration'] as int? ?? 0,
      playCount: json['playCount'] as int?,
      created: json['created'] != null
          ? DateTime.parse(json['created'] as String)
          : null,
      year: json['year'] as int?,
      genre: json['genre'] as String?,
      starred: json['starred'] != null,
    );
  }

  /// 序列化为 JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'artist': artist,
      'artistId': artistId,
      'coverArt': coverArt,
      'songCount': songCount,
      'duration': duration,
      'playCount': playCount,
      'created': created?.toIso8601String(),
      'year': year,
      'genre': genre,
      'starred': starred,
    };
  }

  /// 获取时长字符串
  String get durationString {
    final minutes = duration ~/ 60;
    final seconds = duration % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}

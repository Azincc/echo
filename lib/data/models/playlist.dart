import 'song.dart';

/// 歌单模型
class Playlist {
  final String id;
  final String name;
  final String? comment;
  final String? owner;
  final bool public;
  final int songCount;
  final int duration; // 秒
  final DateTime? created;
  final DateTime? changed;
  final String? coverArt;
  final List<Song>? songs; // 歌单详情时才有

  Playlist({
    required this.id,
    required this.name,
    this.comment,
    this.owner,
    this.public = false,
    required this.songCount,
    required this.duration,
    this.created,
    this.changed,
    this.coverArt,
    this.songs,
  });

  /// 从 JSON 反序列化
  factory Playlist.fromJson(Map<String, dynamic> json) {
    List<Song>? songsList;
    if (json['entry'] != null) {
      songsList = (json['entry'] as List)
          .map((e) => Song.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    return Playlist(
      id: json['id'] as String,
      name: json['name'] as String,
      comment: json['comment'] as String?,
      owner: json['owner'] as String?,
      public: json['public'] as bool? ?? false,
      songCount: json['songCount'] as int? ?? 0,
      duration: json['duration'] as int? ?? 0,
      created: json['created'] != null
          ? DateTime.parse(json['created'] as String)
          : null,
      changed: json['changed'] != null
          ? DateTime.parse(json['changed'] as String)
          : null,
      coverArt: json['coverArt'] as String?,
      songs: songsList,
    );
  }

  /// 序列化为 JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'comment': comment,
      'owner': owner,
      'public': public,
      'songCount': songCount,
      'duration': duration,
      'created': created?.toIso8601String(),
      'changed': changed?.toIso8601String(),
      'coverArt': coverArt,
      if (songs != null) 'entry': songs!.map((s) => s.toJson()).toList(),
    };
  }

  /// 获取时长字符串
  String get durationString {
    final minutes = duration ~/ 60;
    final seconds = duration % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}

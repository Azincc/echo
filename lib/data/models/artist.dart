/// 歌手模型
class Artist {
  final String id;
  final String name;
  final String? coverArt;
  final int? albumCount;
  final bool starred;

  Artist({
    required this.id,
    required this.name,
    this.coverArt,
    this.albumCount,
    this.starred = false,
  });

  /// 从 JSON 反序列化
  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      id: json['id'] as String,
      name: json['name'] as String,
      coverArt: json['coverArt'] as String?,
      albumCount: json['albumCount'] as int?,
      starred: json['starred'] != null,
    );
  }

  /// 序列化为 JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'coverArt': coverArt,
      'albumCount': albumCount,
      'starred': starred,
    };
  }
}

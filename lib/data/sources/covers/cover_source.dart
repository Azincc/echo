/// 封面数据源抽象接口
abstract class CoverSource {
  String get id;
  String get displayName;
  bool get requiresConfig;

  /// 获取封面图 URL
  /// 返回 null 表示未找到
  Future<String?> fetchCoverUrl({
    required String artist,
    String? album,
    String? musicBrainzId,
    String? coverArtId,
    int? size,
  });
}

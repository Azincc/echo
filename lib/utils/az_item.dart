import 'package:azlistview/azlistview.dart';

/// App 支持 A-Z 索引的数据模型包装类
///
/// [T] 是原始数据模型类型 (e.g., Song, Artist)
class AzItem<T> extends ISuspensionBean {
  final T data;
  final String tag;
  final String namePinyin;

  AzItem({required this.data, required this.tag, required this.namePinyin});

  @override
  String getSuspensionTag() => tag;
}

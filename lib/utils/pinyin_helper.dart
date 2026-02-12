import 'package:lpinyin/lpinyin.dart' as lp;

class PinyinUtils {
  /// 获取字符串的首字符（用于索引和排序）
  ///
  /// 如果是中文，返回拼音首字母（大写）
  /// 如果是英文，返回首字母（大写）
  /// 如果是其他字符，返回 '#'
  static String getFirstChar(String str) {
    if (str.isEmpty) return '#';

    String pinyin = PinyinUtils.getPinyin(str);
    if (pinyin.isEmpty) return '#';

    String firstChar = pinyin.substring(0, 1).toUpperCase();
    if (RegExp('[A-Z]').hasMatch(firstChar)) {
      return firstChar;
    } else {
      return '#';
    }
  }

  /// 获取字符串的拼音
  ///
  /// [defPinyin] 默认拼音，如果转换失败则返回此值
  /// [format] 拼音格式，默认为不带声调
  static String getPinyin(
    String str, {
    String defPinyin = '#',
    lp.PinyinFormat format = lp.PinyinFormat.WITHOUT_TONE,
  }) {
    // lpinyin 2.x 使用 PinyinHelper.getPinyin
    try {
      return lp.PinyinHelper.getPinyin(str, separator: '', format: format);
    } catch (e) {
      return defPinyin;
    }
  }

  /// 获取用于排序的各种Tag
  /// 返回一个Map，包含 'tagIndex' (索引栏显示的字符) and 'namePinyin' (用于排序的完整拼音)
  static Map<String, String> getPinyinTags(String str) {
    String pinyin = PinyinUtils.getPinyin(str);
    String tagIndex = '#';

    if (pinyin.isNotEmpty) {
      String first = pinyin.substring(0, 1).toUpperCase();
      if (RegExp('[A-Z]').hasMatch(first)) {
        tagIndex = first;
      }
    }

    return {'tagIndex': tagIndex, 'namePinyin': pinyin.toUpperCase()};
  }
}

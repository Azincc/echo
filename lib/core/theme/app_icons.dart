import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:remixicon/remixicon.dart';

/// Semantic icon vocabulary used by Echo's current interface.
///
/// Call sites name the intent rather than a glyph. Remix supplies Echo's
/// product symbols; only platform-standard navigation and dismissal actions
/// use Cupertino symbols.
abstract final class AppIcons {
  // Platform navigation.
  static const back = CupertinoIcons.back;
  static const forward = CupertinoIcons.forward;
  static const close = CupertinoIcons.clear;
  static const chevronRight = Remix.arrow_right_s_line;
  static const chevronDown = Remix.arrow_down_s_line;
  static const chevronUp = Remix.arrow_up_s_line;

  // App destinations and global actions.
  static const home = Remix.home_8_line;
  static const homeFilled = Remix.home_8_fill;
  static const discover = Remix.compass_discover_line;
  static const discoverFilled = Remix.compass_discover_fill;
  static const library = Remix.folder_music_line;
  static const libraryFilled = Remix.folder_music_fill;
  static const profile = Remix.account_circle_line;
  static const profileFilled = Remix.account_circle_fill;
  static const settings = Remix.settings_4_line;
  static const menu = Remix.menu_4_line;
  static const search = Remix.search_2_line;
  static const more = Remix.more_2_fill;

  // Playback and listening modes.
  static const play = Remix.play_large_fill;
  static const playCircleOutline = Remix.play_circle_line;
  static const pause = Remix.pause_large_fill;
  static const previous = Remix.skip_back_mini_fill;
  static const next = Remix.skip_forward_mini_fill;
  static const shuffle = Remix.shuffle_fill;
  static const repeat = Remix.repeat_2_line;
  static const repeatOne = Remix.repeat_one_fill;
  static const queue = Remix.list_ordered_2;
  static const queueAdd = Remix.menu_add_line;
  static const playlist = Remix.play_list_2_fill;
  static const playlistAdd = Remix.play_list_add_fill;
  static const lyrics = Remix.chat_quote_line;
  static const lyricsFilled = Remix.chat_quote_fill;
  static const equalizer = Remix.equalizer_2_line;
  static const headphones = Remix.headphone_fill;

  // Media and collection state.
  static const album = Remix.disc_fill;
  static const albumOutline = Remix.disc_line;
  static const music = Remix.music_2_line;
  static const musicFilled = Remix.music_2_fill;
  static const image = Remix.image_circle_line;
  static const brokenImage = Remix.file_damage_line;
  static const heart = Remix.heart_3_fill;
  static const heartOutline = Remix.heart_3_line;
  static const bookmark = Remix.bookmark_line;
  static const history = Remix.history_fill;
  static const fire = Remix.fire_fill;
  static const folderOpen = Remix.folder_open_fill;
  static const fileText = Remix.file_list_3_line;
  static const fileSearch = Remix.file_scan_line;

  // Transfer and availability state.
  static const download = Remix.download_2_fill;
  static const downloadOutline = Remix.download_2_line;
  static const downloadCloud = Remix.download_cloud_2_line;
  static const offline = Remix.folder_download_fill;
  static const cloud = Remix.cloud_fill;
  static const cloudOff = Remix.cloud_off_fill;
  static const wifi = Remix.signal_wifi_3_line;
  static const wifiOff = Remix.signal_wifi_off_line;
  static const signal = Remix.signal_cellular_2_line;
  static const signalTower = Remix.base_station_line;

  // Selection and editing.
  static const add = Remix.add_large_line;
  static const addCircle = Remix.add_circle_fill;
  static const check = Remix.check_fill;
  static const checkCircle = Remix.verified_badge_fill;
  static const checkCircleOutline = Remix.verified_badge_line;
  static const radio = Remix.radio_button_line;
  static const radioSelected = Remix.radio_button_fill;
  static const selectAll = Remix.list_check_3;
  static const edit = Remix.edit_line;
  static const editNote = Remix.file_edit_fill;
  static const delete = Remix.delete_bin_6_line;
  static const clearAll = Remix.eraser_line;
  static const removeCircle = Remix.checkbox_indeterminate_line;
  static const save = Remix.save_2_line;
  static const dragHandle = Remix.drag_move_2_line;
  static const sort = Remix.sort_alphabet_asc;
  static const tune = Remix.equalizer_line;
  static const refresh = Remix.restart_line;

  // Feedback, identity, and configuration.
  static const info = Remix.information_2_line;
  static const help = Remix.question_answer_line;
  static const warning = Remix.alert_line;
  static const error = Remix.close_circle_fill;
  static const people = Remix.group_3_line;
  static const analytics = Remix.bar_chart_box_line;
  static const chart = Remix.area_chart_line;
  static const shield = Remix.shield_check_line;
  static const key = Remix.key_2_line;
  static const route = Remix.road_map_line;
  static const router = Remix.router_fill;
  static const storage = Remix.hard_drive_3_line;
  static const sdCard = Remix.sd_card_mini_line;
  static const timer = Remix.timer_2_line;
  static const time = Remix.time_fill;
  static const quality = Remix.speed_line;
  static const palette = Remix.paint_brush_line;
}

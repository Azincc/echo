# Echo UI Baseline Manifest

## Authority

The pre-redesign behavior and visual baseline is the `main` commit
`f34dbd5221b71a8539e7fac8559602ade876ed23`. Baseline captures must be made
from that commit, not from a partially migrated Echo UI worktree.

An image already present in `docs/screenshots/` is marked **verify** until its
commit, device size, theme, text scale, route, and state have been checked
against the frozen baseline. **Missing** means that no page-level capture is
currently tracked.

## Page Coverage

| # | Page | Source | Target capture | Status |
|---:|---|---|---|---|
| 1 | Login | `features/auth/pages/login_page.dart` | `quickstart-server-address.png`, `quickstart-login-credentials.png` | verify |
| 2 | Discover | `features/discover/pages/discover_page.dart` | `music-home.png` | verify |
| 3 | Search | `features/discover/pages/search_page.dart` | `search-page.png` | missing |
| 4 | Explore | `features/explore/pages/explore_page.dart` | `explore-page.png` | verify |
| 5 | Library | `features/library/pages/library_page.dart` | `library-home.png` | missing |
| 6 | Album list | `features/library/pages/album_list_page.dart` | `album-library.png` | missing |
| 7 | Artist list | `features/library/pages/artist_list_page.dart` | `artist-library.png` | missing |
| 8 | Song list | `features/library/pages/song_list_page.dart` | `song-library.png` | missing |
| 9 | Starred | `features/library/pages/starred_page.dart` | `starred-library.png` | missing |
| 10 | Album detail | `features/library/pages/album_detail_page.dart` | `album-detail.png` | missing |
| 11 | Artist detail | `features/library/pages/artist_detail_page.dart` | `artist-detail.png` | missing |
| 12 | Playlist detail | `features/library/pages/playlist_detail_page.dart` | `playlist-detail.png` | missing |
| 13 | Edit library | `features/library/pages/edit_library_page.dart` | `edit-library-multi-endpoint.png` | verify |
| 14 | Song metadata editor | `features/library/pages/song_metadata_edit_page.dart` | `song-metadata-editor.png` | missing |
| 15 | Full player | `features/player/pages/full_player_page.dart` | `full-player.png` | verify |
| 16 | Download manager | `features/download/pages/download_manager_page.dart` | `download-manager.png` | verify |
| 17 | Offline download status | `features/offline/pages/offline_download_status_page.dart` | `offline-download-manager.png` | verify |
| 18 | App settings | `features/settings/pages/app_settings_page.dart` | `profile-page.png` | verify |
| 19 | Theme settings | `features/settings/pages/theme_settings_page.dart` | `theme-settings.png` | verify |
| 20 | Audio quality | `features/settings/pages/audio_quality_page.dart` | `audio-quality.png` | missing |
| 21 | Lyrics providers | `features/settings/pages/lyrics_providers_page.dart` | `lyrics-providers.png` | missing |
| 22 | Cover providers | `features/settings/pages/cover_providers_page.dart` | `cover-providers.png` | missing |
| 23 | Cache management | `features/settings/pages/cache_management_page.dart` | `cache-management.png` | verify |
| 24 | Playback statistics | `features/settings/pages/playback_stats_page.dart` | `stats-overview.png` | verify |

## Required Overlay Coverage

The page count above does not replace the required key-overlay captures:

- MiniPlayer in paused, playing, loading, and unavailable states.
- Play queue sheet.
- Synced lyrics view, including missing lyrics.
- Song, album, and playlist action sheets.
- Playlist create/rename flow.
- Address add/edit flow.
- Destructive confirmation and recoverable error state.
- Offline/weak-network banner while cached content remains usable.

## Capture Matrix

Each accepted page or overlay needs metadata for:

- source commit;
- Android or iOS and exact viewport;
- light or dark mode;
- text scale (`100%`, `130%`, or `200%`);
- reduce-motion setting;
- route and data state;
- capture date and reviewer.

At minimum, the full 24-page set must be captured at `360 x 800` in light and
dark mode. Critical flows additionally require `430 x 932`, `600 x 960`, and
`200%` text-scale evidence as defined by the overhaul plan.

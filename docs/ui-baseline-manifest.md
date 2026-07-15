# Echo UI Baseline and Acceptance Manifest

## Authority

The frozen pre-redesign behavior baseline is `main` commit
`f34dbd5221b71a8539e7fac8559602ade876ed23`.

The accepted redesign captures were rendered from UI commit
`98c1f788616a1279cf051c9d7b6c4806296ed223`. The subsequent clean-room
follow-up `f9615e72` only rewrites the route-label expression in
`app_drawer.dart`; it does not change the rendered interface or behavior.

The screenshot artifacts are intentionally untracked and stored locally at:

`D:\DevCaches\echo-zero-reuse-ui-captures\98c1f788\360x800`

Capture date: `2026-07-15`.

## Device and Capture Contract

- Platform: Android emulator, Android 16 / API 36.
- Logical viewport: `360 x 800`.
- PNG pixel size: `990 x 2200`.
- Density override: `440 dpi`.
- Standard text scale: `100%`.
- Large-text evidence: `200%` for Music Home, Library, and App Settings.
- Animation scales: window `1.0`, transition `1.0`, animator `1.0`.
- Light and dark captures were forced for their respective matrix pass.
- Final application preference was restored to **Follow system**; emulator
  night mode was restored to `auto` and airplane mode to `off`.

This manifest closes the compact Android page matrix. It does not replace the
broader release gates in `docs/echo-ui-overhaul-plan.md`: `430 x 932`,
`600 x 960`, landscape, iOS, `130%` text, screen-reader, and profiling evidence
still require their own platform pass before the whole cross-platform plan can
be marked complete.

## Page Coverage

The 24 pages map to 25 target files because Login has separate server and
credential steps. Both themes now have every target file.

| # | Page | Source | Target capture | Light | Dark |
|---:|---|---|---|---|---|
| 1 | Login | `features/auth/pages/login_page.dart` | `quickstart-server-address.png`, `quickstart-login-credentials.png` | captured | captured |
| 2 | Discover | `features/discover/pages/discover_page.dart` | `music-home.png` | captured | captured |
| 3 | Search | `features/discover/pages/search_page.dart` | `search-page.png` | captured | captured |
| 4 | Explore | `features/explore/pages/explore_page.dart` | `explore-page.png` | captured | captured |
| 5 | Library | `features/library/pages/library_page.dart` | `library-home.png` | captured | captured |
| 6 | Album list | `features/library/pages/album_list_page.dart` | `album-library.png` | captured | captured |
| 7 | Artist list | `features/library/pages/artist_list_page.dart` | `artist-library.png` | captured | captured |
| 8 | Song list | `features/library/pages/song_list_page.dart` | `song-library.png` | captured | captured |
| 9 | Starred | `features/library/pages/starred_page.dart` | `starred-library.png` | captured | captured |
| 10 | Album detail | `features/library/pages/album_detail_page.dart` | `album-detail.png` | captured | captured |
| 11 | Artist detail | `features/library/pages/artist_detail_page.dart` | `artist-detail.png` | captured | captured |
| 12 | Playlist detail | `features/library/pages/playlist_detail_page.dart` | `playlist-detail.png` | captured | captured |
| 13 | Edit library | `features/library/pages/edit_library_page.dart` | `edit-library-multi-endpoint.png` | captured | captured |
| 14 | Song metadata editor | `features/library/pages/song_metadata_edit_page.dart` | `song-metadata-editor.png` | captured | captured |
| 15 | Full player | `features/player/pages/full_player_page.dart` | `full-player.png` | captured | captured |
| 16 | Download manager | `features/download/pages/download_manager_page.dart` | `download-manager.png` | captured | captured |
| 17 | Offline download status | `features/offline/pages/offline_download_status_page.dart` | `offline-download-manager.png` | captured | captured |
| 18 | App settings | `features/settings/pages/app_settings_page.dart` | `profile-page.png` | captured | captured |
| 19 | Theme settings | `features/settings/pages/theme_settings_page.dart` | `theme-settings.png` | captured | captured |
| 20 | Audio quality | `features/settings/pages/audio_quality_page.dart` | `audio-quality.png` | captured | captured |
| 21 | Lyrics providers | `features/settings/pages/lyrics_providers_page.dart` | `lyrics-providers.png` | captured | captured |
| 22 | Cover providers | `features/settings/pages/cover_providers_page.dart` | `cover-providers.png` | captured | captured |
| 23 | Cache management | `features/settings/pages/cache_management_page.dart` | `cache-management.png` | captured | captured |
| 24 | Playback statistics | `features/settings/pages/playback_stats_page.dart` | `stats-overview.png` | captured | captured |

## Matrix Summary

| Directory | Files | Required targets | Page coverage | Extra flows / overlays |
|---|---:|---:|---:|---:|
| `light` | 38 | 25 / 25 | 24 / 24 | 13 |
| `dark` | 27 | 25 / 25 | 24 / 24 | 2 |
| `dark-200pct` | 3 | 3 critical pages | 3 / 24 | 0 |
| **Total** | **68** | **50 / 50 light-dark targets** | **48 / 48 page-theme cells** | **15** |

All 68 PNG files use the accepted `990 x 2200` pixel size. The previous
off-size offline-banner image was replaced, and the temporary root capture was
removed before acceptance.

## Flow and State Evidence

Additional visual evidence includes:

- MiniPlayer paused and playing states.
- Full-player queue and lyrics surfaces.
- Song options sheet.
- App drawer and route selection.
- HTTP confirmation and address editing.
- Local and remote search results.
- Real Embed Service offline job completion.
- Global offline status strip while cached content remains usable.

Automated tests additionally cover:

- MiniPlayer to full player to queue navigation and state synchronization.
- Metadata editor loading, error, empty-candidate, validation, and unsaved-exit
  states.
- Network strip hidden, weak-network, offline, recovery, and 200% text states.

The compact Android 24-page light-dark matrix is complete. Rare edge-overlay
screenshots, such as unavailable playback or missing lyrics, remain outside
this accepted page matrix. Missing-lyrics behavior and the core player state
transitions have targeted component coverage; the wider device and platform
evidence remains governed by the overhaul plan.

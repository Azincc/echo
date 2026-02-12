# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Echo** is a Flutter-based Navidrome/Subsonic music streaming client. It communicates with Subsonic-compatible servers (primarily Navidrome) via the Subsonic REST API (v1.16.1). The app supports all major platforms (Android, iOS, macOS, Windows, Linux, Web).

## Common Commands

```bash
# Install dependencies
flutter pub get

# Run the app
flutter run

# Run code generation (Freezed, JSON serializable, Drift, Riverpod)
dart run build_runner build --delete-conflicting-outputs

# Watch mode for code generation
dart run build_runner watch --delete-conflicting-outputs

# Analyze code
flutter analyze

# Run tests
flutter test

# Run a single test file
flutter test test/path_to_test.dart

# Build for a specific platform
flutter build apk
flutter build ios
flutter build windows
flutter build macos
flutter build linux
flutter build web
```

## Architecture

### Layered Structure (`lib/`)

```
lib/
├── core/          # Constants, theme, utilities, network infrastructure, services
├── data/          # Models, repositories, data sources (API client, database, local storage)
├── features/      # Feature modules (auth, discover, library, player, sidebar)
├── providers/     # Riverpod providers (app-wide state management)
├── widgets/       # Shared widgets (main scaffold, drawer, cover art)
├── main.dart      # Entry point — wraps App in ProviderScope
└── app.dart       # MaterialApp.router setup, GoRouter configuration, SplashPage
```

### Key Architectural Decisions

- **State Management**: Riverpod (`flutter_riverpod`). Providers live in `lib/providers/`. Some use `riverpod_generator` for code generation.
- **Routing**: GoRouter with `StatefulShellRoute.indexedStack` for tab navigation (Discover / Library). Auth state drives redirects — see `routerProvider` in `app.dart`.
- **Networking**: Dio with custom interceptors. `SubsonicApiClient` in `lib/data/sources/subsonic_api_client.dart` handles all Subsonic API communication, including auth param injection via `_SubsonicAuthInterceptor`.
- **Database**: Drift (SQLite) for local persistence. Tables in `lib/data/sources/database/tables/`. Generated files end in `.g.dart`.
- **Models**: Freezed for immutable data classes (`music_library.dart`, `server_address.dart`). Other models (`album.dart`, `song.dart`, etc.) are plain Dart classes with manual JSON parsing.
- **Audio**: `just_audio` + `audio_service` + `just_audio_background` for playback with background audio and system notification controls.

### Code Generation

Four generators are in use — **always run `dart run build_runner build --delete-conflicting-outputs` after modifying**:
- **Freezed** (`.freezed.dart`) — immutable models with `@freezed`
- **json_serializable** (`.g.dart`) — JSON serialization with `@JsonSerializable`
- **Drift** (`.g.dart`) — database schema from table definitions
- **riverpod_generator** (`.g.dart`) — providers with `@riverpod`

### Network Resilience Layer (`core/network/`)

- `AddressPool` — manages multiple server addresses for failover
- `ConnectivityMonitor` — tracks network connectivity state
- `FallbackInterceptor` — Dio interceptor for automatic failover on connection failure
- `HealthChecker` — periodic server health checks

### Subsonic API Authentication

Two auth modes supported (see `SubsonicAuth` in `core/utils/subsonic_auth.dart`):
1. **Token/Salt** — `MD5(password + salt)` sent as `t` and `s` query params
2. **API Key** — `apiKey` query param (for OpenSubsonic-compatible servers)

Auth params are automatically injected into every request by `_SubsonicAuthInterceptor`.

### Navigation Structure

- `/splash` → auth check + redirect
- `/login` → login page
- `/home` → Discover tab (music stream)
- `/library` → Library tab (user's collection)
- `MainScaffold` wraps tabbed content with `NavigationBar` + `MiniPlayer` (bottom sheet) + `AppDrawer` (sidebar)

## Conventions

- UI text and code comments are primarily in **Chinese**.
- Lint rules follow `package:flutter_lints/flutter.yaml` with `use_null_aware_elements: false`.
- The Subsonic API client name is `"echo"` and targets API version `1.16.1`.
- CI/CD: GitHub Actions workflows exist per platform in `.github/workflows/`.

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:echoes/providers/auth_provider.dart';
import 'package:echoes/data/repositories/auth_repository.dart';
import 'package:echoes/data/repositories/library_repository.dart';
import 'package:echoes/data/models/music_library.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockLibraryRepository extends Mock implements LibraryRepository {}

void main() {
  late MockAuthRepository mockAuthRepo;
  late MockLibraryRepository mockLibraryRepo;

  setUpAll(() {
    registerFallbackValue(MusicLibrary(
      id: '',
      name: '',
      createdAt: DateTime(2020),
      updatedAt: DateTime(2020),
    ));
  });

  setUp(() {
    mockAuthRepo = MockAuthRepository();
    mockLibraryRepo = MockLibraryRepository();
  });

  MusicLibrary sampleLibrary({bool isActive = true}) => MusicLibrary(
        id: 'lib-1',
        name: 'Test Library',
        username: 'testuser',
        password: 'testpass',
        isActive: isActive,
        createdAt: DateTime(2024, 1, 1),
        updatedAt: DateTime(2024, 1, 1),
      );

  // -------------------------------------------------------------------------
  // AuthState
  // -------------------------------------------------------------------------

  group('AuthState', () {
    test('default state has expected values', () {
      final state = AuthState();
      expect(state.isAuthenticated, false);
      expect(state.isLoading, false);
      expect(state.isInitializing, true);
      expect(state.currentLibrary, isNull);
      expect(state.errorMessage, isNull);
    });

    test('copyWith changes only specified fields', () {
      final state = AuthState();
      final updated = state.copyWith(isAuthenticated: true, isLoading: true);

      expect(updated.isAuthenticated, true);
      expect(updated.isLoading, true);
      expect(updated.isInitializing, true); // unchanged
      expect(updated.currentLibrary, isNull); // unchanged
    });

    test('copyWith with currentLibrary', () {
      final lib = sampleLibrary();
      final state = AuthState().copyWith(currentLibrary: lib);

      expect(state.currentLibrary, isNotNull);
      expect(state.currentLibrary!.id, 'lib-1');
      expect(state.currentLibrary!.name, 'Test Library');
    });

    test('copyWith clears errorMessage when null is passed', () {
      final state = AuthState(errorMessage: 'old error');
      final cleared = state.copyWith(errorMessage: null);

      expect(cleared.errorMessage, isNull);
    });
  });

  // -------------------------------------------------------------------------
  // AuthNotifier — _init
  // -------------------------------------------------------------------------

  group('AuthNotifier._init', () {
    test('sets isAuthenticated=true when active library exists', () async {
      when(() => mockLibraryRepo.watchLibraries()).thenAnswer(
        (_) => Stream.value([sampleLibrary(isActive: true)]),
      );

      final notifier = AuthNotifier(mockAuthRepo, mockLibraryRepo);

      // Wait for async _init to complete
      await Future.delayed(const Duration(milliseconds: 100));

      expect(notifier.state.isAuthenticated, true);
      expect(notifier.state.isInitializing, false);
      expect(notifier.state.currentLibrary?.id, 'lib-1');
    });

    test('sets isAuthenticated=false when no active library', () async {
      when(() => mockLibraryRepo.watchLibraries()).thenAnswer(
        (_) => Stream.value([sampleLibrary(isActive: false)]),
      );

      final notifier = AuthNotifier(mockAuthRepo, mockLibraryRepo);
      await Future.delayed(const Duration(milliseconds: 100));

      expect(notifier.state.isAuthenticated, false);
      expect(notifier.state.isInitializing, false);
    });

    test('sets isAuthenticated=false when watchLibraries throws', () async {
      when(() => mockLibraryRepo.watchLibraries()).thenAnswer(
        (_) => Stream.error(Exception('db error')),
      );

      final notifier = AuthNotifier(mockAuthRepo, mockLibraryRepo);
      await Future.delayed(const Duration(milliseconds: 100));

      expect(notifier.state.isAuthenticated, false);
      expect(notifier.state.isInitializing, false);
    });
  });

  // -------------------------------------------------------------------------
  // AuthNotifier — loginWithPassword
  // -------------------------------------------------------------------------

  group('AuthNotifier.loginWithPassword', () {
    test('successful login sets isAuthenticated=true', () async {
      when(() => mockLibraryRepo.watchLibraries()).thenAnswer(
        (_) => Stream.value([]),
      );
      when(
        () => mockAuthRepo.loginWithPassword(
          serverUrl: any(named: 'serverUrl'),
          username: any(named: 'username'),
          password: any(named: 'password'),
          libraryName: any(named: 'libraryName'),
          addressLabel: any(named: 'addressLabel'),
        ),
      ).thenAnswer(
        (_) async => LoginResult(
          success: true,
          library: sampleLibrary(),
        ),
      );
      when(() => mockLibraryRepo.addLibrary(any())).thenAnswer((_) async {});
      when(
        () => mockLibraryRepo.setActiveLibrary(any()),
      ).thenAnswer((_) async {});

      final notifier = AuthNotifier(mockAuthRepo, mockLibraryRepo);
      await Future.delayed(const Duration(milliseconds: 50));

      final result = await notifier.loginWithPassword(
        serverUrl: 'https://music.example.com',
        username: 'user',
        password: 'pass',
      );

      expect(result, true);
      expect(notifier.state.isAuthenticated, true);
      expect(notifier.state.currentLibrary, isNotNull);
      verify(() => mockLibraryRepo.addLibrary(any())).called(1);
      verify(() => mockLibraryRepo.setActiveLibrary(any())).called(1);
    });

    test('failed login sets errorMessage', () async {
      when(() => mockLibraryRepo.watchLibraries()).thenAnswer(
        (_) => Stream.value([]),
      );
      when(
        () => mockAuthRepo.loginWithPassword(
          serverUrl: any(named: 'serverUrl'),
          username: any(named: 'username'),
          password: any(named: 'password'),
          libraryName: any(named: 'libraryName'),
          addressLabel: any(named: 'addressLabel'),
        ),
      ).thenAnswer(
        (_) async => LoginResult(
          success: false,
          errorMessage: 'Invalid credentials',
        ),
      );

      final notifier = AuthNotifier(mockAuthRepo, mockLibraryRepo);
      await Future.delayed(const Duration(milliseconds: 50));

      final result = await notifier.loginWithPassword(
        serverUrl: 'https://music.example.com',
        username: 'user',
        password: 'wrong',
      );

      expect(result, false);
      expect(notifier.state.isAuthenticated, false);
      expect(notifier.state.errorMessage, 'Invalid credentials');
    });
  });

  // -------------------------------------------------------------------------
  // AuthNotifier — logout
  // -------------------------------------------------------------------------

  group('AuthNotifier.logout', () {
    test('clears authentication state', () async {
      when(() => mockLibraryRepo.watchLibraries()).thenAnswer(
        (_) => Stream.value([sampleLibrary()]),
      );
      when(
        () => mockLibraryRepo.setActiveLibrary(any()),
      ).thenAnswer((_) async {});

      final notifier = AuthNotifier(mockAuthRepo, mockLibraryRepo);
      await Future.delayed(const Duration(milliseconds: 100));

      expect(notifier.state.isAuthenticated, true); // pre-condition

      await notifier.logout();

      expect(notifier.state.isAuthenticated, false);
      expect(notifier.state.currentLibrary, isNull);
      verify(() => mockLibraryRepo.setActiveLibrary('')).called(1);
    });
  });

  // -------------------------------------------------------------------------
  // AuthNotifier — switchLibrary
  // -------------------------------------------------------------------------

  group('AuthNotifier.switchLibrary', () {
    test('updates currentLibrary and isAuthenticated', () async {
      when(() => mockLibraryRepo.watchLibraries()).thenAnswer(
        (_) => Stream.value([]),
      );

      final notifier = AuthNotifier(mockAuthRepo, mockLibraryRepo);
      await Future.delayed(const Duration(milliseconds: 50));

      final lib = sampleLibrary();
      notifier.switchLibrary(lib);

      expect(notifier.state.isAuthenticated, true);
      expect(notifier.state.currentLibrary?.id, 'lib-1');
    });
  });

  // -------------------------------------------------------------------------
  // AuthNotifier — clearError
  // -------------------------------------------------------------------------

  group('AuthNotifier.clearError', () {
    test('clears errorMessage', () async {
      when(() => mockLibraryRepo.watchLibraries()).thenAnswer(
        (_) => Stream.value([]),
      );

      final notifier = AuthNotifier(mockAuthRepo, mockLibraryRepo);
      await Future.delayed(const Duration(milliseconds: 50));

      // Simulate an error state
      notifier.clearError();
      expect(notifier.state.errorMessage, isNull);
    });
  });
}

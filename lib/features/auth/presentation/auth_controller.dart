import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_wallet_lite/core/services/secure_storage_service.dart';
import 'package:habit_wallet_lite/features/auth/domain/auth_repository.dart';

// AUTH REPOSITORY IMPLEMENTATION
class AuthLocalRepository implements AuthRepository {
  final SecureStorageService storage;

  AuthLocalRepository(this.storage);

  @override
  Future<bool> login(
      String email,
      String pin,
      bool rememberMe,
      ) async {
    final stored = await storage.getAuth();

    // First-time registration
    if (stored == null) {
      await storage.saveAuth(
        email: email,
        pin: pin,
        rememberMe: rememberMe,
      );
      return true;
    }

    // Validate credentials
    final isValid =
        stored.email == email && stored.pin == pin;

    if (!isValid) return false;

    // Update rememberMe ONLY
    await storage.saveAuth(
      email: stored.email,
      pin: stored.pin,
      rememberMe: rememberMe,
    );

    return true;
  }

  @override
  Future<bool> isLoggedIn() {
    return storage.isLoggedIn();
  }

  @override
  Future<void> logout() {
    return storage.disableAutoLogin();
  }
}


// PROVIDERS
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthLocalRepository(SecureStorageService());
});

final authControllerProvider =
AsyncNotifierProvider<AuthController, bool>(
  AuthController.new,
);

// AUTH CONTROLLER
class AuthController extends AsyncNotifier<bool> {
  late AuthRepository _repo;

  @override
  Future<bool> build() async {
    _repo = ref.read(authRepositoryProvider);
    return _repo.isLoggedIn();
  }

  Future<void> login(
      String email,
      String pin,
      bool rememberMe,
      ) async {
    state = const AsyncLoading();

    final success =
    await _repo.login(email, pin, rememberMe);

    if (!success) {
      state = const AsyncError(
        'Invalid email or PIN',
        StackTrace.empty,
      );
      return;
    }

    state = const AsyncData(true);
  }

  Future<void> logout() async {
    state = const AsyncLoading();
    await _repo.logout();
    state = const AsyncData(false);
  }
}

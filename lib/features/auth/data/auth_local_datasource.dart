import 'package:habit_wallet_lite/core/services/secure_storage_service.dart';
import 'package:habit_wallet_lite/features/auth/domain/auth_repository.dart';


class AuthLocalRepository implements AuthRepository {
  final SecureStorageService storage;

  AuthLocalRepository(this.storage);

  /// LOGIN WITH VALIDATION
  @override
  Future<bool> login(String email, String pin, bool rememberMe) async {
    final storedAuth = await storage.getAuth();

    // FIRST TIME LOGIN → SAVE
    if (storedAuth == null) {
      await storage.saveAuth(
        email: email,
        pin: pin,
        rememberMe: rememberMe,
      );
      return true;
    }

    // VALIDATE LOGIN
    final isValid =
        storedAuth.email == email && storedAuth.pin == pin;

    if (!isValid) return false;

    // UPDATE REMEMBER ME
    await storage.saveAuth(
      email: email,
      pin: pin,
      rememberMe: rememberMe,
    );

    return true;
  }

  /// AUTO LOGIN CHECK
  @override
  Future<bool> isLoggedIn() {
    return storage.isLoggedIn();
  }

  /// LOGOUT
  @override
  Future<void> logout() {
    return storage.clear();
  }
}

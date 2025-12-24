import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StoredAuth {
  final String email;
  final String pin;
  final bool rememberMe;

  StoredAuth({
    required this.email,
    required this.pin,
    required this.rememberMe,
  });
}

class SecureStorageService {
  final _storage = const FlutterSecureStorage();

  static const _keyEmail = 'auth_email';
  static const _keyPin = 'auth_pin';
  static const _keyRemember = 'auth_remember';

  Future<void> saveAuth({
    required String email,
    required String pin,
    required bool rememberMe,
  }) async {
    await _storage.write(key: _keyEmail, value: email);
    await _storage.write(key: _keyPin, value: pin);
    await _storage.write(
      key: _keyRemember,
      value: rememberMe.toString(),
    );
  }

  Future<StoredAuth?> getAuth() async {
    final email = await _storage.read(key: _keyEmail);
    final pin = await _storage.read(key: _keyPin);
    final remember = await _storage.read(key: _keyRemember);

    if (email == null || pin == null || remember == null) {
      return null;
    }

    return StoredAuth(
      email: email,
      pin: pin,
      rememberMe: remember == 'true',
    );
  }

  Future<bool> isLoggedIn() async {
    final auth = await getAuth();
    return auth != null && auth.rememberMe;
  }

  Future<void> clear() async {
    await _storage.deleteAll();
  }

  Future<void> disableAutoLogin() async {
    await _storage.write(
      key: _keyRemember,
      value: 'false',
    );
  }
}

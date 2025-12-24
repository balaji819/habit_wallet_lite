abstract class AuthRepository {
  Future<bool> login(String email, String pin, bool rememberMe);
  Future<bool> isLoggedIn();
  Future<void> logout();
}

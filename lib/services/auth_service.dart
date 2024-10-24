class AuthService {
  static final AuthService _instance = AuthService._internal();

  factory AuthService() {
    return _instance;
  }

  AuthService._internal();

  String? currentUser;

  Future<bool> login(String username, String password) async {
    // Giả lập việc đăng nhập, có thể thay bằng API thực tế
    if (username == 'user' && password == 'password') {
      currentUser = username;
      return true;
    }
    return false;
  }

  Future<bool> register(String username, String password) async {
    // Giả lập việc đăng ký, có thể thay bằng API thực tế
    if (username.isNotEmpty && password.isNotEmpty) {
      currentUser = username;
      return true;
    }
    return false;
  }

  void logout() {
    currentUser = null;
  }

  bool isLoggedIn() {
    return currentUser != null;
  }
}

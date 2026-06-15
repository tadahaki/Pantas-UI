import '../models/user.dart';

// Stub for user service
// Will be implemented with actual API calls
class UserService {
  static final UserService _instance = UserService._internal();

  factory UserService() {
    return _instance;
  }

  UserService._internal();

  User? _currentUser;

  User? get currentUser => _currentUser;

  Future<User?> getCurrentUser() async {
    // TODO: Implement actual API call
    if (_currentUser != null) return _currentUser;
    await Future.delayed(const Duration(seconds: 1));
    return null;
  }

  Future<bool> updatePassword(String oldPassword, String newPassword) async {
    // TODO: Implement actual API call
    return true;
  }

  Future<bool> submitFeedback(String category, String message) async {
    // TODO: Implement actual API call
    return true;
  }

  void setCurrentUser(User user) {
    _currentUser = user;
  }
}

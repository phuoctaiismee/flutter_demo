import 'dart:async';

class AuthService {
  // Giả lập một database nhỏ trong bộ nhớ
  final List<Map<String, String>> _users = [
    {'email': 'test@example.com', 'password': '123456', 'name': 'Test User'},
    {'email': 'admin@example.com', 'password': '123456', 'name': 'Admin'},
    {'email': 'user@example.com', 'password': '123456', 'name': 'User'},
  ];

  // Giả lập API Login
  Future<Map<String, dynamic>> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2)); // Giả lập mạng chậm

    try {
      final user = _users.firstWhere(
        (u) => u['email'] == email && u['password'] == password,
      );
      return {'success': true, 'user': user};
    } catch (e) {
      return {
        'success': false,
        'message': 'Email hoặc mật khẩu không chính xác.',
      };
    }
  }

  // Giả lập API Register
  Future<Map<String, dynamic>> register(
    String name,
    String email,
    String password,
  ) async {
    await Future.delayed(const Duration(seconds: 2));

    if (_users.any((u) => u['email'] == email)) {
      return {'success': false, 'message': 'Email này đã được sử dụng.'};
    }

    final newUser = {'name': name, 'email': email, 'password': password};
    _users.add(newUser);
    return {'success': true, 'user': newUser};
  }
}

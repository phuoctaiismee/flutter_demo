import '../services/auth_service.dart';

class AuthRepository {
  final AuthService _authService;

  AuthRepository({AuthService? authService}) : _authService = authService ?? AuthService();

  Future<Map<String, dynamic>> login(String email, String password) async {
    // Thêm logic xử lý dữ liệu trước/sau khi gọi service nếu cần
    return await _authService.login(email, password);
  }

  Future<Map<String, dynamic>> register(String name, String email, String password) async {
    return await _authService.register(name, email, password);
  }
}

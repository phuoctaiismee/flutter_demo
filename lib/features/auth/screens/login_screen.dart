import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/components/ui/button.dart';
import '../../../core/components/ui/input.dart';
import '../../home/screens/home_screen.dart';
import 'register_screen.dart';
import '../data/repositories/auth_repository.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authRepository = AuthRepository(); // Use Repository
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final result = await _authRepository.login(
        _emailController.text,
        _passwordController.text,
      );

      if (mounted) {
        setState(() => _isLoading = false);
        if (result['success']) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  HomeScreen(userName: result['user']['name']),
            ),
          );
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(result['message'])));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                Text('Chào mừng trở lại', style: theme.textTheme.headlineLarge),
                const SizedBox(height: 8),
                Text(
                  'Đăng nhập để tiếp tục trải nghiệm',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 48),
                AppInput(
                  label: 'Email',
                  placeholder: 'name@example.com',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icon(
                    PhosphorIcons.mailbox(PhosphorIconsStyle.regular),

                    size: 20,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Vui lòng nhập email';
                    if (!value.contains('@')) return 'Email không hợp lệ';
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                AppInput(
                  label: 'Mật khẩu',
                  placeholder: '••••••••',
                  controller: _passwordController,
                  isPassword: true,
                  prefixIcon: Icon(
                    PhosphorIcons.lock(PhosphorIconsStyle.regular),
                    size: 20,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Vui lòng nhập mật khẩu';
                    if (value.length < 6) return 'Mật khẩu phải từ 6 ký tự';
                    return null;
                  },
                ),
                const SizedBox(height: 40),
                AppButton(
                  text: 'Đăng nhập',
                  isFullWidth: true,
                  onPressed: _handleLogin,
                  isLoading: _isLoading,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Chưa có tài khoản? ',
                      style: theme.textTheme.bodyMedium,
                    ),
                    AppButton(
                      text: 'Đăng ký ngay',
                      variant: ButtonVariant.link,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

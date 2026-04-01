import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/components/ui/button.dart';
import '../../../core/components/ui/input.dart';
import '../data/repositories/auth_repository.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authRepository = AuthRepository();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final result = await _authRepository.register(
        _nameController.text,
        _emailController.text,
        _passwordController.text,
      );

      if (mounted) {
        setState(() => _isLoading = false);
        if (result['success']) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Đăng ký thành công! Đăng nhập để tiếp tục.'),
            ),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
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
      appBar: AppBar(title: const Text('Đăng ký tài khoản')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text('Tạo tài khoản mới', style: theme.textTheme.headlineLarge),
                const SizedBox(height: 48),
                AppInput(
                  label: 'Tên đầy đủ',
                  placeholder: 'Nguyễn Văn A',
                  controller: _nameController,
                  prefixIcon: Icon(
                    PhosphorIcons.user(PhosphorIconsStyle.regular),
                    color: theme.colorScheme.surface,
                    size: 20,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Vui lòng nhập tên';
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                AppInput(
                  label: 'Email',
                  placeholder: 'name@example.com',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icon(
                    PhosphorIcons.mailbox(PhosphorIconsStyle.regular),
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
                  text: 'Đăng ký',
                  isFullWidth: true,
                  onPressed: _handleRegister,
                  isLoading: _isLoading,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Đã có tài khoản? ',
                      style: theme.textTheme.bodyMedium,
                    ),
                    AppButton(
                      text: 'Đăng nhập',
                      variant: ButtonVariant.link,
                      onPressed: () {
                        Navigator.pop(context);
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

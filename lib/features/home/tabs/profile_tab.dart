import 'package:flutter/material.dart';
import '../../../core/components/ui/button.dart';
import '../../auth/screens/login_screen.dart';

class ProfileTab extends StatelessWidget {
  final String userName;

  const ProfileTab({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hồ sơ'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 120),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://api.dicebear.com/7.x/avataaars/png?seed=Felix'),
            ),
            const SizedBox(height: 16),
            Text(
              userName,
              style: theme.textTheme.headlineMedium,
            ),
            Text(
              'Developer',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.5),
              ),
            ),
            const SizedBox(height: 32),
            _buildProfileItem(context, Icons.person_outline, 'Thông tin cá nhân'),
            const SizedBox(height: 12),
            _buildProfileItem(context, Icons.security_outlined, 'Bảo mật'),
            const SizedBox(height: 12),
            _buildProfileItem(context, Icons.language_outlined, 'Ngôn ngữ'),
            const SizedBox(height: 12),
            _buildProfileItem(context, Icons.help_outline, 'Hỗ trợ'),
            const SizedBox(height: 48),
            AppButton(
              text: 'Đăng xuất',
              variant: ButtonVariant.destructive,
              isFullWidth: true,
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(BuildContext context, IconData icon, String title) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            border: Border.all(color: theme.colorScheme.outline.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(icon, size: 24, color: theme.colorScheme.primary),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.titleMedium,
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: 20,
                color: theme.colorScheme.onSurface.withOpacity(0.3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

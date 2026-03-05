import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_strings.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_textfield.dart';
import '../providers/auth_provider.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextField(
          controller: _emailController,
          label: AppStrings.email,
        ),
        const SizedBox(height: 16),
        AppTextField(
          controller: _passwordController,
          label: AppStrings.password,
          obscureText: true,
        ),
        const SizedBox(height: 24),
        AppButton(
          text: AppStrings.login,
          onPressed: () {
            ref.read(authProvider.notifier).signIn(
              _emailController.text,
              _passwordController.text,
            );
          },
        ),
      ],
    );
  }
}

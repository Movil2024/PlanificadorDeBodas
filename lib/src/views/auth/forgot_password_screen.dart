// lib/src/views/auth/forgot_password_screen.dart

import 'package:flutter/material.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/constants.dart';
import '../../config/routes.dart';
import '../../widgets/common/custom_text_field.dart';
import '../../widgets/common/custom_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _authController = AuthController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await _authController.resetPassword(_emailController.text.trim());

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(AppConstants.successPasswordReset),
            backgroundColor: Colors.green,
          ),
        );
        AppNavigator.logoutToLogin(context); // Nuevo método de navegación
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _navigateBack() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.resetPassword),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).primaryColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                // Ícono
                Icon(
                  Icons.lock_reset,
                  size: 80,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(height: 24),

                // Texto explicativo
                Text(
                  'Ingresa tu correo electrónico y te enviaremos las instrucciones para restablecer tu contraseña.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 32),

                // Campo de email
                CustomTextField(
                  controller: _emailController,
                  label: 'Email',
                  hint: 'Ingresa tu correo electrónico',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _resetPassword(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppConstants.errorEmailEmpty;
                    }
                    if (!RegExp(AppConstants.emailRegex).hasMatch(value)) {
                      return AppConstants.errorEmailInvalid;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),

                // Botón de enviar
                CustomButton(
                  text: AppConstants.sendInstructions,
                  onPressed: _resetPassword,
                  isLoading: _isLoading,
                ),
                const SizedBox(height: 16),

                // Botón para volver
                CustomButton(
                  text: AppConstants.backToLogin,
                  onPressed: () => Navigator.pop(context),
                  isOutlined: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
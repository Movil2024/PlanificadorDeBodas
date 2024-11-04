// lib/src/views/auth/login_screen.dart

import 'package:flutter/material.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/constants.dart';
import '../../config/routes.dart';
import '../../widgets/common/custom_text_field.dart';
import '../../widgets/common/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authController = AuthController();
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await _authController.signIn(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (mounted) {
        AppNavigator.navigateToDashboard(context);
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

  void _navigateToForgotPassword() {
    AppNavigator.pushNamed(context, AppConstants.routeForgotPassword);
  }

  void _navigateToRegister() {
    AppNavigator.pushNamed(context, AppConstants.routeRegister);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                // Logo
                Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.favorite,
                      size: 50,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Título
                Text(
                  AppConstants.appName,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 40),
                // Email
                CustomTextField(
                  controller: _emailController,
                  label: 'Email',
                  hint: 'ejemplo@email.com',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
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
                const SizedBox(height: 16),
                // Contraseña
                CustomTextField(
                  controller: _passwordController,
                  label: 'Contraseña',
                  obscureText: !_isPasswordVisible,
                  prefixIcon: Icons.lock_outline,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _signIn(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppConstants.errorPasswordEmpty;
                    }
                    if (value.length < AppConstants.passwordMinLength) {
                      return AppConstants.errorPasswordLength;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                // Olvidé mi contraseña
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: _navigateToForgotPassword,
                    child: const Text(AppConstants.forgotPassword),
                  ),
                ),
                const SizedBox(height: 24),
                // Botón de inicio de sesión
                CustomButton(
                  text: AppConstants.login,
                  onPressed: _signIn,
                  isLoading: _isLoading,
                ),
                const SizedBox(height: 16),
                // Registro
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppConstants.noAccount,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: _navigateToRegister,
                      child: const Text(AppConstants.register),
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
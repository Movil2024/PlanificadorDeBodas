// lib/src/views/auth/register_screen.dart

import 'package:flutter/material.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/constants.dart';
import '../../config/routes.dart';
import '../../widgets/common/custom_text_field.dart';
import '../../widgets/common/custom_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _authController = AuthController();
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await _authController.register(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(AppConstants.successRegistration),
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
        title: const Text('Registro'),
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
                // Nombre
                CustomTextField(
                  controller: _nameController,
                  label: 'Nombre completo',
                  hint: 'Ingresa tu nombre',
                  prefixIcon: Icons.person_outline,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppConstants.errorNameEmpty;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

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
                  hint: 'Ingresa tu contraseña',
                  obscureText: !_isPasswordVisible,
                  prefixIcon: Icons.lock_outline,
                  textInputAction: TextInputAction.next,
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
                const SizedBox(height: 16),

                // Confirmar Contraseña
                CustomTextField(
                  controller: _confirmPasswordController,
                  label: 'Confirmar contraseña',
                  hint: 'Confirma tu contraseña',
                  obscureText: !_isConfirmPasswordVisible,
                  prefixIcon: Icons.lock_outline,
                  textInputAction: TextInputAction.done,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isConfirmPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppConstants.errorPasswordEmpty;
                    }
                    if (value != _passwordController.text) {
                      return AppConstants.errorPasswordMatch;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),

                // Botón de registro
                CustomButton(
                  text: AppConstants.register,
                  onPressed: _register,
                  isLoading: _isLoading,
                ),
                const SizedBox(height: 16),

                // Volver a login
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
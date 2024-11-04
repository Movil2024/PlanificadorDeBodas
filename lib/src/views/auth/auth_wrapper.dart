// lib/src/views/auth/auth_wrapper.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../utils/constants.dart';
import '../../config/routes.dart';
import '../../widgets/common/loading_indicator.dart';
//import '../dashboard/dashboard_screen.dart';
import 'login_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: LoadingIndicator(),
            ),
          );
        }

        // Si hay un usuario autenticado, redirigir al dashboard
        if (snapshot.hasData) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            AppNavigator.navigateToDashboard(context);
          });
        }

        // Por defecto, mostrar la pantalla de login
        return const LoginScreen();
      },
    );
  }
}
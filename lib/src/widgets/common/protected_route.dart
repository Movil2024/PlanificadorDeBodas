// lib/src/widgets/common/protected_route.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../utils/constants.dart';
import '../../config/routes.dart';

class ProtectedRoute extends StatelessWidget {
  final Widget child;

  const ProtectedRoute({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (!snapshot.hasData) {
          // Si no hay usuario autenticado, redirigir al login
          WidgetsBinding.instance.addPostFrameCallback((_) {
            AppNavigator.logoutToLogin(context);
          });

          // Mientras se redirige, mostrar una pantalla de carga
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // Si hay usuario autenticado, mostrar la ruta protegida
        return child;
      },
    );
  }
}
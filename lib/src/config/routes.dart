// lib/src/config/routes.dart

import "package:flutter/material.dart";
import '../utils/constants.dart';
import '../views/auth/auth_wrapper.dart';
import '../views/auth/login_screen.dart';
import '../views/auth/register_screen.dart';
import '../views/auth/forgot_password_screen.dart';
//import '../views/dashboard/dashboard_screen.dart';

class AppRoutes {
  // Ruta inicial de la aplicación
  static const String initialRoute = '/';

  // Definición de rutas nombradas
  static final Map<String, WidgetBuilder> routes = {
    initialRoute: (context) => const AuthWrapper(),
    AppConstants.routeLogin: (context) => const LoginScreen(),
    AppConstants.routeRegister: (context) => const RegisterScreen(),
    AppConstants.routeForgotPassword: (context) => const ForgotPasswordScreen(),
    //AppConstants.routeDashboard: (context) => const DashboardScreen(),
  };

  // Manejador de rutas desconocidas
  static Route<dynamic>? onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Página no encontrada'),
        ),
      ),
    );
  }

  // Manejador de transiciones de página
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final WidgetBuilder? builder = routes[settings.name];

    if (builder != null) {
      return MaterialPageRoute(
        builder: builder,
        settings: settings,
      );
    }

    return null;
  }
}

// Navegador personalizado para manejar transiciones y argumentos
class AppNavigator {
  static Future<T?> pushNamed<T extends Object?>(
      BuildContext context,
      String routeName, {
        Object? arguments,
      }) {
    return Navigator.of(context).pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  static Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
      BuildContext context,
      String routeName, {
        Object? arguments,
        TO? result,
      }) {
    return Navigator.of(context).pushReplacementNamed(
      routeName,
      arguments: arguments,
      result: result,
    );
  }

  static Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
      BuildContext context,
      String newRouteName,
      RoutePredicate predicate, {
        Object? arguments,
      }) {
    return Navigator.of(context).pushNamedAndRemoveUntil(
      newRouteName,
      predicate,
      arguments: arguments,
    );
  }

  // Método para navegar al dashboard y limpiar el stack
  static void navigateToDashboard(BuildContext context) {
    pushNamedAndRemoveUntil(
      context,
      AppConstants.routeDashboard,
          (route) => false,
    );
  }

  // Método para cerrar sesión y volver al login
  static void logoutToLogin(BuildContext context) {
    pushNamedAndRemoveUntil(
      context,
      AppConstants.routeLogin,
          (route) => false,
    );
  }
}
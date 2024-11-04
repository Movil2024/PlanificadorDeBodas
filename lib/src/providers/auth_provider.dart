// lib/src/providers/auth_provider.dart

import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/notification_service.dart';
import '../utils/firebase_error_handler.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  bool _isLoading = false;

  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user != null;

  AuthProvider() {
    _init();
  }

  void _init() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<bool> signIn(
      BuildContext context, {
        required String email,
        required String password,
      }) async {
    try {
      _setLoading(true);
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = userCredential.user;
      NotificationService.showSuccess(context, 'Inicio de sesión exitoso');
      return true;
    } catch (e) {
      NotificationService.showError(
        context,
        FirebaseErrorHandler.handleAuthError(e),
      );
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> signUp(
      BuildContext context, {
        required String email,
        required String password,
        required String name,
      }) async {
    try {
      _setLoading(true);
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = userCredential.user;
      await _user?.updateDisplayName(name);
      NotificationService.showSuccess(context, 'Registro exitoso');
      return true;
    } catch (e) {
      NotificationService.showError(
        context,
        FirebaseErrorHandler.handleAuthError(e),
      );
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      NotificationService.showInfo(context, 'Sesión cerrada');
    } catch (e) {
      NotificationService.showError(
        context,
        FirebaseErrorHandler.handleAuthError(e),
      );
    }
  }

  Future<bool> resetPassword(BuildContext context, String email) async {
    try {
      _setLoading(true);
      await _auth.sendPasswordResetEmail(email: email);
      NotificationService.showSuccess(
        context,
        'Se ha enviado un correo para restablecer tu contraseña',
      );
      return true;
    } catch (e) {
      NotificationService.showError(
        context,
        FirebaseErrorHandler.handleAuthError(e),
      );
      return false;
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
// lib/src/utils/firebase_error_handler.dart

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseErrorHandler {
  static String handleAuthError(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'user-not-found':
          return 'No existe una cuenta con este correo electrónico';
        case 'wrong-password':
          return 'Contraseña incorrecta';
        case 'email-already-in-use':
          return 'Ya existe una cuenta con este correo electrónico';
        case 'weak-password':
          return 'La contraseña es muy débil';
        case 'invalid-email':
          return 'El correo electrónico no es válido';
        case 'user-disabled':
          return 'Esta cuenta ha sido deshabilitada';
        case 'operation-not-allowed':
          return 'Operación no permitida';
        case 'too-many-requests':
          return 'Demasiados intentos fallidos. Por favor, intenta más tarde';
        case 'network-request-failed':
          return 'Error de conexión. Verifica tu conexión a internet';
        case 'invalid-credential':
          return 'Las credenciales proporcionadas son inválidas';
        case 'account-exists-with-different-credential':
          return 'Ya existe una cuenta con el mismo correo electrónico pero con diferente método de inicio de sesión';
        case 'requires-recent-login':
          return 'Esta operación es sensible y requiere autenticación reciente. Inicia sesión nuevamente.';
        case 'provider-already-linked':
          return 'La cuenta ya está vinculada con otro proveedor';
        case 'credential-already-in-use':
          return 'Las credenciales ya están asociadas a otra cuenta';
        case 'email-already-in-use':
          return 'El correo electrónico ya está en uso por otra cuenta';
        default:
          return 'Error de autenticación: ${error.message}';
      }
    }
    return 'Error inesperado: $error';
  }

  // Puedes agregar más métodos para manejar otros tipos de errores de Firebase
  static String handleFirestoreError(dynamic error) {
    if (error is FirebaseException) {
      switch (error.code) {
        case 'permission-denied':
          return 'No tienes permisos para realizar esta operación';
        case 'not-found':
          return 'El documento solicitado no existe';
        case 'already-exists':
          return 'El documento ya existe';
        case 'failed-precondition':
          return 'La operación fue rechazada porque el sistema no está en el estado requerido';
        case 'aborted':
          return 'La operación fue abortada';
        case 'out-of-range':
          return 'La operación fue intentada más allá del rango válido';
        case 'unavailable':
          return 'El servicio no está disponible temporalmente';
        case 'data-loss':
          return 'Se perdieron o dañaron datos irrecuperables';
        default:
          return 'Error en Firestore: ${error.message}';
      }
    }
    return 'Error inesperado: $error';
  }
}
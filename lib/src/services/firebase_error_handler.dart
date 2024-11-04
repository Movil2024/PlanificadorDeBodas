// lib/src/utils/firebase_error_handler.dart

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
        default:
          return 'Error de autenticación: ${error.message}';
      }
    }
    return 'Error inesperado: $error';
  }
}
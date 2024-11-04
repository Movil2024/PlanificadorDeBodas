// lib/src/utils/constants.dart

class AppConstants {
  // Rutas de navegación
  static const String routeLogin = '/login';
  static const String routeRegister = '/register';
  static const String routeForgotPassword = '/forgot-password';
  static const String routeDashboard = '/dashboard';

  // Validación
  static const String emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static const int passwordMinLength = 6;

  // Mensajes de error
  static const String errorEmailEmpty = 'Por favor ingresa tu email';
  static const String errorEmailInvalid = 'Por favor ingresa un email válido';
  static const String errorPasswordEmpty = 'Por favor ingresa tu contraseña';
  static const String errorPasswordLength = 'La contraseña debe tener al menos 6 caracteres';
  static const String errorPasswordMatch = 'Las contraseñas no coinciden';
  static const String errorNameEmpty = 'Por favor ingresa tu nombre';

  // Mensajes de éxito
  static const String successPasswordReset = 'Se ha enviado un correo para restablecer tu contraseña';
  static const String successRegistration = 'Registro exitoso. Por favor inicia sesión.';

  // Textos de UI
  static const String appName = 'Wedding Planner';
  static const String login = 'Iniciar Sesión';
  static const String register = 'Registrarse';
  static const String forgotPassword = '¿Olvidaste tu contraseña?';
  static const String noAccount = '¿No tienes una cuenta?';
  static const String resetPassword = 'Recuperar Contraseña';
  static const String sendInstructions = 'Enviar Instrucciones';
  static const String backToLogin = 'Volver al inicio de sesión';
}
// test/widget_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:planificador_bodas/main.dart';
import 'package:planificador_bodas/src/providers/auth_provider.dart';
import 'package:planificador_bodas/src/views/auth/login_screen.dart';
import 'package:planificador_bodas/src/utils/constants.dart';

void main() {
  group('App Widget Tests', () {
    testWidgets('App should start with LoginScreen', (WidgetTester tester) async {
      // Construir la app con el Provider necesario
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
          child: const MyApp(),
        ),
      );

      // Verificar que estamos en la pantalla de login
      expect(find.byType(LoginScreen), findsOneWidget);
      expect(find.text(AppConstants.appName), findsOneWidget);
    });

    testWidgets('Login screen should have email and password fields',
            (WidgetTester tester) async {
          await tester.pumpWidget(
            ChangeNotifierProvider(
              create: (_) => AuthProvider(),
              child: const MaterialApp(home: LoginScreen()),
            ),
          );

          // Verificar campos de login
          expect(find.byType(TextFormField), findsNWidgets(2));
          expect(find.text('Email'), findsOneWidget);
          expect(find.text('Contraseña'), findsOneWidget);
        });

    testWidgets('Login screen should have login and register buttons',
            (WidgetTester tester) async {
          await tester.pumpWidget(
            ChangeNotifierProvider(
              create: (_) => AuthProvider(),
              child: const MaterialApp(home: LoginScreen()),
            ),
          );

          // Verificar botones
          expect(find.text(AppConstants.login), findsOneWidget);
          expect(find.text(AppConstants.register), findsOneWidget);
        });

    testWidgets('Email validation should work', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
          child: const MaterialApp(home: LoginScreen()),
        ),
      );

      // Encontrar el campo de email
      final emailField = find.byType(TextFormField).first;

      // Ingresar un email inválido
      await tester.enterText(emailField, 'invalid-email');
      await tester.pump();

      // Intentar hacer login
      await tester.tap(find.text(AppConstants.login));
      await tester.pump();

      // Verificar mensaje de error
      expect(find.text(AppConstants.errorEmailInvalid), findsOneWidget);
    });

    testWidgets('Password validation should work', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
          child: const MaterialApp(home: LoginScreen()),
        ),
      );

      // Encontrar el campo de contraseña
      final passwordField = find.byType(TextFormField).last;

      // Ingresar una contraseña muy corta
      await tester.enterText(passwordField, '123');
      await tester.pump();

      // Intentar hacer login
      await tester.tap(find.text(AppConstants.login));
      await tester.pump();

      // Verificar mensaje de error
      expect(find.text(AppConstants.errorPasswordLength), findsOneWidget);
    });

    testWidgets('Should show forgot password button',
            (WidgetTester tester) async {
          await tester.pumpWidget(
            ChangeNotifierProvider(
              create: (_) => AuthProvider(),
              child: const MaterialApp(home: LoginScreen()),
            ),
          );

          expect(find.text(AppConstants.forgotPassword), findsOneWidget);
        });
  });

  group('Navigation Tests', () {
    testWidgets('Should navigate to register screen when register is tapped',
            (WidgetTester tester) async {
          await tester.pumpWidget(
            ChangeNotifierProvider(
              create: (_) => AuthProvider(),
              child: const MaterialApp(home: LoginScreen()),
            ),
          );

          await tester.tap(find.text(AppConstants.register));
          await tester.pumpAndSettle();

          // Verificar que estamos en la pantalla de registro
          expect(find.text('Registro'), findsOneWidget);
        });

    testWidgets('Should navigate to forgot password screen when forgot password is tapped',
            (WidgetTester tester) async {
          await tester.pumpWidget(
            ChangeNotifierProvider(
              create: (_) => AuthProvider(),
              child: const MaterialApp(home: LoginScreen()),
            ),
          );

          await tester.tap(find.text(AppConstants.forgotPassword));
          await tester.pumpAndSettle();

          // Verificar que estamos en la pantalla de recuperación de contraseña
          expect(find.text(AppConstants.resetPassword), findsOneWidget);
        });
  });
}
import 'package:flutter/material.dart';
import 'package:frontend/features/authentication/presentation/forgot_password_screen.dart';
import 'package:frontend/features/authentication/presentation/login_screen.dart';
import 'package:frontend/features/authentication/presentation/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
      routes: {
        "/auth/register": (context) => const RegisterPage(),
        "/auth/forgot-password": (context) => const ForgotPasswordPage(),
      },
    );
  }
}

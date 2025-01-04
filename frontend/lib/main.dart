import 'package:flutter/material.dart';
import 'package:frontend/features/authentication/presentation/login_screen.dart';
import 'package:frontend/features/authentication/presentation/forgot_password_screen.dart';
import 'package:frontend/features/authentication/presentation/register_screen.dart';
import 'package:frontend/features/authentication/presentation/reset_password_page.dart';
import 'package:frontend/features/authentication/presentation/verification_code_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Ẩn thanh debug banner
      routes: {
        '/': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/forgot-password': (context) => ForgotPasswordPage(),
        '/verification-code': (context) => VerificationCodePage(),
        '/reset-password': (context) => ResetPasswordPage(),
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:frontend/features/authentication/presentation/forgot_password_screen.dart';
import 'package:frontend/features/authentication/presentation/login_screen.dart';
<<<<<<< HEAD
<<<<<<< HEAD
import 'package:frontend/features/authentication/presentation/forget_pasword_screen.dart';
import 'package:frontend/features/authentication/presentation/register_screen.dart';
import 'package:frontend/features/authentication/presentation/verification_code_page.dart';
import 'package:frontend/features/authentication/presentation/reset_password_page.dart';
=======
import 'package:frontend/features/authentication/presentation/register_screen.dart';
>>>>>>> 9d667fef94d2a779ea928ab779f8f13ce865d856
=======
import 'package:frontend/features/authentication/presentation/register_screen.dart';
>>>>>>> 9d667fef94d2a779ea928ab779f8f13ce865d856

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< HEAD
<<<<<<< HEAD
      debugShowCheckedModeBanner: false, // Ẩn thanh debug banner
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/forgotPassword': (context) => ForgotPasswordPage(),
        '/verification-code': (context) => VerificationCodePage(),
        '/reset-password': (context) => ResetPasswordPage(),
=======
=======
>>>>>>> 9d667fef94d2a779ea928ab779f8f13ce865d856
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
      routes: {
        "/auth/register": (context) => const RegisterPage(),
        "/auth/forgot-password": (context) => const ForgotPasswordPage(),
<<<<<<< HEAD
>>>>>>> 9d667fef94d2a779ea928ab779f8f13ce865d856
=======
>>>>>>> 9d667fef94d2a779ea928ab779f8f13ce865d856
      },
    );
  }
}

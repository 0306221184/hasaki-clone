import 'package:flutter/material.dart';
import 'package:frontend/features/authentication/presentation/login_screen.dart';
import 'package:frontend/features/authentication/presentation/forgot_password_screen.dart';
import 'package:frontend/features/authentication/presentation/register_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Ẩn thanh debug banner
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/forgotPassword': (context) => ForgotPasswordPage(),
      },
    );
  }
}

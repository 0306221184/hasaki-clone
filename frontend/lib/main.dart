import 'package:flutter/material.dart';
import 'package:frontend/features/authentication/presentation/login_screen.dart';
import 'package:frontend/features/notification/presentation/notification_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Ẩn thanh debug banner
      home: NotificationScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/category': (context) => CategoryScreen(),
        '/cart': (context) => CartScreen(),
        '/profile': (context) => ProfileScreen(),
      },
    );
  }
}

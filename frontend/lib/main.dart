import 'package:flutter/material.dart';
import 'package:frontend/features/authentication/presentation/login_screen.dart';
import 'features/category/presentation/category_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  const CategoryScreen(),
    );
  }
}

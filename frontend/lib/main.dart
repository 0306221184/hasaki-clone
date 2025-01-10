import 'package:flutter/material.dart';
import 'package:frontend/features/authentication/presentation/login_screen.dart';
import 'package:frontend/features/cart/presentation/cartaddress/cart_address.dart';
import 'package:frontend/features/cart/presentation/cartconfirm/cart_confirm.dart';
import 'package:frontend/features/cart/presentation/cartdiscount/cart_discount.dart';
import 'package:frontend/features/cart/presentation/cartpay/cart_pay.dart';
import 'package:frontend/features/cart/presentation/cart/cart_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CartScreen(),
    );
  }
}

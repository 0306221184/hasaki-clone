import 'package:flutter/material.dart';
import 'package:frontend/features/account/favoriteproduct/FavoriteProduct.dart';
import 'package:frontend/features/account/newproduct/newproductScreen.dart';
import 'package:frontend/features/account/order/orderScreen.dart';
import 'package:frontend/features/account/review/reviewscreen.dart';
import 'package:frontend/features/account/trademark/productTrademark.dart';
import 'package:frontend/features/account/voucher/voucherScreen.dart';
import 'package:frontend/features/authentication/presentation/login_screen.dart';
import 'package:frontend/features/notification/presentation/notification_screen.dart';
import 'features/account/changepassword/changePasswordScreen.dart';
import 'features/account/location/locationScreen.dart';
import 'features/account/location/test.dart';
import 'features/account/presentation/account_screen.dart';
import 'features/account/proFile/profileScreen.dart';
import 'features/account/trademark/trademarkscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Ẩn thanh debug banner
      home: AccountScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/category': (context) => CategoryScreen(),
        '/cart': (context) => CartScreen(),
        '/favorite': (context) => FavoriteProductScreen(),
        '/review': (context) => ReviewScreen(),
        '/profile': (context) => ProfileScreen(),
        '/accout': (context)=> AccountScreen(),
        '/order': (context)=>OrderScreen(),
        '/location': (context)=>LocationSelectionScreen(),
        '/info': (context)=>AccountInfoScreen(),
        '/changePass': (context)=>ChangePasswordScreen(),
        '/trademark': (context)=>BrandScreen(),
        '/voucher': (context)=>VoucherScreen(),
        '/newproduct': (context)=>ProductGridScreen(),
        '/update':(context)=>AddressUpdater(),
      },
    );
  }
}
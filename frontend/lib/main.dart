import 'package:flutter/material.dart';
import 'package:frontend/features/account/favoriteproduct/FavoriteProduct.dart';
import 'package:frontend/features/account/newproduct/newproductScreen.dart';
import 'package:frontend/features/account/order/orderScreen.dart';
import 'package:frontend/features/account/review/reviewscreen.dart';
import 'package:frontend/features/account/voucher/voucherScreen.dart';
import 'package:frontend/features/authentication/presentation/forgot_password_screen.dart';
import 'package:frontend/features/authentication/presentation/login_screen.dart';
import 'package:frontend/features/authentication/presentation/register_screen.dart';
import 'package:frontend/features/authentication/presentation/reset_password_page.dart';
import 'package:frontend/features/authentication/presentation/verification_code_page.dart';
import 'package:frontend/features/category/presentation/category_screen.dart';
import 'package:frontend/features/home/presentation/home_screen.dart';
import 'package:frontend/features/notification/presentation/notification_screen.dart';
import 'package:frontend/features/cart/presentation/cart/cart_screen.dart';
import 'features/account/changepassword/changePasswordScreen.dart';
import 'features/account/location/locationScreen.dart';
import 'features/account/presentation/account_screen.dart';
import 'features/account/proFile/profileScreen.dart';
import 'features/account/trademark/trademarkscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Ẩn thanh debug banner
      home: HomeScreen(),
      routes: {
        '/account': (context) => AccountScreen(),
        '/category': (context) => CategoryScreen(),
        '/cart': (context) => CartScreen(),
        '/favorite': (context) => FavoriteProductScreen(),
        '/review': (context) => ReviewScreen(),
        '/profile': (context) => AccountInfoScreen(),
        '/order': (context) => OrderScreen(),
        '/location': (context) => LocationSelectionScreen(),
        '/info': (context) => AccountInfoScreen(),
        '/changePass': (context) => ChangePasswordScreen(),
        '/trademark': (context) => BrandScreen(),
        '/voucher': (context) => VoucherScreen(),
        '/newproduct': (context) => ProductGridScreen(),
        '/notification': (context) => NotificationScreen(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/forgot-password': (context) => ForgotPasswordPage(),
        '/reset-password': (context) => ResetPasswordPage(),
        '/verification-code': (context) => VerificationCodePage(),
      },
    );
  }
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  bool isLoggedIn = true;
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  void checkLoginStatus() {
    // TODO: Thêm logic kiểm tra đăng nhập thực tế ở đây
    if (!isLoggedIn) {
      // Nếu chưa đăng nhập, chuyển đến trang đăng nhập
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacementNamed(context, '/login');
      });
    }
  }

  static List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const CategoryScreen(),
    CartScreen(),
    NotificationScreen(),
    AccountScreen(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
            BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Danh mục'),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Giỏ hàng'),
            BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Thông báo'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Tài khoản'),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black54,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          selectedLabelStyle: TextStyle(color: Colors.blue),
          unselectedLabelStyle: TextStyle(color: Colors.black54),
          selectedIconTheme: IconThemeData(
            color: Colors.blue,
            size: 30, // Kích thước biểu tượng khi được chọn
          ),
          unselectedIconTheme: IconThemeData(
            color: Colors.black54,
            size: 24, // Kích thước biểu tượng khi không được chọn
          ),
        ),
      ),
    );
  }
}

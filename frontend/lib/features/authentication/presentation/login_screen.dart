import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:frontend/features/authentication/presentation/register_screen.dart';
import 'package:frontend/features/authentication/presentation/forget_pasword_screen.dart';
=======
import 'register_screen.dart';
import 'forgot_password_screen.dart';
<<<<<<< HEAD
>>>>>>> 9d667fef94d2a779ea928ab779f8f13ce865d856
=======
>>>>>>> 9d667fef94d2a779ea928ab779f8f13ce865d856

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập email';
    }

    final RegExp emailRegex =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    if (!emailRegex.hasMatch(value)) {
      return 'Vui lòng nhập email hợp lệ';
    }

    if (value.length < 5) {
      return 'Email phải có ít nhất 5 ký tự';
    }

    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mật khẩu không được để trống';
    }
    if (value.length < 6 || value.length > 32) {
      return 'Mật khẩu phải từ 6 đến 32 ký tự';
    }
    return null;
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _showDialog('Đăng nhập thành công', Colors.white);

      // Reset tất cả thông tin sau khi đăng nhập thành công
      _emailController.clear();
      _passwordController.clear();
      _formKey.currentState!.reset();

      // Điều hướng tới trang chủ
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/home', // Route tới trang Home
        (Route<dynamic> route) => false, // Loại bỏ tất cả các route trước đó
      );
    } else {
      _showDialog(
        'Vui lòng điền đầy đủ thông tin và kiểm tra lại',
        Colors.white,
      );
    }
  }

  void _showDialog(String message, Color color) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thông báo'),
          content: Text(message),
          backgroundColor: color,
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Center(
          child: Text(
            'Đăng Nhập',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: size.width * 0.50,
                height: size.width * 0.40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.asset('assets/Logo_doria.jpg', fit: BoxFit.cover),
              ),
              const SizedBox(height: 15),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.g_mobiledata),
                label: const Text('Đăng nhập bằng Google'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Hoặc tài khoản Dolia.vn',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      validator: _validateEmail,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      validator: _validatePassword,
                      decoration: InputDecoration(
                        hintText: 'Mật khẩu',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
<<<<<<< HEAD
<<<<<<< HEAD
                          Navigator.pushNamed(context, '/forgotPassword');
=======
                          Navigator.pushNamedAndRemoveUntil(context,
                              '/auth/forgot-password', (route) => true);
>>>>>>> 9d667fef94d2a779ea928ab779f8f13ce865d856
=======
                          Navigator.pushNamedAndRemoveUntil(context,
                              '/auth/forgot-password', (route) => true);
>>>>>>> 9d667fef94d2a779ea928ab779f8f13ce865d856
                        },
                        child: const Text(
                          'Quên mật khẩu?',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'ĐĂNG NHẬP',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
<<<<<<< HEAD
                        Navigator.pushNamed(context, '/register');
=======
                        // Điều hướng sang trang đăng ký
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          "/auth/register",
                          (route) => true,
                        );
>>>>>>> 9d667fef94d2a779ea928ab779f8f13ce865d856
                      },
                      child: const Text(
                        'Bạn chưa có tài khoản đăng nhập? Đăng ký',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

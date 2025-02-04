import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../core/providers/auth_provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.loadUser();
    if (authProvider.currentUser == null) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }

  Future<void> _changePassword() async {
    if (_oldPasswordController.text.isNotEmpty &&
        _newPasswordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty) {
      // Kiểm tra mật khẩu mới và xác nhận mật khẩu khớp nhau
      if (_newPasswordController.text == _confirmPasswordController.text) {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        final token = authProvider.currentUser;  // Lấy token người dùng từ AuthProvider

        if (token != null) {
          try {
            final response = await http.put(
              Uri.parse('http://localhost:3000/api/v1/auth/users'), // Đảm bảo URL đúng
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $token',  // Gửi token trong header
              },
              body: jsonEncode({
                'oldPassword': _oldPasswordController.text,
                'newPassword': _newPasswordController.text,
              }),
            );

            if (response.statusCode == 200) {
              // Mật khẩu đổi thành công
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Thông báo'),
                    content: Text('Đổi mật khẩu thành công'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Đóng'),
                      ),
                    ],
                  );
                },
              );
            } else {
              // Nếu server trả về lỗi, hiển thị thông báo thất bại
              final responseData = jsonDecode(response.body);
              String errorMessage = responseData['message'] ?? 'Đổi mật khẩu thất bại. Vui lòng thử lại.';
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Thông báo'),
                    content: Text(errorMessage),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Đóng'),
                      ),
                    ],
                  );
                },
              );
            }
          } catch (e) {
            // Xử lý lỗi nếu có
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Thông báo'),
                  content: Text('Đã xảy ra lỗi khi kết nối với server. Vui lòng thử lại.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Đóng'),
                    ),
                  ],
                );
              },
            );
          }
        } else {
          Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
        }
      } else {
        // Mật khẩu mới và xác nhận không khớp
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Thông báo'),
              content: Text('Mật khẩu mới không khớp'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Đóng'),
                ),
              ],
            );
          },
        );
      }
    } else {
      // Kiểm tra nếu có trường nào còn thiếu
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Thông báo'),
            content: Text('Vui lòng nhập đầy đủ thông tin'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Đóng'),
              ),
            ],
          );
        },
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đổi mật khẩu'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _oldPasswordController,
              decoration: InputDecoration(labelText: 'Nhập mật khẩu cũ'),
              obscureText: true,
            ),
            TextField(
              controller: _newPasswordController,
              decoration: InputDecoration(labelText: 'Nhập mật khẩu mới'),
              obscureText: true,
            ),
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(labelText: 'Nhập lại mật khẩu mới'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _changePassword(),
              child: Text('Cập nhật'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, foregroundColor: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

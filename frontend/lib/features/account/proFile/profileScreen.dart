import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Thêm import này

import '../../../core/abstracts/auth_service.dart';
import '../../../core/config/constants.dart';
import '../../../core/providers/auth_provider.dart';

class AccountInfoScreen extends StatefulWidget {
  @override
  _AccountInfoScreenState createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  void checkLoginStatus() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false); // Lấy authProvider
    await authProvider.loadUser();
    if (authProvider.currentUser == null) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }

  String _gender = 'Nam';
  DateTime _selectedDate = DateTime.now();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _ngaySinh = TextEditingController();

  // Biến lưu trữ tên hiển thị
  late final UserType? _userProvider;

  @override
  void initState() {
    super.initState();
    _userProvider = Provider.of<AuthProvider>(context, listen: false).currentUser; // Lấy authProvider ở đây
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _ngaySinh.dispose();
    _dobController.dispose();
    super.dispose();
  }

  void _showDatePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: 250,
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: CupertinoDatePicker(
                  initialDateTime: _selectedDate,
                  mode: CupertinoDatePickerMode.date,
                  minimumDate: DateTime(1900),
                  maximumDate: DateTime.now(),
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() {
                      _selectedDate = newDate;
                      _ngaySinh.text = "${newDate.day}/${newDate.month}/${newDate.year}";
                    });
                  },
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Xong',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  bool _isValidEmail(String email) {
    final RegExp regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return regex.hasMatch(email);
  }

  Future<void> _updateAccountInfo() async {
    String message;
    if (_name.text.isEmpty && _email.text.isEmpty && _ngaySinh.text.isEmpty) {
      message = 'Vui lòng nhập đầy đủ nội dung';
    } else if (_name.text.isEmpty && _email.text.isEmpty) {
      message = 'Vui lòng nhập Tên';
    } else if (_email.text.isEmpty) {
      message = 'Vui lòng nhập số điện thoại';
    } else if (_ngaySinh.text.isEmpty) {
      message = 'Vui lòng nhập ngày sinh';
    } else if (!_isValidEmail(_email.text)) {
      message = 'Email không đúng định dạng';
    } else {
      // Kiểm tra người dùng đã tồn tại chưa
      final checkUserUrl = Uri.parse('${backendUrl}/api/v1/auth/users'); // URL để kiểm tra người dùng
      final registerUrl = Uri.parse('${backendUrl}/api/v1/auth/register');
      final checkUserResponse = await http.post(
        checkUserUrl,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': _email.text}),
      );

      if (checkUserResponse.statusCode == 200) {
        // Người dùng đã tồn tại
        message = 'Người dùng đã tồn tại.';
      } else if (checkUserResponse.statusCode == 404) {
        // Người dùng không tồn tại, tiến hành đăng ký
        final response = await http.put(
          registerUrl,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'name': _name.text,
            'email': _email.text
          }),
        );

        if (response.statusCode == 200) {
          message = 'Cập nhật thành công';
          // Cập nhật thông tin hiển thị
          _userProvider?.fullName = _name.text;
        } else {
          message = 'Cập nhật thất bại. Vui lòng thử lại.';
        }
      } else {
        message = 'Kiểm tra người dùng thất bại.';
      }
    }

    // Hiển thị thông báo
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Thông báo'),
          content: Text(message),
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

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xác nhận'),
          content: Text('Bạn có muốn xóa tài khoản không?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin tài khoản'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              child: Icon(Icons.person, size: 40),
            ),
            SizedBox(height: 8),
            Text(
              _userProvider?.fullName ?? '', // Hiển thị tên mới
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _name..text = _userProvider?.fullName ?? '',
              decoration: InputDecoration(
                hintText: 'Tên tài khoản',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _email..text = _userProvider?.email ?? '',
              decoration: InputDecoration(
                hintText: 'Email',
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: const Text('Nam'),
                    leading: Radio<String>(
                      value: 'Nam',
                      groupValue: _gender,
                      onChanged: (String? value) {
                        setState(() {
                          _gender = value!;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('Nữ'),
                    leading: Radio<String>(
                      value: 'Nữ',
                      groupValue: _gender,
                      onChanged: (String? value) {
                        setState(() {
                          _gender = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            TextField(
              controller: _ngaySinh,
              readOnly: true,
              onTap: () => _showDatePicker(context),
              decoration: InputDecoration(
                hintText: 'Ngày sinh',
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: _updateAccountInfo,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: const Text(
                  'Cập nhật',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            TextButton(
              onPressed: () {
                _showLogoutDialog(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: Text(
                'Xóa tài khoản',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

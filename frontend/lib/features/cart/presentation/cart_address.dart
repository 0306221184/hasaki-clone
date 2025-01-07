import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/features/cart/presentation/cart_confirm.dart';
import 'package:frontend/features/cart/presentation/cart_screen.dart'; // Assuming this is the next screen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AddressScreen(),
    );
  }
}

class AddressScreen extends StatefulWidget {
  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _houseController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _nameController.dispose();
    _cityController.dispose();
    _houseController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_phoneController.text.isEmpty) {
      _showCustomDialog('Bạn chưa nhập số điện thoại');
    } else if (_nameController.text.isEmpty) {
      _showCustomDialog('Bạn chưa nhập họ tên');
    } else if (_cityController.text.isEmpty) {
      _showCustomDialog('Bạn chưa nhập Tỉnh/Thành phố');
    } else if (_houseController.text.isEmpty) {
      _showCustomDialog('Bạn chưa nhập Số nhà + Tên đường');
    } else if (_formKey.currentState!.validate()) {
      _showCustomDialog('Thông tin đã được lưu');
    } else {
      _showCustomDialog('Vui lòng điền đầy đủ thông tin và kiểm tra lại');
    }
  }

  void _showCustomDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  message,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Divider(height: 1, thickness: 1),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Đồng ý',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Địa chỉ nhận hàng'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Số điện thoại
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly, // Only allow digits
                ],
                decoration: InputDecoration(
                  labelText: 'Số điện thoại',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  // Check if phone number is exactly 10 digits
                  if (value!.isEmpty) {
                    return 'Vui lòng nhập số điện thoại';
                  } else if (value.length != 10) {
                    return 'Số điện thoại phải có 10 chữ số';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              // Họ tên
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Họ tên',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Vui lòng nhập họ tên';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              // Tỉnh/Thành phố
              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(
                  labelText: 'Tỉnh/Thành phố/Quận/Huyện/Phường/Xã',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Vui lòng nhập Tỉnh/Thành phố';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              // Số nhà + Tên đường
              TextFormField(
                controller: _houseController,
                decoration: InputDecoration(
                  labelText: 'Số nhà + Tên đường',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Vui lòng nhập Số nhà + Tên đường';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Spacer(),
              // Nút tiếp tục với chuyển hướng
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Only navigate if the form is valid
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OrderConfirmationScreen()), // Navigate to the next screen
                      );
                    } else {
                      // Show dialog if validation fails
                      _showCustomDialog('Vui lòng điền đầy đủ thông tin và kiểm tra lại');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    'Tiếp tục',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

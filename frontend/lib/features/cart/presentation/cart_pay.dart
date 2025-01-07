import 'package:flutter/material.dart';
import 'package:frontend/features/cart/presentation/cart_confirm.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PaymentMethodScreen(),
    );
  }
}

class PaymentMethodScreen extends StatefulWidget {
  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  int _selectedPaymentMethod = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hình thức thanh toán'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => OrderConfirmationScreen()));
          },
        ),
      ),
      body: Column(
        children: [
          ListTile(
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<int>(
                  value: 0,
                  groupValue: _selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethod = value!;
                    });
                  },
                ),
                const Icon(Icons.attach_money, color: Colors.green),
              ],
            ),
            title: const Text("Thanh toán khi nhận hàng (COD)"),
          ),
          ListTile(
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<int>(
                  value: 1,
                  groupValue: _selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethod = value!;
                    });
                  },
                ),
                const Icon(Icons.credit_card, color: Colors.blue),
              ],
            ),
            title: const Text("Thẻ ATM nội địa/Internet Banking (Hỗ trợ Internet Banking)"),
          ),
          ListTile(
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<int>(
                  value: 2,
                  groupValue: _selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethod = value!;
                    });
                  },
                ),
                const Icon(Icons.payment, color: Colors.black),
              ],
            ),
            title: const Text("Thanh toán bằng thẻ quốc tế Visa, Master"),
          ),
          ListTile(
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<int>(
                  value: 3,
                  groupValue: _selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethod = value!;
                    });
                  },
                ),
                const Icon(Icons.qr_code, color: Colors.orange),
              ],
            ),
            title: const Text("Thanh toán trực tuyến VNPAY"),
          ),
          ListTile(
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<int>(
                  value: 4,
                  groupValue: _selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethod = value!;
                    });
                  },
                ),
                const Icon(Icons.qr_code_2, color: Colors.blueAccent),
              ],
            ),
            title: const Text("Thanh toán trực tuyến VNPAY QR"),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Thêm chức năng cho nút "Tiếp tục"
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                "Tiếp tục",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

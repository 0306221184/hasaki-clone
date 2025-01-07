import 'package:flutter/material.dart';
import 'package:frontend/features/cart/presentation/cart_address.dart';
import 'package:frontend/features/cart/presentation/cart_discount.dart';
import 'package:frontend/features/cart/presentation/cart_pay.dart';
import 'package:frontend/features/cart/presentation/cart_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OrderConfirmationScreen(),
    );
  }
}

class OrderConfirmationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Xác nhận đơn hàng'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddressScreen()));
          },
        ),
      ),
      body: SingleChildScrollView(  // Wrap the body in SingleChildScrollView to allow scrolling
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Địa chỉ nhận hàng
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Nhà riêng',
                            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'User - 0123456789',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text('so nha + ten duong'),
                  ],
                ),
              ),
              SizedBox(height: 16),

              // Hình thức thanh toán
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('Hình thức thanh toán'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Thanh toán khi nhận hàng (COD)',
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                    Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentMethodScreen()));
                },
              ),
              Divider(),

              // Mã giảm giá
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('Mã giảm giá'),
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DiscountCodeScreen()));
                },
              ),
              Divider(),

              // Thông tin sản phẩm
              Row(
                children: [
                  Icon(Icons.calendar_today, color: Colors.blue, size: 16),
                  SizedBox(width: 8),
                  Text('Thứ 2, 01/01 - Thứ 5, 04/01'),
                  Spacer(),
                  Text('Giao trong 4-6 ngày'),
                ],
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Image.network(
                      'https://via.placeholder.com/50',
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Skin Aqua Clear White',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text('Sữa Chống Nắng Dưỡng Da'),
                          SizedBox(height: 4),
                          Text('Dung tich 55g', style: TextStyle(color: Colors.grey)),
                          Text('So luong 1', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                    Text('150.000 đ', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              SizedBox(height: 16),

              // Ghi chú
              TextField(
                decoration: InputDecoration(
                  labelText: 'Ghi chú',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 16),

              // Tổng tiền và nút đặt hàng
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tạm tính (1)', style: TextStyle(color: Colors.grey)),
                      Text('150.000 đ', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Giảm giá', style: TextStyle(color: Colors.grey)),
                      Text('-0 đ', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tổng thanh toán (đã VAT)', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('150.000 đ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                    ],
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text('Đặt hàng', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

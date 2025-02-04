import 'package:flutter/material.dart';
import 'package:frontend/features/account/order/orderScreen.dart';
import 'package:frontend/features/cart/presentation/cart/cart_screen.dart';
import 'package:frontend/features/cart/presentation/cartconfirm/cart_confirm.dart';
import 'package:frontend/features/home/presentation/home_screen.dart';

class OrderDetailsScreen extends StatelessWidget {
  final String imageUrl;
  final String name;
  final int price;
  final double rating;
  final String description;

  const OrderDetailsScreen({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.rating,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin đơn hàng'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDeliveryTimeSection(),
            SizedBox(height: 16),
            _buildShippingInfoSection(),
            SizedBox(height: 16),
            _buildAddressSection(),
            SizedBox(height: 16),
            _buildProductInfoSection(),
            Divider(),
            _buildOrderSummarySection(),
            SizedBox(height: 16),
            _buildOrderCodeSection(),
            Spacer(),
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryTimeSection() {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Thời gian nhận hàng dự kiến: 01 Th01 - 03 Th01',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildShippingInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Thông tin vận chuyển:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text('Express: VN123456789'),
        SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {},
          child: Text('Đơn hàng đã được đặt'),
        ),
      ],
    );
  }

  Widget _buildAddressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Địa chỉ nhận hàng',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text('User - 0123456789'),
        Text('10/10 nguyen van a, tỉnh bà rịa vũng tàu'),
      ],
    );
  }

  Widget _buildProductInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.network('${imageUrl}', width: 50, height: 50),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$name',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text('${price}đ'),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOrderSummarySection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Thành tiền:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text('${price}đ',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildOrderCodeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Mã đơn hàng: 251NH8015T',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text('Phương thức thanh toán: Thanh toán khi nhận hàng'),
        Text('Thời gian đặt hàng: 01-01-2025 12:00'),
        Text('Thời gian đơn vị vận chuyển lấy hàng: 02-01-2025 06:00'),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OrderScreen()),
          );
        },
        child: Text('Theo dõi đơn'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
          // Adjust horizontal and vertical padding
          minimumSize: Size(150, 50),
          // Set minimum size for the button
          textStyle: TextStyle(fontSize: 16,
              fontWeight: FontWeight.bold), // Customize font size and weight
        ),
      ),
    );
  }
}

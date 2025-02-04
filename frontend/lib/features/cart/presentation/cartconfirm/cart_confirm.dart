import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../account/order/OrderModel.dart';
import '../cartdiscount/cart_discount.dart';
import '../cartinfor/cartInfo.dart';
import '../cartpay/cart_pay.dart';

class OrderConfirmationScreen extends StatefulWidget {
  final String imageUrl;
  final String name;
  final int price;
  final double rating;
  final String description;

  const OrderConfirmationScreen({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.rating,
    required this.description,
  }) : super(key: key);

  @override
  _OrderConfirmationScreenState createState() =>
      _OrderConfirmationScreenState();
}

class _OrderConfirmationScreenState extends State<OrderConfirmationScreen> {
  String paymentMethod = 'Thanh toán khi nhận hàng (COD)';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Xác nhận đơn hàng'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
                          padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Nhà riêng',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
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
                    Text('Số nhà + tên đường'),
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
                      paymentMethod,
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                    Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
                onTap: () async {
                  // Mở PaymentMethodScreen và đợi kết quả
                  final selectedMethod = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PaymentMethodScreen()),
                  );
                  // Cập nhật phương thức thanh toán nếu có kết quả trả về
                  if (selectedMethod != null) {
                    setState(() {
                      paymentMethod = selectedMethod;
                    });
                  }
                },
              ),
              Divider(),

              // Mã giảm giá
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('Mã giảm giá'),
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DiscountCodeScreen()));
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
                      widget.imageUrl, // Replace with the URL of your image
                      height: 100, // Set a height for your image
                      width: 100, // Set a width for your image
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 8), // Add some space between the image and text
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text('${widget.description}'),
                        ],
                      ),
                    ),
                    Text('${widget.price}đ', style: TextStyle(fontWeight: FontWeight.bold)),
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
                      Text('Tạm tính (1)',
                          style: TextStyle(color: Colors.grey)),
                      Text('${widget.price}đ ', style: TextStyle(color: Colors.grey)),
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
                      Text('Tổng thanh toán (đã VAT)',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('${widget.price}đ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.red)),
                    ],
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Add order to OrderProvider
                        Provider.of<OrderProvider>(context, listen: false).addToOrder({
                          'imageUrl': widget.imageUrl,
                          'name': widget.name,
                          'price': widget.price,
                          'rating': widget.rating,
                          'description': widget.description,
                        });
                        // Navigate to OrderDetailsScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderDetailsScreen(
                              imageUrl: widget.imageUrl,
                              name: widget.name,
                              price: widget.price,
                              rating: widget.rating,
                              description: widget.description,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text('Đặt hàng',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
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

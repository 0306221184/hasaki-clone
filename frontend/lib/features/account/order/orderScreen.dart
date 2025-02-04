import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../cart/presentation/cartconfirm/cart_confirm.dart';
import 'OrderModel.dart';


class OrderScreen extends StatefulWidget {
  final int initialTabIndex;
  OrderScreen({this.initialTabIndex = 0});
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int quantity = 1;
  final int price = 150000;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 5,
      vsync: this,
      initialIndex: widget.initialTabIndex,
    ); // Updated to 5 tabs
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildEmptyCart(),
                _justordered(),
                _orderprocessing(),
                _success(),
                _buildCancelledOrders(), // New widget for cancelled orders
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// AppBar phần trên cùng
  AppBar _buildAppBar() {
    return AppBar(
      title: Text('Đơn hàng'),
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      centerTitle: true,
    );
  }

  /// TabBar riêng bên dưới AppBar
  Widget _buildTabBar() {
    return Material(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        isScrollable: true, // Cho phép cuộn
        indicatorColor: Colors.red, // Màu gạch chân
        labelColor: Colors.red, // Màu chữ khi được chọn
        unselectedLabelColor: Colors.black, // Màu chữ khi không được chọn
        tabs: [
          Tab(text: 'Tất cả'),
          Tab(text: 'Mới đặt'),
          Tab(text: 'Đang xử lý'),
          Tab(text: 'Thành công'),
          Tab(text: 'Đã hủy'), // Added the new 'Cancelled' tab
        ],
      ),
    );
  }

  Widget _buildEmptyCart() {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int index = 0;
                index < orderProvider.orderItems.length; index++)
                  _buildCartItem(orderProvider.orderItems[index], index),
              ],
            ),
          ),
      ]
      ),
    );
  }
  Widget _orderprocessing() {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int index = 0; index < orderProvider.orderItems.length; index++)
                  _buildCartItem(orderProvider.orderItems[index], index),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _justordered() {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int index = 0; index < orderProvider.orderItems.length; index++)
                  _buildCartItem(orderProvider.orderItems[index], index),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _success() {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int index = 0; index < orderProvider.orderItems.length; index++)
                  _buildCartItem(orderProvider.orderItems[index], index),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // New method for the "Cancelled Orders" tab
  Widget _buildCancelledOrders() {
    final orderProvider = Provider.of<OrderProvider>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20),
          if (orderProvider.cancelledOrders.isEmpty)
            Column(
              children: [
                Icon(Icons.cancel_outlined, size: 100, color: Colors.redAccent),
                SizedBox(height: 10),
                Text(
                  'Không có đơn hàng đã hủy',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            )
          else
            ...orderProvider.cancelledOrders.map((order) => _buildCancelledItem(order)).toList(),
        ],
      ),
    );
  }

  Widget _buildCancelledItem(Map<String, dynamic> order) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        leading: Image.network(order['imageUrl'], width: 50, height: 50),
        title: Text(order['name']),
        subtitle: Text('Giá: ${order['price']} đ'),
        trailing: TextButton(
          onPressed: () {
            // Navigate to OrderConfirmationScreen when the user taps on "Đặt lại hàng"
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrderConfirmationScreen(
                  imageUrl: order['imageUrl'],
                  name: order['name'],
                  price: order['price'],
                  rating: order['rating'], // Pass the rating if available
                  description: order['description'], // Pass the description if available
                ),
              ),
            );
          },
          child: Text(
            'Đặt lại hàng',
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ),
    );
  }


  void _reorderItem(Map<String, dynamic> order) {
    // Logic to reorder the item, like calling a method from the provider or API
    print('Reordering item: ${order['name']}');
    // Example: orderProvider.reorder(order);
  }


  Widget _buildCartItem(Map<String, dynamic> product, int index) {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    return Column(
      children: [
        Row(
          children: [
            Image.network(
              product['imageUrl'],
              width: 100,
              height: 100,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product['name'],
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.black),
                        onPressed: () {
                          orderProvider.removeFromOrder(index);
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  Text(product['description']),
                  Text('Dung tích 55g | Loại da: Da dầu/Da nhạy cảm'),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (quantity > 1) quantity--;
                    });
                  },
                ),
                Text('$quantity'),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      quantity++;
                    });
                  },
                ),
              ],
            ),
            Text('x ${product['price'] * quantity} đ'),
          ],
        ),
        SizedBox(height: 16),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tổng thanh toán',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              '${product['price'] * quantity} đ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
            ),
          ],
        ),
        Text('Đã bao gồm VAT'),
      ],
    );
  }
}




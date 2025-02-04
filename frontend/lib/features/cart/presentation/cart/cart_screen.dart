import 'package:flutter/material.dart';
import 'package:frontend/features/cart/presentation/cartconfirm/cart_confirm.dart';
import 'package:provider/provider.dart';
import '../../data/models/CartPage.dart';
import '../../../Category_Detal/category_detail_screen.dart';

class CartScreen extends StatefulWidget {
  final Map<String, dynamic> product;

  const CartScreen({Key? key, required this.product}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Map<String, dynamic>> cartItems = [];

  @override
  void initState() {
    super.initState();
    // Add the product to the cart when CartScreen is first opened
    cartItems.add(widget.product);
  }

  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index); // Remove item from the cart
    });
  }

  int calculateTotalPrice() {
    int total = 0;
    for (var item in cartItems) {
      total += (item['price'] as int?) ?? 0; // Handle null values by defaulting to 0
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context).cart;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ Hàng'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: cart.isEmpty
          ? const Center(
        child: Text(
          'Giỏ hàng trống',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      )
          : ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          final product = cart[index];
          final price = (product['price'] as int?) ?? 0;
          final imageUrl = product['imageUrl'] ?? '';

          return Card(
            margin: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.network(
                  imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.image_not_supported), // Handle image load errors
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product['name'] ?? 'Unknown Product',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text('$price VND'),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    Provider.of<CartProvider>(context, listen: false)
                        .removeFromCart(product);
                    // Rebuild the widget to update the cart state
                    setState(() {});
                  },
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: cart.isEmpty
          ? null
          : BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tổng tiền: ${cart.fold<int>(0, (total, item) => total + ((item['price'] as int?) ?? 0))} VND',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                 style:  ElevatedButton.styleFrom(
                   backgroundColor: Colors.red
                 ),
                onPressed: () {
                    if (cart.isNotEmpty) {
                      // Chuyển hướng đến màn hình xác nhận đặt hàng
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              OrderConfirmationScreen(
                                imageUrl: cart[0]['imageUrl'] ?? '',
                                name: cart[0]['name'] ?? 'Unknown Product',
                                price: cart.fold<int>(
                                    0, (total, item) => total +
                                    ((item['price'] as int?) ?? 0)),
                                rating: cart[0]['rating'] ?? 0.0,
                                description: cart[0]['description'] ?? '',
                              ),
                        ),
                      );
                    }
                },
                child: const Text( 'Tiến Hành Đặt Hàng',
                style: TextStyle( color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
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

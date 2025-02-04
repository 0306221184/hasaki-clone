import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Category_Detal/category_detail_screen.dart';
import 'FavariteMdel.dart';


class FavoriteProductScreen extends StatefulWidget {
  final Map<String, dynamic> product;

  const FavoriteProductScreen({Key? key, required this.product}) : super(key: key);

  @override
  _FavoriteProductScreen createState() => _FavoriteProductScreen();
}

class _FavoriteProductScreen extends State<FavoriteProductScreen> {

  Map<String, dynamic>? selectedProduct;

  @override
  void initState() {
    super.initState();
  }


  int calculateTotalPrice() {
    if (selectedProduct != null) {
      return selectedProduct!['price'];
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    // final cart = Provider.of<FavoritesProvider>(context).favoriteProductIds;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yêu thích'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tổng tiền: ${calculateTotalPrice()} VND',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () {
                },
                child: Text('Tiến Hành Đặt Hàng'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


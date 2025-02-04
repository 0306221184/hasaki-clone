import 'package:flutter/material.dart';
import 'package:frontend/features/cart/presentation/cartconfirm/cart_confirm.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Thêm import này
import '../../core/config/constants.dart';
import '../account/favoriteproduct/FavariteMdel.dart';
import '../cart/presentation/cart/cart_screen.dart';
import '../cart/data/models/CartPage.dart';


class ProductDetailPage extends StatefulWidget {
  final String imageUrl;
  final String name;
  final int price;
  final double rating;
  final String description;
  final String productId;

  ProductDetailPage({
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.rating,
    required this.description,
    required this.productId,
    Key? key,
  }) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int quantity = 1; // Default quantity
  bool isExpanded = false;
  bool isFavorite = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CartScreen(product: {})),
                );
              }
            ),
    IconButton(
      icon: Icon( isFavorite ? Icons.favorite : Icons.favorite_border,
      color: isFavorite ? Colors.red : Colors.black, ),
      onPressed: () { setState(() { isFavorite = !isFavorite; });
      },
    ),
          ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child: Image.network(
                    widget.imageUrl,
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    color: Colors.grey.shade200,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        formatCurrency(widget.price),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Product Name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                widget.name,
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            const SizedBox(height: 8),

            // Product Rating
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Icon(Icons.star, color: Colors.orange, size: 16),
                  Text(
                    "${widget.rating.toStringAsFixed(1)}",
                    style: const TextStyle(fontSize: 14),
                  ),
                  SizedBox(width: 4),
                  Text("(12 reviews)", style: TextStyle(color: Colors.blue)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border(
                  top: BorderSide(color: Colors.grey.shade400),
                  bottom: BorderSide(color: Colors.grey.shade400),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Số lượng:",
                    style: TextStyle(fontSize: 16),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          if (quantity > 1) {
                            setState(() {
                              quantity--;
                            });
                          }
                        },
                      ),
                      Text('$quantity', style: const TextStyle(fontSize: 16)),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ExpansionTile(
              title: const Text("Mô tả sản phẩm",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              initiallyExpanded: isExpanded, // Trạng thái mặc định
              onExpansionChanged: (bool expanded) {
                setState(() {
                  isExpanded = expanded;
                });
              },
              children: [
                GestureDetector(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                     widget.description,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ExpansionTile(
              title: const Text("Hướng dẫn sử dụng",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              children: [
                GestureDetector(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "Lấy lượng kem dưỡng bằng hạt đậu hoặc theo chỉ dẫn, dùng đầu ngón tay thoa đều kem lên da mặt, bắt đầu từ cằm theo hướng từ dưới lên trên từ trong ra ngoài.\n\n",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ],
            ), const SizedBox(height: 16),
            ExpansionTile(
              title: const Text("Thành phần sản phẩm",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Thành phần chính của Obagi 360 Retinol Cream bao gồm:\n"
                        "- Retinol tinh khiết: Giúp cải thiện các vấn đề về da như mụn, lão hóa.\n"
                        "- Vitamin E: Dưỡng ẩm và làm mềm da.\n"
                        "- Axit hyaluronic: Dưỡng ẩm, giúp da mềm mại và căng mịn.\n"
                        "- Glycerin: Dưỡng ẩm, làm mềm da.\n"
                        "- Chiết xuất từ lô hội: Làm dịu và cấp ẩm cho da.",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: const Text(
                "Đánh giá",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tổng quan đánh giá
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                '4.8',
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                              SizedBox(height: 4),
                              Icon(Icons.star, color: Colors.red, size: 32),
                            ],
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Thanh đánh giá chi tiết
                                ...List.generate(
                                  5,
                                      (index) => Row(
                                    children: [
                                      Text('${5 - index} ★',
                                          style: const TextStyle(fontSize: 16)),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: LinearProgressIndicator(
                                          value: [
                                            0.8,
                                            0.6,
                                            0.0,
                                            0.0,
                                            0.0
                                          ][index],
                                          backgroundColor: Colors.grey[300],
                                          color: Colors.red,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text('${[10, 2, 0, 0, 0][index]}'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Nút viết đánh giá
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {  },
                          child: const Text(
                            'VIẾT ĐÁNH GIÁ',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ]
        )
      ),
      bottomNavigationBar:
      Container(
          decoration:
          BoxDecoration(
          border: Border(
          top: BorderSide(color: Colors.grey, width: 1.0),
    ),
    ),
     child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                ),
                onPressed: () {
                  Map<String, dynamic> product = {
                    'imageUrl': widget.imageUrl,
                    'name': widget.name,
                    'price': widget.price,
                    'rating': widget.rating,
                    'description': widget.description,
                    'quantity': quantity,
                  };
                  Provider.of<CartProvider>(context, listen: false).addToCart(product);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(product: product),
                    ),
                  );
                },
                child: Text('Thêm vào giỏ hàng', style: TextStyle(fontWeight: FontWeight.bold),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    builder: (context) {
                      return StatefulBuilder(
                        builder:
                            (BuildContext context, StateSetter setModalState) {
                          return FractionallySizedBox(
                            heightFactor: 0.6, // Chiếm 60% chiều cao màn hình
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Header với nút đóng
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Thông tin mua hàng',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.close),
                                        onPressed: () {
                                          Navigator.pop(context); // Đóng modal
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  // Dung tích sản phẩm
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text('Dung tích:',
                                          style: TextStyle(fontSize: 16)),
                                      Text('28g',
                                          style: TextStyle(fontSize: 16)),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  // Giá tiền (thay đổi theo số lượng)
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Giá:',
                                          style: TextStyle(fontSize: 16)),
                                      Text(
                                        '${(widget.price * quantity).toString()}', // Áp dụng định dạng
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 8),
                                  // Hình ảnh sản phẩm
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Image.network(
                                      widget.imageUrl, // Đổi theo hình ảnh sản phẩm
                                      width: 100,
                                      height: 100,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  // Số lượng sản phẩm
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Số lượng:",
                                          style: TextStyle(fontSize: 16)),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.remove),
                                            onPressed: () {
                                              setModalState(() {
                                                if (quantity > 1) quantity--;
                                              });
                                            },
                                          ),
                                          Text("$quantity",
                                              style: const TextStyle(
                                                  fontSize: 16)),
                                          IconButton(
                                            icon: const Icon(Icons.add),
                                            onPressed: () {
                                              setModalState(() {
                                                quantity++;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                      Center(
                                        child: Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            // Xử lý mua hàng
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context)=>OrderConfirmationScreen(
                                                  imageUrl: widget.imageUrl,
                                                  name: widget.name,
                                                  price: widget.price,
                                                  rating: widget.rating,
                                                  description: widget.description,
                                                ))
                                            ); // Đóng modal
                                          },
                                          child: const Text(
                                            'Mua online',
                                            style:
                                            TextStyle(color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 50,
                                                vertical: 20),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                          ),
                                        ),
                                      ),
                                      )
                                    ],
                                  ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                child: const Text(
                  'Mua online',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 40,),
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      )
    );
  }

  String formatCurrency(int price) {
    return '${price.toString()} đ'; // Format price in currency format
  }
}

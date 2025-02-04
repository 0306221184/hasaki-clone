import 'package:flutter/material.dart';
import 'package:frontend/features/Category_Detal/category_detail_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async'; // Import this for Timer
import '../../../core/config/constants.dart';

class DetailedList extends StatefulWidget {
  const DetailedList({Key? key}) : super(key: key);

  @override
  _DetailedListState createState() => _DetailedListState();
}

class _DetailedListState extends State<DetailedList> {
  List<dynamic> products = [];
  TextEditingController searchController = TextEditingController();
  Timer? _debounce;
  bool isLoadingProducts = true;

  @override
  void initState() {
    super.initState();
    fetchProducts();
    searchController.addListener(onSearchChanged);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    searchController.removeListener(onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  Future<void> fetchProducts() async {
    setState(() {
      isLoadingProducts = true;
    });
    try {
      final response = await http.get(
        Uri.parse('${backendUrl}/api/v1/product'),
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        setState(() {
          products = List<dynamic>.from(json['data']);
          isLoadingProducts = false;
        });
      } else {
        setState(() {
          isLoadingProducts = false;
          products = [];
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi khi tải sản phẩm, mã lỗi: ${response.statusCode}')),
        );
      }
    } catch (e) {
      setState(() {
        isLoadingProducts = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Không thể kết nối tới máy chủ. Vui lòng thử lại.')),
      );
    }
  }

  void onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      final query = searchController.text.toLowerCase();
      if (query.isNotEmpty) {
        setState(() {
          products = products.where((product) {
            final name = product['name']?.toLowerCase() ?? '';
            return name.startsWith(query);
          }).toList();
        });
      } else {
        fetchProducts();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Tìm kiếm',
            prefixIcon: Icon(Icons.search),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
          ),
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color(0xFF3CABF3),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ],
      ),
      body: isLoadingProducts
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 5.0,
          childAspectRatio: 0.6,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index] as Map<String, dynamic>;

          return GestureDetector(
            onTap: () {
              // Navigate to the product detail page on tap
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailPage(
                    imageUrl: product['image_url'] as String,
                    name: product['name'] as String,
                    price: product['price'] as int,
                    rating: product['rating'] as double,
                    description: product['description'] as String,
                    productId: '',
                  ),
                ),
              );
            },
            child: Container(
              height: 150,
              margin: EdgeInsets.symmetric(vertical: 5.0),
              decoration: BoxDecoration(
                color: Colors.accents[index % Colors.accents.length],
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(15.0)),
                      child: Image.network(
                        product['image_url'] as String,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.broken_image);
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            '${product['price']} đ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(product['name'] as String),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Row(
                            children: [
                              Text(
                                'Đánh giá: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '⭐' * (product['rating'] as double).toInt(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

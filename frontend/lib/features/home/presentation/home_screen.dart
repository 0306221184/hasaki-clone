import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:frontend/core/config/constants.dart';
import 'package:frontend/core/providers/auth_provider.dart';
import 'package:frontend/features/account/location/locationScreen.dart';
import 'package:frontend/features/account/order/orderScreen.dart';
import 'package:frontend/features/category/presentation/category_screen.dart';
import 'package:frontend/features/category/presentation/detailedlist.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import '../../Category_Detal/category_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> products = []; // Danh sách sản phẩm
  List<dynamic> categories = []; // Danh sách danh mục

  @override
  void dispose() {
    super.dispose();
  }

  // Kiểm tra trạng thái đăng nhập
  void checkLoginStatus() {
    final authProvider =
    Provider.of<AuthProvider>(context, listen: false); // Lấy authProvider
    authProvider.loadUser().then((_) {
      print(authProvider.currentUser);      if (authProvider.currentUser == null) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  Future<void> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('${backendUrl}/api/v1/product'));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        setState(() {
          products = json['data'] as List; // Ép kiểu thành List
        });
      } else {
        print('Lỗi khi tải dữ liệu sản phẩm: ${response.statusCode}');
      }
    } catch (e) {
      print('Lỗi kết nối: $e');
    }
  }

  Future<void> fetchCategories() async {
    try {
      final response = await http.get(Uri.parse('${backendUrl}/api/v1/category'));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        setState(() {
          categories = json['data'] as List; // Ép kiểu thành List
        });
      } else {
        print('Lỗi khi tải dữ liệu danh mục: ${response.statusCode}');
      }
    } catch (e) {
      print('Lỗi kết nối: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    fetchProducts();
    fetchCategories(); // Gọi hàm để tải danh mục
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Tìm kiếm',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.location_on),
            onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>LocationSelectionScreen()));
              },
          ),
          IconButton(
            icon: Icon(Icons.shopping_bag),
            onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderScreen()));},
          ),
        ],
      ),
      body: Container(
        color: Colors.blue,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Mở đầu
              Padding(
                padding: const EdgeInsets.only(right: 16.0, top: 16.0),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  crossAxisSpacing: 50,
                  mainAxisSpacing: 2,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    _buildCategoryItem(
                        'Danh mục', Colors.green, Icons.category),
                    _buildCategoryItem('Cẩm nang', Colors.purple, Icons.book),
                    _buildCategoryItem(
                        'Hàng mới về', Colors.orange, Icons.new_releases),
                    _buildCategoryItem(
                        'Tra cứu hàng hóa', Colors.yellow, Icons.search),
                    _buildCategoryItem('Nước Hoa Chính Hãng',
                        const Color.fromARGB(255, 66, 120, 214), Icons.spa),
                    _buildCategoryItem(
                        'Khuyến mãi', Colors.pink, Icons.local_offer),
                  ],
                ),
              ),

// Danh mục
              Container(
                color: Colors.grey[200],
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Danh mục',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 320,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          childAspectRatio: 1.5,
                        ),
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          return GestureDetector(
                            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailedList()));},
                            child: Container(
                            width: 100,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors
                                  .primaries[index % Colors.primaries.length]
                                  .shade100,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(15.0)),
                                    child: Image.network(
                                      category['icon_url'] ?? '',
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Icon(Icons.error);
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    category['name'] ?? '',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                            )
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              // Gợi ý cho bạn
        Container(
          color: Colors.grey[200],
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Gợi ý cho bạn',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 700,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 5.0,
                    childAspectRatio: 0.6,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index] as Map<String, dynamic>; // Ép kiểu thành Map
                    return GestureDetector(
                      onTap: () {
                        // Xử lý sự kiện nhấn
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
                                borderRadius:
                                BorderRadius.vertical(top: Radius.circular(15.0)),
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
                                          '⭐' *
                                              (product['rating'] as double).toInt(),
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
              ),
            ],
          ),
        )
        ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryItem(String title, Color color, IconData icon) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryScreen()));
      },
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Icon trong item
        Container(
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 30.0,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
      )
    );
  }
}
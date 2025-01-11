import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoggedIn = true; // Thêm biến để kiểm tra trạng thái đăng nhập

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  // Hàm kiểm tra trạng thái đăng nhập
  void checkLoginStatus() {
    // TODO: Thêm logic kiểm tra đăng nhập thực tế ở đây
    if (!isLoggedIn) {
      // Nếu chưa đăng nhập, chuyển đến trang đăng nhập
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacementNamed(context, '/login');
      });
    }
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Điều hướng đến các màn hình khác nhau dựa trên chỉ số đã chọn
    switch (_selectedIndex) {
      case 0:
        Navigator.pushNamed(context, '/');
        break;
      case 1:
        Navigator.pushNamed(context, '/category');
        break;
      case 2:
        Navigator.pushNamed(context, '/cart');
        break;
      case 3:
        Navigator.pushNamed(context, '/notification');
        break;
      case 4:
        Navigator.pushNamed(context, '/account');
        break;
    }
  }

  final List<String> bannerImages = [
    'assets/banner1.jpg',
    'assets/banner2.jpg',
    'assets/banner3.jpg',
    'assets/banner4.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent,
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/logo_doria.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
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
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.shopping_bag),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        color: Colors.blue,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 120.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.9,
                  aspectRatio: 16 / 9,
                  autoPlayInterval: Duration(seconds: 3),
                ),
                items: bannerImages.map((imagePath) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: AssetImage(imagePath),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
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
                        itemCount: 14,
                        itemBuilder: (context, index) {
                          List<String> images = [
                            'assets/3ce.jpg',
                            'assets/TD_mat.jpg',
                            'assets/mat.jpg',
                            'assets/matna.jpg',
                            'assets/srm.jpg',
                            'assets/daugoi.jpg',
                            'assets/kcn.jpg',
                            'assets/suatam.jpg',
                            'assets/taytrang.jpg',
                            'assets/kdr.jpg',
                            'assets/khumui.jpg',
                            'assets/duongtoc.jpg',
                            'assets/ddvs.jpg',
                            'assets/nuochoa.jpg',
                          ];

                          List<String> productNames = [
                            'Trang Điểm Môi',
                            'Trang Điểm Mặt',
                            'Trang Điểm Mắt',
                            'Mặt Nạ',
                            'Sữa Rửa Mặt',
                            'Dầu Gội và Dầu Xả',
                            'Chống Nắng Da Mặt',
                            'Sữa Tắm',
                            'Tẩy Trang Mặt',
                            'Chăm Sóc Răng Miệng',
                            'Khử Mùi',
                            'Serum / Dầu Dưỡng Tóc',
                            'Chăm Sóc Phụ Nữ',
                            'Nước Hoa',
                          ];

                          List<Color> colors = [
                            Colors.green.shade100,
                            Colors.blue.shade100,
                            Colors.orange.shade100,
                            Colors.red.shade100,
                            Colors.pink.shade100,
                            Colors.purple.shade100,
                            Colors.yellow.shade100,
                            Colors.cyan.shade100,
                            Colors.teal.shade100,
                            Colors.brown.shade100,
                            Colors.amber.shade100,
                            Colors.indigo.shade100,
                            Colors.lime.shade100,
                            Colors.deepPurple.shade100,
                          ];

                          String imagePath = images[index % images.length];
                          String productName =
                              productNames[index % productNames.length];
                          Color itemColor = colors[index % colors.length];
                          return Container(
                            width: 100,
                            height: 150,
                            decoration: BoxDecoration(
                              color: itemColor,
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
                                    child: Image.asset(
                                      imagePath,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    productName,
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
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),

// Thương hiệu
              Container(
                color: Colors.grey[200],
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Thương hiệu',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 150,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 6, // Số lượng item
                        itemBuilder: (context, index) {
                          List<Map<String, String>> brandData = [
                            {
                              'image': 'assets/cocon.jpg',
                              'nameImage': 'assets/logo-cocoon.jpg'
                            },
                          ];

                          String brandImagePath =
                              brandData[index % brandData.length]['image']!;
                          String brandNameImagePath =
                              brandData[index % brandData.length]['nameImage']!;

                          return Container(
                            width: 150,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  15.0), // Bo tròn góc cho item
                            ),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: Image.asset(
                                    brandImagePath,
                                    fit: BoxFit.cover,
                                    width: 150,
                                    height: 150,
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  left: 0,
                                  right: 0,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        brandNameImagePath,
                                        width: 100,
                                        height: 30,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
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
                        itemCount: 6,
                        itemBuilder: (context, index) => Container(
                          height: 150,
                          margin: EdgeInsets.symmetric(vertical: 5.0),
                          decoration: BoxDecoration(
                            color:
                                Colors.accents[index % Colors.accents.length],
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 2,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(15.0)),
                                  child: Image.asset(
                                    'assets/product${index + 1}.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text('${(index + 1) * 100000} đ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text('Tên sản phẩm ${index + 1}'),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text('Đánh giá: ⭐⭐⭐⭐',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Danh mục'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Giỏ hàng'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Thông báo'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Tài khoản'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        showUnselectedLabels: true,
        showSelectedLabels: true,
      ),
    );
  }

  Widget _buildCategoryItem(String title, Color color, IconData icon) {
    return Column(
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
    );
  }
}

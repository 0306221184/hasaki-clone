import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                'assets/logo_den.jpg',
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
        color: Colors.blue, // Nền xanh dương nhạt
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Banner (Carousel Slider)
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
                padding: const EdgeInsets.only( right: 16.0, top: 16.0),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  crossAxisSpacing: 50,
                  mainAxisSpacing: 2,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    _buildCategoryItem('Danh mục', Colors.green),
                    _buildCategoryItem('Cẩm nang', Colors.purple),
                    _buildCategoryItem('Hàng mới về', Colors.orange),
                    _buildCategoryItem('Tra cứu hàng hóa', Colors.yellow),
                    _buildCategoryItem('Nước Hoa', Colors.blueAccent),
                    _buildCategoryItem('Khuyến mãi', Colors.pink),
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
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
      ),
      SizedBox(height: 10),
      SizedBox(
        height: 300, 
        child: GridView.builder(
          scrollDirection: Axis.horizontal, 
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 items mỗi hàng
            crossAxisSpacing: 10.0, 
            mainAxisSpacing: 10.0,
            childAspectRatio: 1.5, 
          ),
          itemCount: 14, // Số lượng sản phẩm
          itemBuilder: (context, index) {
            // Danh sách các ảnh sản phẩm
            List<String> images = [
              'assets/3ce.jpg',
            ];

            // Danh sách tên sản phẩm
            List<String> productNames = [
              'Son Môi 3CE',
              'Son Môi 2',
              'Phấn Mắt 3',
              'Kem Dưỡng Da 4',
              'Sữa Rửa Mặt 5',
              'Son Môi 6',
              'Mặt Nạ 7',
              'Kem Chống Nắng 8',
              'Nước Hoa 9',
              'Dầu Gội 10',
              'Dầu Xả 11',
              'Bột Tẩy Tế Bào Chết 12',
              'Kem Trị Mụn 13',
              'Sữa Tắm 14',
            ];

            // Lấy ảnh và tên sản phẩm tương ứng với index
            String imagePath = images[index % images.length];
            String productName = productNames[index % productNames.length];

            return Container(
              width: 100, 
              height: 150, 
              decoration: BoxDecoration(
                color: Colors.accents[index % Colors.accents.length],
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                children: [
                 
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
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
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
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
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
      ),
      SizedBox(height: 10),
      SizedBox(
        height: 150,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 6, // Số lượng item
          itemBuilder: (context, index) {
            // Danh sách ảnh thương hiệu và tên thương hiệu tương ứng dưới dạng hình ảnh
            List<Map<String, String>> brandData = [
              {'image': 'assets/cocon.jpg', 'nameImage': 'assets/logo-cocoon.jpg'},
            ];

            // Lấy dữ liệu thương hiệu (hình ảnh và tên hình ảnh) tương ứng với index
            String brandImagePath = brandData[index % brandData.length]['image']!;
            String brandNameImagePath = brandData[index % brandData.length]['nameImage']!;

            return Container(
              width: 150,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0), // Bo tròn góc cho item
              ),
              child: Stack(
                children: [
                  // Ảnh thương hiệu làm nền
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0), // Bo tròn góc cho ảnh nền
                    child: Image.asset(
                      brandImagePath, // Hiển thị ảnh thương hiệu
                      fit: BoxFit.cover, // Giữ tỷ lệ ảnh nhưng cắt bỏ phần thừa nếu cần
                      width: 150, // Đảm bảo ảnh nền đầy đủ chiều rộng của item
                      height: 150, // Đảm bảo ảnh nền đầy đủ chiều cao của item
                    ),
                  ),
                  // Ảnh tên thương hiệu nằm trên ảnh thương hiệu
                  Positioned(
                    bottom: 10, // Đặt ảnh tên thương hiệu gần dưới cùng của ảnh thương hiệu
                    left: 0,
                    right: 0,
                    child: Align(
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0), // Bo góc cho ảnh tên thương hiệu
                        child: Image.asset(
                          brandNameImagePath, // Hiển thị tên thương hiệu dưới dạng hình ảnh
                          width: 100, // Kích thước hình ảnh tên thương hiệu
                          height: 30, // Chiều cao hình ảnh tên thương hiệu
                          fit: BoxFit.contain, // Căn vừa với kích thước
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
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
      ),
      SizedBox(height: 10),
      SizedBox(
        height: 700,  // Điều chỉnh chiều cao tổng thể của container để chứa 4 item
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,  // 2 item trong mỗi hàng
            crossAxisSpacing: 10.0,  // Khoảng cách giữa các item theo chiều ngang
            mainAxisSpacing: 5.0,  // Khoảng cách giữa các item theo chiều dọc
            childAspectRatio: 0.6,  // Điều chỉnh tỷ lệ chiều dài (dọc) lớn hơn chiều rộng (ngang) để có hình chữ nhật đứng
          ),
          itemCount: 6,  // Số lượng item
          itemBuilder: (context, index) => Container(
            height: 150,  // Chiều cao của mỗi item
            margin: EdgeInsets.symmetric(vertical: 5.0),
            decoration: BoxDecoration(
              color: Colors.accents[index % Colors.accents.length],
              borderRadius: BorderRadius.circular(15.0),  // Bo tròn góc
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
                    child: Image.asset(
                      'assets/product${index + 1}.jpg',  // Hiển thị ảnh sản phẩm
                      fit: BoxFit.cover,  // Giữ tỷ lệ ảnh nhưng cắt phần thừa
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text('Sản phẩm ${index + 1}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text('\$${(index + 1) * 10}', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text('Mô tả sản phẩm ${index + 1}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text('Đánh giá: ⭐⭐⭐⭐', style: TextStyle(fontWeight: FontWeight.bold)),
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
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Danh mục'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Giỏ hàng'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Thông báo'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Tài khoản'),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        showUnselectedLabels: true,
        showSelectedLabels: true,
      ),
    );
  }

  Widget _buildCategoryItem(String label, Color color) {
    return Column(
      children: [
        Container(
          height: 50,
          width: 60,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

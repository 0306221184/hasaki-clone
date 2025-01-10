import 'package:flutter/material.dart';
import 'package:frontend/features/category/presentation/detailedlist.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  int selectedIndex = 0;

  final List<List<Widget>> categoryItems = [
    [
      CategoryItem(imageUrl: 'assets/skinqua.png', label: 'Mỹ phẩm High-End'),
      CategoryItem(imageUrl: 'assets/skinqua.png', label: 'Chăm sóc da mặt'),
    ],
    [
      CategoryItem(imageUrl: 'assets/skinqua.png', label: 'Trang điểm'),
      CategoryItem(imageUrl: 'assets/skinqua.png', label: 'Trang điểm cao cấp'),
    ],
    [
      CategoryItem(imageUrl: 'assets/skinqua.png', label: 'Chăm sóc Tóc'),
      CategoryItem(imageUrl: 'assets/skinqua.png', label: 'Chăm sóc Da đầu'),
    ],
    [
      CategoryItem(imageUrl: 'assets/skinqua.png', label: 'Chăm sóc cơ thể'),
      CategoryItem(imageUrl: 'assets/skinqua.png', label: 'Sản phẩm cơ thể'),
    ],
    [
      CategoryItem(imageUrl: 'assets/skinqua.png', label: 'Chăm sóc cá nhân'),
      CategoryItem(imageUrl: 'assets/skinqua.png', label: 'Vệ sinh cá nhân'),
    ],
    [
      CategoryItem(imageUrl: 'assets/skinqua.png', label: 'Nước hoa A'),
      CategoryItem(imageUrl: 'assets/skinqua.png', label: 'Nước hoa B'),
    ],
    [
      CategoryItem(imageUrl: 'assets/skinqua.png', label: 'Thực phẩm chức năng A'),
      CategoryItem(imageUrl: 'assets/skinqua.png', label: 'Thực phẩm chức năng B'),
    ],
    [
      CategoryItem(imageUrl: 'assets/skinqua.png', label: 'Phiếu mua hàng A'),
      CategoryItem(imageUrl: 'assets/skinqua.png', label: 'Phiếu mua hàng B'),
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
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
            icon: Icon(Icons.location_on, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.all_inbox_rounded, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Row(
        children: [
          Container(
            width: 200,
            child: ListView(
              children: [
                ListTile(
                  title: Text(
                    'Chăm sóc da mặt',
                    style: TextStyle(
                      fontSize: selectedIndex == 0 ? 18 : 14,
                      color: selectedIndex == 0 ? Colors.blue : Colors.black, // Chữ màu xanh khi được chọn
                    ),
                  ),
                  selected: selectedIndex == 0,
                  selectedTileColor: Colors.blue.shade100, // Màu nền xanh dương khi được chọn
                  onTap: () {
                    setState(() {
                      selectedIndex = 0;
                    });
                  },
                ),
                ListTile(
                  title: Text(
                    'Trang điểm',
                    style: TextStyle(
                      fontSize: selectedIndex == 1 ? 18 : 14,
                      color: selectedIndex == 1 ? Colors.blue : Colors.black, // Chữ màu xanh khi được chọn
                    ),
                  ),
                  selected: selectedIndex == 1,
                  selectedTileColor: Colors.blue.shade100, // Màu nền xanh dương khi được chọn
                  onTap: () {
                    setState(() {
                      selectedIndex = 1;
                    });
                  },
                ),
                ListTile(
                  title: Text(
                    'Chăm sóc Tóc và Da đầu',
                    style: TextStyle(
                      fontSize: selectedIndex == 2 ? 18 : 14,
                      color: selectedIndex == 2 ? Colors.blue : Colors.black, // Chữ màu xanh khi được chọn
                    ),
                  ),
                  selected: selectedIndex == 2,
                  selectedTileColor: Colors.blue.shade100, // Màu nền xanh dương khi được chọn
                  onTap: () {
                    setState(() {
                      selectedIndex = 2;
                    });
                  },
                ),
                ListTile(
                  title: Text(
                    'Chăm sóc cơ thể',
                    style: TextStyle(
                      fontSize: selectedIndex == 3 ? 18 : 14,
                      color: selectedIndex == 3 ? Colors.blue : Colors.black, // Chữ màu xanh khi được chọn
                    ),
                  ),
                  selected: selectedIndex == 3,
                  selectedTileColor: Colors.blue.shade100, // Màu nền xanh dương khi được chọn
                  onTap: () {
                    setState(() {
                      selectedIndex = 3;
                    });
                  },
                ),
                ListTile(
                  title: Text(
                    'Chăm sóc cá nhân',
                    style: TextStyle(
                      fontSize: selectedIndex == 4 ? 18 : 14,
                      color: selectedIndex == 4 ? Colors.blue : Colors.black, // Chữ màu xanh khi được chọn
                    ),
                  ),
                  selected: selectedIndex == 4,
                  selectedTileColor: Colors.blue.shade100, // Màu nền xanh dương khi được chọn
                  onTap: () {
                    setState(() {
                      selectedIndex = 4;
                    });
                  },
                ),
                ListTile(
                  title: Text(
                    'Nước hoa',
                    style: TextStyle(
                      fontSize: selectedIndex == 5 ? 18 : 14,
                      color: selectedIndex == 5 ? Colors.blue : Colors.black, // Chữ màu xanh khi được chọn
                    ),
                  ),
                  selected: selectedIndex == 5,
                  selectedTileColor: Colors.blue.shade100, // Màu nền xanh dương khi được chọn
                  onTap: () {
                    setState(() {
                      selectedIndex = 5;
                    });
                  },
                ),
                ListTile(
                  title: Text(
                    'Thực phẩm chức năng',
                    style: TextStyle(
                      fontSize: selectedIndex == 6 ? 18 : 14,
                      color: selectedIndex == 6 ? Colors.blue : Colors.black, // Chữ màu xanh khi được chọn
                    ),
                  ),
                  selected: selectedIndex == 6,
                  selectedTileColor: Colors.blue.shade100, // Màu nền xanh dương khi được chọn
                  onTap: () {
                    setState(() {
                      selectedIndex = 6;
                    });
                  },
                ),
                ListTile(
                  title: Text(
                    'Phiếu mua hàng',
                    style: TextStyle(
                      fontSize: selectedIndex == 7 ? 18 : 14,
                      color: selectedIndex == 7 ? Colors.blue : Colors.black, // Chữ màu xanh khi được chọn
                    ),
                  ),
                  selected: selectedIndex == 7,
                  selectedTileColor: Colors.blue.shade100, // Màu nền xanh dương khi được chọn
                  onTap: () {
                    setState(() {
                      selectedIndex = 7;
                    });
                  },
                ),
              ],
            ),
          ),
          VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: categoryItems[selectedIndex],
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String imageUrl;
  final String label;

  const CategoryItem({
    required this.imageUrl,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => detailedList(),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.cover, // Đảm bảo hình ảnh vừa khung hình
                    width: double.infinity,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

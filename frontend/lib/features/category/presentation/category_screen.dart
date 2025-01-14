import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/features/category/presentation/detailedlist.dart';
import 'package:http/http.dart' as http;
import '../../../core/config/constants.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}
class _CategoryScreenState extends State<CategoryScreen> {
  int selectedIndex = 0;
  List<dynamic> products = [];
  List<dynamic> categories = [];

  Map<int, List<dynamic>> groupedCategories = {}; // Grouped by parent_id

  Future<void> fetchProducts() async {
    try {
      final response = await http.get(
          Uri.parse('${backendUrl}/api/v1/product'));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        setState(() {
          products = json['data'] as List;
        });
      } else {
        print('Error loading products: ${response.statusCode}');
      }
    } catch (e) {
      print('Connection error: $e');
    }
  }

  Future<void> fetchCategories() async {
    try {
      final response = await http.get(
          Uri.parse('${backendUrl}/api/v1/category'));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        List<dynamic> rawCategories = json['data'] as List;

        // Xử lý grouping
        Map<int, List<dynamic>> grouped = {};
        for (var category in rawCategories) {
          int? parentId = category['parent_id'];
          grouped.putIfAbsent(parentId ?? 0, () => []).add(category);
        }

        setState(() {
          categories = grouped[0] ?? []; // Danh mục cha cấp cao nhất
          groupedCategories = grouped;
        });
      } else {
        print('Error loading categories: ${response.statusCode}');
        // Hiển thị thông báo lỗi hoặc UI thay thế
      }
    } catch (e) {
      print('Connection error: $e');
      // Hiển thị thông báo lỗi hoặc UI thay thế
    }
  }


  @override
  void initState() {
    super.initState();
    fetchProducts();
    fetchCategories();
  }

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
      body: categories.isEmpty
          ? Center(child: CircularProgressIndicator()) // Hiển thị khi đang tải
          : Row(
        children: [
          // Danh sách danh mục cha
          Container(
            width: 200,
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    categories[index]['name'] ?? 'N/A',
                    style: TextStyle(
                      fontSize: selectedIndex == index ? 18 : 14,
                      color: selectedIndex == index ? Colors.blue : Colors
                          .black,
                    ),
                  ),
                  selected: selectedIndex == index,
                  selectedTileColor: Colors.blue.shade100,
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                );
              },
            ),
          ),
          VerticalDivider(thickness: 1, width: 1),
          // Danh sách con
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: groupedCategories[categories[selectedIndex]['id']]
                  ?.length ?? 0,
              itemBuilder: (context, index) {
                var childCategory = groupedCategories[categories[selectedIndex]['id']]![index];
                return CategoryItem(
                  imageUrl: childCategory['icon_url'] ?? '',
                  label: childCategory['name'] ?? 'Unknown',
                  categoryId: childCategory['id'].toString(),
                );
              },
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
  final String categoryId;

  const CategoryItem({
    required this.imageUrl,
    required this.label,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailedList(categoryId), // Replace with your detailed list screen
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
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
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
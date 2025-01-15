import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async'; // Import this for Timer
import '../../../core/config/constants.dart';

class DetailedList extends StatefulWidget {
  final String categoryId;
  const DetailedList(this.categoryId, {Key? key}) : super(key: key);

  @override
  _DetailedListState createState() => _DetailedListState();
}

class _DetailedListState extends State<DetailedList> {
  List<dynamic> products = [];
  List<dynamic> categories = [];
  TextEditingController searchController = TextEditingController();
  Timer? _debounce;
  bool isLoadingProducts = true;
  bool isLoadingCategories = true;

  @override
  void initState() {
    super.initState();
    fetchProducts();
    fetchCategories();
    searchController.addListener(onSearchChanged);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    searchController.removeListener(onSearchChanged);
    searchController.dispose();
    super.dispose();
  }
//${widget.categoryId}?query=$query
  Future<void> fetchProducts({String query = ''}) async {
    try {
      final response = await http.get(Uri.parse('${backendUrl}/api/v1/product'));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        setState(() {
          products = List<dynamic>.from(json['data'] as List);
          isLoadingProducts = false;
        });
      } else {
        setState(() {
          isLoadingProducts = false;
          print('Error loading products: ${response.statusCode}');
        });
      }
    } catch (e) {
      setState(() {
        isLoadingProducts = false;
        print('Connection error: $e');
      });
    }
  }

  Future<void> fetchCategories() async {
    try {
      final response = await http.get(Uri.parse('${backendUrl}/api/v1/category'));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        setState(() {
          categories = List<dynamic>.from(json['data'] as List);
          isLoadingCategories = false;
        });
      } else {
        setState(() {
          isLoadingCategories = false;
          print('Error loading categories: ${response.statusCode}');
        });
      }
    } catch (e) {
      setState(() {
        isLoadingCategories = false;
        print('Connection error: $e');
      });
    }
  }

  void onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      final query = searchController.text.toLowerCase();
      fetchProducts(query: query); // Gọi fetchProducts với tham số query
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
      body: isLoadingProducts || isLoadingCategories
          ? Center(child: CircularProgressIndicator())
          : ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 20.0,
              runSpacing: 20.0,
              alignment: WrapAlignment.center,
              children: products.map((product) {
                return _buildProductCard(
                  product['image_url'] ?? 'https://via.placeholder.com/160x100',
                  product['name'] ?? 'No Name',
                  product['description'] ?? 'No Description',
                  '${product['price'] ?? 'No Price'}đ',
                  product['rating']?.toDouble() ?? 0.0,
                  product['reviewCount'] ?? 0,
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildProductCard(String imageUrl, String title, String description, String price, double rating, int reviewCount) {
    return Container(
      width: 220,
      height: 350,
      child: Card(
        elevation: 10,
        shadowColor: Colors.grey.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                imageUrl,
                width: 160,
                height: 100,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 8.0),
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(description, softWrap: true),
              SizedBox(height: 8.0),
              Text(price, style: TextStyle(color: Colors.red)),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow),
                  Text('$rating ($reviewCount)'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

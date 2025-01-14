import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async'; // Import this for Timer
import '../../../core/config/constants.dart';

class DetailedList extends StatefulWidget {
  final String categoryId;
  DetailedList(this.categoryId);

  @override
  _DetailedListState createState() => _DetailedListState();
}

class _DetailedListState extends State<DetailedList> {
  List<dynamic> products = [];
  List<dynamic> categories = [];
  TextEditingController searchController = TextEditingController();
  Timer? _debounce;
  bool isLoadingProducts = true;  // Added this line
  bool isLoadingCategories = true; // Added this line

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

  Future<void> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('${backendUrl}/api/v1/product/category/${widget.categoryId}'));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['data'] != null) {
          setState(() {
            products = List<dynamic>.from(json['data']);
            isLoadingProducts = false; // Added this line
            print("Products loaded: ${products.length}");
          });
        } else {
          setState(() {
            isLoadingProducts = false; // Added this line
            print('No products found.');
          });
        }
      } else {
        setState(() {
          isLoadingProducts = false; // Added this line
          print('Error loading products: ${response.statusCode}');
        });
      }
    } catch (e) {
      setState(() {
        isLoadingProducts = false; // Added this line
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
          categories = List<dynamic>.from(json['data']);
          isLoadingCategories = false; // Added this line
        });
      } else {
        setState(() {
          isLoadingCategories = false; // Added this line
          print('Error loading categories: ${response.statusCode}');
        });
      }
    } catch (e) {
      setState(() {
        isLoadingCategories = false; // Added this line
        print('Connection error: $e');
      });
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
        fetchProducts(); // Fetch all products when the query is empty
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
      body: isLoadingProducts || isLoadingCategories  // Added this line
          ? Center(child: CircularProgressIndicator()) // Added this line
          : ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: SizedBox(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: _buildCategoryCard(
                      categories[index]['image_url'],
                      categories[index]['name'],
                    ),
                  );
                },
              ),
            ),
          ),
          Divider(),
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

  Widget _buildCategoryCard(String? imageUrl, String? title) {
    return Container(
      width: 170,
      child: Card(
        elevation: 4,
        shadowColor: Colors.grey.withOpacity(1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: Image.network(
                    imageUrl ?? 'https://via.placeholder.com/160x100',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(child: Icon(Icons.broken_image, size: 50));
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title ?? 'No Title',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(String imageUrl, String title, String description, String price, double rating, int reviewCount) {
    return Container(
      width: 220,
      height: 300,
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

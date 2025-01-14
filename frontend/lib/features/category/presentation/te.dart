// import 'package:flutter/material.dart';
// import 'package:frontend/features/category/presentation/te.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'dart:async'; // Import this for Timer
// import '../../../core/config/constants.dart';
// import 'catalogproducts.dart'; // Đảm bảo bạn đã nhập file chứa widget CatalogProducts
//
// class DetailedList extends StatefulWidget {
//   final String categoryId;
//   DetailedList(this.categoryId);
//
//   @override
//   _DetailedListState createState() => _DetailedListState();
// }
//
// class _DetailedListState extends State<DetailedList> {
//   List<dynamic> products = [];
//   TextEditingController searchController = TextEditingController();
//   Timer? _debounce; // Add a Timer to debounce the search
//
//   @override
//   void initState() {
//     super.initState();
//     fetchProducts();
//     searchController.addListener(onSearchChanged);
//   }
//
//   @override
//   void dispose() {
//     _debounce?.cancel();
//     searchController.removeListener(onSearchChanged);
//     searchController.dispose();
//     super.dispose();
//   }
//
//   Future<void> fetchProducts() async {
//     try {
//       final response = await http.get(Uri.parse('$backendUrl/api/v1/product/category/${widget.categoryId}'));
//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         setState(() {
//           products = json['data'].map((product) {
//             return {
//               'image_url': product['image_url'] ?? 'https://via.placeholder.com/160x100',
//               'name': product['name'] ?? 'No Name',
//               'description': product['description'] ?? 'No Description',
//               'price': product['price']?.toString() ?? 'No Price',
//               'rating': (product['rating']?.toDouble() ?? 0.0),
//               'reviewCount': (product['reviewCount'] ?? 0),
//             };
//           }).toList();
//         });
//       } else {
//         print('Error loading products: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Connection error: $e');
//     }
//   }
//
//   Future<void> searchProducts(String query) async {
//     try {
//       final response = await http.get(Uri.parse('$backendUrl/api/v1/search/product?query=$query'));
//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         List<dynamic> searchedProducts = json['data'].map((product) {
//           return {
//             'image_url': product['image_url'] ?? 'https://via.placeholder.com/160x100',
//             'name': product['name'] ?? 'No Name',
//             'description': product['description'] ?? 'No Description',
//             'price': product['price']?.toString() ?? 'No Price',
//             'rating': (product['rating']?.toDouble() ?? 0.0),
//             'reviewCount': (product['reviewCount'] ?? 0),
//           };
//         }).toList();
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => CatalogProducts(products: searchedProducts),
//           ),
//         );
//       } else {
//         print('Error loading products: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Connection error: $e');
//     }
//   }
//
//   void onSearchChanged() {
//     if (_debounce?.isActive ?? false) _debounce?.cancel();
//     _debounce = Timer(const Duration(milliseconds: 500), () {
//       final query = searchController.text;
//       if (query.isNotEmpty) {
//         searchProducts(query);
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: TextField(
//           controller: searchController,
//           decoration: InputDecoration(
//             hintText: 'Tìm kiếm',
//             prefixIcon: Icon(Icons.search),
//             filled: true,
//             fillColor: Colors.white,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(20),
//               borderSide: BorderSide.none,
//             ),
//           ),
//           style: TextStyle(color: Colors.black),
//         ),
//         backgroundColor: Color(0xFF3CABF3),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.shopping_cart),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: ListView(
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 16.0),
//             child: SizedBox(
//               height: 250,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: products.length,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                     child: Card(
//                       elevation: 4,
//                       shadowColor: Colors.grey.withOpacity(1),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: InkWell(
//                         onTap: () {
//                           // Handle card tap if needed
//                         },
//                         child: Container(
//                           width: 170,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.stretch,
//                             children: [
//                               Expanded(
//                                 child: ClipRRect(
//                                   borderRadius: const BorderRadius.only(
//                                     topLeft: Radius.circular(12),
//                                     topRight: Radius.circular(12),
//                                   ),
//                                   child: Image.network(
//                                     products[index]['image_url'],
//                                     fit: BoxFit.cover,
//                                     errorBuilder: (context, error, stackTrace) {
//                                       return Center(
//                                         child: Icon(Icons.broken_image, size: 50),
//                                       );
//                                     },
//                                     loadingBuilder: (context, child, loadingProgress) {
//                                       if (loadingProgress == null) return child;
//                                       return Center(
//                                         child: CircularProgressIndicator(),
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(
//                                   products[index]['name'],
//                                   style: const TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//           Divider(),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Wrap(
//               spacing: 20.0,
//               runSpacing: 20.0,
//               alignment: WrapAlignment.center,
//               children: products.map((product) {
//                 return _buildProductCard(
//                   product['image_url'],
//                   product['name'],
//                   product['description'],
//                   product['price'].toString() + 'đ',
//                   product['rating'].toDouble(),
//                   product['reviewCount'],
//                 );
//               }).toList(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildProductCard(String imageUrl, String title, String description, String price, double rating, int reviewCount) {
//     return Container(
//       width: 220,
//       height: 300,
//       child: Card(
//         elevation: 10,
//         shadowColor: Colors.grey.withOpacity(0.5),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Image.network(
//                 imageUrl ?? 'https://via.placeholder.com/160x100',
//                 width: 160,
//                 height: 100,
//                 fit: BoxFit.cover,
//               ),
//               SizedBox(height: 8.0),
//               Text(
//                 title ?? 'No Title',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 8.0),
//               Text(
//                 description ?? 'No Description',
//                 softWrap: true,
//               ),
//               SizedBox(height: 8.0),
//               Text(price ?? 'No Price', style: TextStyle(color: Colors.red)),
//               SizedBox(height: 8.0),
//               Row(
//                 children: [
//                   Icon(Icons.star, color: Colors.yellow),
//                   Text('${rating ?? 0.0} (${reviewCount ?? 0})'),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

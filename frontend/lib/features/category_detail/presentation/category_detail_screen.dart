import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart' as custom_carousel;
import 'package:frontend/features/category_detail/presentation/CartPage.dart';
import 'package:frontend/features/category_detail/presentation/DetailedDescriptionPage.dart';
import 'package:frontend/features/category_detail/presentation/UsageGuidePage.dart';
import 'package:intl/intl.dart';
import 'package:frontend/features/category_detail/presentation/WriteReviewScreen.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int quantity = 1; // Số lượng sản phẩm mặc định
  bool isExpanded = false; // Trạng thái kiểm tra việc mở rộng
  bool isLiked = false; // Trạng thái "thích" sản phẩm

  String formatCurrency(int value) {
    final formatter = NumberFormat.currency(
      locale: 'vi_VN', // Định dạng theo chuẩn Việt Nam
      symbol: '', // Không thêm ký hiệu tiền tệ
      decimalDigits: 0, // Không có số thập phân
    );
    return formatter.format(value);
  }

  @override
  Widget build(BuildContext context) {
    final List<String> imageUrls = [
      'assets/product_1.png',
      'assets/product_2.png',
      'assets/product_3.png',
      'assets/product_4.png',
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Quay lại màn hình trước
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(
              isLiked ? Icons.favorite : Icons.favorite_border,
              color: isLiked ? Colors.red : Colors.black,
            ),
            onPressed: () {
              setState(() {
                isLiked = !isLiked; // Thay đổi trạng thái "thích"
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(isLiked
                      ? "Đã thêm vào danh sách yêu thích"
                      : "Đã bỏ yêu thích"),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Carousel với ảnh sản phẩm
            Stack(
              children: [
                custom_carousel.CarouselSlider(
                  items: imageUrls.map((imageUrl) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(0), // Bo tròn góc
                      child: Image.asset(
                        imageUrl,
                        width: double.infinity,
                        height: 300, // Điều chỉnh chiều cao
                        fit: BoxFit.cover, // Đảm bảo ảnh không bị méo
                      ),
                    );
                  }).toList(),
                  options: custom_carousel.CarouselOptions(
                    height: 300, // Điều chỉnh chiều cao cho carousel
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                    viewportFraction: 1.0, // Full width cho mỗi ảnh
                  ),
                ),
                // Giá hiển thị dưới carousel
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    color: Colors.grey.shade200,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "1.480.000đ",
                        style: TextStyle(
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
            // Tên sản phẩm
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const Text(
                "Kem Dưỡng Obagi Retinol 1.0% Trẻ Hóa Da, Ngừa mụn 28g",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            // Đánh giá
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: const [
                  Icon(Icons.star, color: Colors.orange, size: 16),
                  Text("4.0", style: TextStyle(fontSize: 14)),
                  SizedBox(width: 4),
                  Text("(12 đánh giá)", style: TextStyle(color: Colors.blue)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Dung tích
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Dung tích (2):", style: TextStyle(fontSize: 16)),
                  Text("28g", style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Số lượng
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
                  const Text("Số lượng:", style: TextStyle(fontSize: 16)),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (quantity > 1) quantity--;
                          });
                        },
                      ),
                      Text("$quantity", style: TextStyle(fontSize: 16)),
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
            // Expansion tiles cho mô tả sản phẩm, hướng dẫn sử dụng, thành phần
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DetailedDescriptionPage(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "Obagi 360 Retinol Cream là sản phẩm kem dưỡng da trẻ hoá, ngừa mụn nổi tiếng từ thương hiệu dược mỹ phẩm Obagi. Công thức với hàm lượng Retinol 0.5% / Retinol 1% hoạt động hiệu quả trên mọi làn da, đặc biệt là da dầu, giúp cải thiện các vấn đề về da như mụn, dầu thừa, lão hoá; mang đến cho bạn làn da mịn màng và tươi trẻ.",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: const Text("Hướng dẫn sử dụng",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UsageGuidePage(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "Lấy lượng kem dưỡng bằng hạt đậu hoặc theo chỉ dẫn, dùng đầu ngón tay thoa đều kem lên da mặt, bắt đầu từ cằm theo hướng từ dưới lên trên từ trong ra ngoài.\n\n",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WriteReviewScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
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
            // Gợi ý sản phẩm
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const Text(
                "Gợi ý cho bạn",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            // Danh sách sản phẩm gợi ý
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              height: 400, // Chiều cao của danh sách sản phẩm gợi ý
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Hai sản phẩm mỗi hàng
                  crossAxisSpacing: 13, // Khoảng cách ngang giữa các sản phẩm
                  mainAxisSpacing: 13, // Khoảng cách dọc giữa các sản phẩm
                  childAspectRatio: 0.7, // Tỷ lệ giữa chiều rộng và chiều cao
                ),
                itemCount: 6, // Số lượng sản phẩm gợi ý
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Hình ảnh sản phẩm
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/product_${index + 1}.png',
                          width: 230, // Chiều rộng mới
                          height: 240, // Chiều cao mới
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Tên sản phẩm
                      Text(
                        "Sản phẩm ${index + 1}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Đánh giá
                      Row(
                        children: const [
                          Icon(Icons.star, color: Colors.orange, size: 16),
                          Text("4.0", style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      // Giá sản phẩm
                      const Text(
                        "1.000.000đ",
                        style: TextStyle(fontSize: 12, color: Colors.red),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8.0),
        color: Colors.grey.shade200,
        child: Row(
          children: [
            // Nút thêm vào giỏ hàng
            Expanded(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Đơn hàng đã được thêm vào giỏ hàng")),
                  );
                },
                icon: const Icon(Icons.add_shopping_cart, color: Colors.white),
                label: const Text("Thêm vào giỏ hàng",
                    style: TextStyle(fontSize: 14, color: Colors.white)),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
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
                                        '${formatCurrency(1480000 * quantity)}đ', // Áp dụng định dạng
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
                                    child: Image.asset(
                                      'assets/product_1.png', // Đổi theo hình ảnh sản phẩm
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
                                  // Hai nút "Thêm vào giỏ hàng" và "Mua online"
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton.icon(
                                          onPressed: () {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    "Đơn hàng đã được thêm vào giỏ hàng, Số lượng: $quantity, Tổng giá: ${(1480000 * quantity).toString()}đ"),
                                              ),
                                            );
                                          },
                                          icon: const Icon(
                                              Icons.add_shopping_cart,
                                              color: Colors.white),
                                          label: const Text("Thêm vào giỏ hàng",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blue,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 16),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                          width:
                                              16), // Khoảng cách giữa hai nút
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            // Xử lý mua hàng
                                            Navigator.pop(
                                                context); // Đóng modal
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'Cảm ơn bạn đã đặt hàng!'),
                                              ),
                                            );
                                          },
                                          child: const Text(
                                            'MUA ONLINE',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 16),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
                  'MUA ONLINE',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
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
    );
  }
}

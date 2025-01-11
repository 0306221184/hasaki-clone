import 'package:flutter/material.dart';

class WriteReviewScreen extends StatefulWidget {
  const WriteReviewScreen({super.key});

  @override
  State<WriteReviewScreen> createState() => _WriteReviewScreenState();
}

class _WriteReviewScreenState extends State<WriteReviewScreen> {
  int selectedStar = 0;

  final List<String> reviewTexts = [
    "Rất tệ",
    "Tệ",
    "Bình thường",
    "Tốt",
    "Rất tốt"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Viết đánh giá',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Thông tin sản phẩm
            Row(
              children: [
                Image.asset(
                  'assets/product_1.png',
                  width: 60,
                  height: 60,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        '1.480.000đ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        'Kem Dưỡng Obagi Retinol 1.0%\nTrẻ Hóa Da, Ngừa mụn 28g',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Ngôi sao đánh giá
            const Text(
              'Chạm vào ngôi sao để đánh giá',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  onPressed: () {
                    setState(() {
                      selectedStar = index + 1;
                    });
                  },
                  icon: Icon(
                    Icons.star,
                    size: 32,
                    color: index < selectedStar ? Colors.red : Colors.grey,
                  ),
                );
              }),
            ),
            const SizedBox(height: 8),
            // Hiển thị đánh giá text
            Text(
              selectedStar > 0 ? reviewTexts[selectedStar - 1] : '',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            // Nút gửi đánh giá
            ElevatedButton(
              onPressed: selectedStar > 0
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Bạn đã gửi đánh giá ${selectedStar} sao: ${reviewTexts[selectedStar - 1]}'),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Gửi đánh giá',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

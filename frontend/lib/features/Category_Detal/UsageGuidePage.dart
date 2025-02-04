import 'package:flutter/material.dart';

class UsageGuidePage extends StatelessWidget {
  const UsageGuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hướng dẫn sử dụng',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          "Lấy lượng kem dưỡng bằng hạt đậu hoặc theo chỉ dẫn, dùng đầu ngón tay thoa đều kem lên da mặt, bắt đầu từ cằm theo hướng từ dưới lên trên từ trong ra ngoài.",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
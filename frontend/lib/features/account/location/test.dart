import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressUpdater extends StatefulWidget {
  @override
  _AddressUpdaterState createState() => _AddressUpdaterState();
}

class _AddressUpdaterState extends State<AddressUpdater> {
  String? selectedCity;
  String? selectedDistrict;
  String _address = 'Vui lòng nhập vị trí của bạn';

  @override
  void initState() {
    super.initState();
    _loadSavedAddress();
  }

  // Load saved address from local storage
  Future<void> _loadSavedAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _address = prefs.getString('saved_address') ?? 'Vui lòng nhập vị trí của bạn';
    });
  }

  // Save the address persistently
  Future<void> _saveAddress(String address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved_address', address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cập nhật địa chỉ'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Chọn Quận/Thành phố:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: selectedCity,
              hint: const Text('Chọn thành phố'),
              items: <String>['Hà Nội', 'TP. Hồ Chí Minh', 'Đà Nẵng']
                  .map((String city) {
                return DropdownMenuItem<String>(
                  value: city,
                  child: Text(city),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCity = newValue;
                });
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Chọn Phường/Xã:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: selectedDistrict,
              hint: const Text('Chọn phường/xã'),
              items: <String>['Phường 1', 'Phường 2', 'Phường 3']
                  .map((String district) {
                return DropdownMenuItem<String>(
                  value: district,
                  child: Text(district),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedDistrict = newValue;
                });
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  String message;

                  // Validate inputs and update address
                  if (selectedCity == null && selectedDistrict == null) {
                    message = 'Vui lòng nhập đầy đủ nội dung';
                  } else if (selectedCity == null) {
                    message = 'Vui lòng chọn Quận/Thành phố';
                  } else if (selectedDistrict == null) {
                    message = 'Vui lòng chọn Phường/Xã';
                  } else {
                    // Update address and save it persistently
                    _address = 'Địa chỉ: $selectedDistrict, $selectedCity';
                    message = 'Địa chỉ đã được cập nhật';
                    _saveAddress(_address);
                  }

                  // Show confirmation dialog
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Thông báo'),
                        content: Text(message),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Đóng'),
                          ),
                        ],
                      );
                    },
                  );
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: const Text(
                'Xác nhận',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              _address,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

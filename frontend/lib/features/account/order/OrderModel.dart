import 'package:flutter/material.dart';

class OrderProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _orderItems = [];
  final List<Map<String, dynamic>> cancelledOrders = [];

  List<Map<String, dynamic>> get orderItems => _orderItems;

  void addToOrder(Map<String, dynamic> product) {
    _orderItems.add(product);
    notifyListeners();
  }


  void removeFromOrder(int index) {
    final cancelledOrder = orderItems.removeAt(index);
    cancelledOrders.add(cancelledOrder);
    notifyListeners();
  }
}

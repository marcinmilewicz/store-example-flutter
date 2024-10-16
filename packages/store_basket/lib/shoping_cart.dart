import 'package:flutter/material.dart';

import 'product.dart';

class ShoppingCart extends ValueNotifier<List<Product>> {
  final Map<int, int> _cart = {};

  ShoppingCart() : super([]);

  void addProduct(Product product) {
    print('Adding product: ${product.name}');
    if (!value.any((p) => p.id == product.id)) {
      value.add(product);
    }

    if (_cart.containsKey(product.id)) {
      _cart[product.id] = _cart[product.id]! + 1;
    } else {
      _cart[product.id] = 1;
    }

    notifyListeners();
  }

  void removeProduct(int productId) {
    if (_cart.containsKey(productId) && _cart[productId]! > 0) {
      _cart[productId] = _cart[productId]! - 1;
      if (_cart[productId] == 0) {
        _cart.remove(productId);
        value.removeWhere((element) => element.id == productId);
      }
    }

    notifyListeners();
  }

  void increment(int productId) {
    if (_cart.containsKey(productId)) {
      _cart[productId] = _cart[productId]! + 1;

      notifyListeners();
    }
  }

  double getTotalPrice() {
    double total = 0.0;
    _cart.forEach((productId, quantity) {
      final product = value.firstWhere((p) => p.id == productId);
      total += product.price * quantity;
    });
    return total;
  }

  List<Product> get products => value;

  Map<int, int> get cart => _cart;
}

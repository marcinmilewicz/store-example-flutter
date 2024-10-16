import 'package:flutter/material.dart';

import 'product.dart';

class ShoppingCart extends ValueNotifier<List<Product>> {
  final void Function(String name, Object data)? onBroadcast;
  final Map<int, int> _cart = {};

  ShoppingCart(this.onBroadcast) : super([]);

  void addProduct(Product product) {
    if (!value.any((p) => p.id == product.id)) {
      value.add(product);
      _broadcastEvent('[StoreBasket] Product added', product.id);
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
      _broadcastEvent('[StoreBasket] Product decremented', productId);
      if (_cart[productId] == 0) {
        _cart.remove(productId);
        value.removeWhere((element) => element.id == productId);
        _broadcastEvent('[StoreBasket] Product removed from basket', productId);
      }
    }

    notifyListeners();
  }

  void increment(int productId) {
    if (_cart.containsKey(productId)) {
      _cart[productId] = _cart[productId]! + 1;

      _broadcastEvent('[StoreBasket] Product incremented', productId);
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

  void _broadcastEvent(String name, int productId) {
    if (onBroadcast != null) {
      onBroadcast!(name, value.firstWhere((element) => element.id == productId));
    }
  }

  List<Product> get products => value;

  Map<int, int> get cart => _cart;
}

import 'product.dart';

class ShoppingCart {
  final List<Product> _products;
  final Map<int, int> _cart = {};

  // Konstruktor przyjmujący listę produktów
  ShoppingCart(this._products);

  void addProduct(int productId) {
    if (_cart.containsKey(productId)) {
      _cart[productId] = _cart[productId]! + 1;
    } else {
      _cart[productId] = 1;
    }
  }

  void removeProduct(int productId) {
    if (_cart.containsKey(productId) && _cart[productId]! > 0) {
      _cart[productId] = _cart[productId]! - 1;
      if (_cart[productId] == 0) {
        _cart.remove(productId);
      }
    }
  }

  double getTotalPrice() {
    double total = 0.0;
    _cart.forEach((productId, quantity) {
      final product = _products.firstWhere((p) => p.id == productId);
      total += product.price * quantity;
    });
    return total;
  }

  List<Product> get products => _products;

  Map<int, int> get cart => _cart;
}
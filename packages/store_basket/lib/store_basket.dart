library store_basket;

import 'package:flutter/material.dart';
import 'product.dart';

import 'shoping_cart.dart';

class StoreBasketWidget extends StatefulWidget {
  final List<Product> products; // Dodaj pole do przechowywania produktów

  StoreBasketWidget(
      {required this.products}); // Konstruktor z wymaganym argumentem
  @override
  _StoreBasketWidgetState createState() => _StoreBasketWidgetState();
}

class _StoreBasketWidgetState extends State<StoreBasketWidget> {
  late final ShoppingCart shoppingCart;

  @override
  void initState() {
    super.initState();
    shoppingCart = ShoppingCart(widget.products); // Inicjalizacja koszyka z produktami
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: shoppingCart.products.length,
              itemBuilder: (context, index) {
                final product = shoppingCart.products[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  elevation: 4,
                  child: ListTile(
                    title: Text(
                      product.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () => setState(
                              () => shoppingCart.removeProduct(product.id)),
                        ),
                        Text(shoppingCart.cart[product.id]?.toString() ?? '0'),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => setState(
                              () => shoppingCart.addProduct(product.id)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Price:',
                      style: TextStyle(fontSize: 14), // Smaller font size
                    ),
                    Text(
                      '\$${shoppingCart.getTotalPrice().toStringAsFixed(2)}',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight:
                              FontWeight.bold), // Slightly smaller font size
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Order"),
                      content: Text("Your order has been placed!"),
                      actions: [
                        TextButton(
                          child: Text("OK"),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Place Order'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                textStyle: TextStyle(fontSize: 18), // Larger button text
              ),
            ),
          ),
        ],
      ),
    );
  }
}

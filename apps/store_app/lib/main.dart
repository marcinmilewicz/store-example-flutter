import 'dart:math';

import 'package:flutter/material.dart';
import 'package:store_basket/product.dart';
import 'package:store_basket/store_basket.dart';

void main() {
  runApp(MyApp());
}

ThemeData getApplicationTheme() {
  return ThemeData(
    cardTheme: const CardTheme(
      color: Color(0x92DDFFAA),
      shadowColor: Colors.transparent,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0x92DDFFAA),
        textStyle: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final GlobalKey<StoreBasketState> _storeBasketKey =
      GlobalKey<StoreBasketState>();

  void addProduct(Product product) {
    final storeBasketState = _storeBasketKey.currentState;
    storeBasketState?.shoppingCart.addProduct(product);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Store Basket')),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      addProduct(
                          Product(id: 1, name: "Product A", price: 10.0));
                    },
                    child: const Text('Product A'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      addProduct(
                          Product(id: 2, name: "Product B", price: 15.0));
                    },
                    child: const Text("Product B"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      addProduct(
                          Product(id: 3, name: "Product C", price: 20.0));
                    },
                    child: const Text('Product C'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: StoreBasket(key: _storeBasketKey),
            ),
          ],
        ),
      ),
      theme: getApplicationTheme(),
    );
  }
}

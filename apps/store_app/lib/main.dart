import 'package:flutter/material.dart';
import 'package:store_basket/product.dart';
import 'package:store_basket/store_basket.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Przykładowa lista produktów
    List<Product> products = [
      Product(id: 1, name: "Product A", price: 10.0),
      Product(id: 2, name: "Product B", price: 15.0),
      Product(id: 3, name: "Product C", price: 20.0),
    ];

    return MaterialApp(
      home: StoreBasketWidget(products: products), // Przekazanie listy produktów
    );
  }
}
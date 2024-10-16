library store_basket;

import 'package:flutter/material.dart';
import 'package:store_basket/product.dart';
import 'shoping_cart.dart';

class StoreBasket extends StatefulWidget {
  const StoreBasket({Key? key}) : super(key: key);

  @override
  StoreBasketState createState() => StoreBasketState();
}

class StoreBasketState extends State<StoreBasket> {
  late final ShoppingCart shoppingCart;

  @override
  void initState() {
    super.initState();
    shoppingCart = ShoppingCart();
  }

  ShoppingCart getShoppingCart() {
    return shoppingCart;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ValueListenableBuilder<List<Product>>(
              valueListenable: shoppingCart,
              builder: (context, cart, child) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: cart.length,
                        itemBuilder: (context, index) {
                          final product = cart[index];
                          return Card(
                            margin: const EdgeInsets.all(8.0),
                            elevation: 4,
                            child: ListTile(
                              title: Text(
                                product.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                  'PLN ${product.price.toStringAsFixed(2)}'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () => setState(() =>
                                        shoppingCart.removeProduct(product.id)),
                                  ),
                                  Text(shoppingCart.cart[product.id]
                                          ?.toString() ??
                                      '0'),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () => setState(() =>
                                        shoppingCart.increment(product.id)),
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
                              const Text(
                                'Total Price:',
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                'PLN ${shoppingCart.getTotalPrice().toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
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
                      title: const Text("Order"),
                      content: const Text("Your order has been placed!"),
                      actions: [
                        TextButton(
                          child: const Text("OK"),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: 32.0, vertical: 16.0),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text(
                'Place Order',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

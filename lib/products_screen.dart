import 'package:flutter/material.dart';
import 'package:yummy_snack_shop/product.dart';
import 'product_details_screen.dart';

final List<Product> products = [
  Product(
    title: 'Chips',
    imageUrl: 'assets/images/chips.png',
    description: 'Crispy and delicious potato chips.',
    price: 2.99,
    quantity: 50,
  ),
  Product(
    title: 'Cookies',
    imageUrl: 'assets/images/cookies.png',
    description: 'Soft and chewy chocolate chip cookies.',
    price: 3.49,
    quantity: 30,
  ),
  Product(
    title: 'Soda',
    imageUrl: 'assets/images/soda.png',
    description: 'Refreshing soda beverage.',
    price: 1.99,
    quantity: 100,
  ),
  // Add more products as needed
];

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Snack Shop'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailsScreen(product: product),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        product.imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(product.title),
                    subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

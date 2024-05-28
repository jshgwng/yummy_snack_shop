import 'package:flutter/material.dart';
import 'home_screen.dart'; // Import the product model
import 'cart_service.dart'; // Import the cart service

class ReceiptScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receipt'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Thank you for your purchase!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Items Purchased:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: CartService.cartItems.length,
                itemBuilder: (context, index) {
                  final product = CartService.cartItems[index];
                  return ListTile(
                    title: Text(product.title),
                    subtitle: Text('Ugx ${product.price.toStringAsFixed(2)}'),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Total: Ugx ${CartService.getTotalPrice().toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                      (Route<dynamic> route) => false, // Prevent going back to previous screens
                );
                CartService.clearCart();
              },
              child: Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}

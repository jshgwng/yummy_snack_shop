import 'package:flutter/material.dart';
import 'receipt_screen.dart'; // Import the receipt screen
import 'home_screen.dart'; // Import the product model
import 'cart_service.dart'; // Import the cart service

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: CartService.cartItems.length,
              itemBuilder: (context, index) {
                final product = CartService.cartItems[index];
                return ListTile(
                  title: Text(product.title),
                  subtitle: Text('Ugx ${product.price.toStringAsFixed(2)}'),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle),
                    onPressed: () {
                      CartService.removeFromCart(product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Removed ${product.title} from cart'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: \$${CartService.getTotalPrice().toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to receipt screen after checkout
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ReceiptScreen()),
                    );
                  },
                  child: Text('Checkout'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yummy_snack_shop/product.dart';
import 'package:yummy_snack_shop/signup_screen.dart';
import 'auth_service.dart';
import 'login_screen.dart';
import 'product_details_screen.dart';

final List<Product> products = [
  Product(
    title: 'Chips',
    imageUrl: 'assets/images/3.jpg',
    description: 'Crispy and delicious potato chips.',
    price: 3000,
    quantity: 50,
  ),
  Product(
    title: 'Cookies',
    imageUrl: 'assets/images/2.jpg',
    description: 'Soft and chewy chocolate chip cookies.',
    price: 3500,
    quantity: 30,
  ),
  Product(
    title: 'Soda',
    imageUrl: 'assets/images/1.jpg',
    description: 'Refreshing soda beverage.',
    price: 1500,
    quantity: 100,
  ),
  // Add more products as needed
];

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final currentUser = authService.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          if (currentUser != null)
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                authService.logout();
              },
            ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (currentUser == null) ...[
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => LoginScreen()));
                },
                child: Text('Login'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => SignupScreen()));
                },
                child: Text('Sign Up'),
              ),
            ] else ...[
              Expanded(
                  child: Padding(
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
                            builder: (context) =>
                                ProductDetailsScreen(product: product),
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
                                offset:
                                    Offset(0, 3), // changes position of shadow
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
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ))
            ],
          ],
        ),
      ),
    );
  }
}

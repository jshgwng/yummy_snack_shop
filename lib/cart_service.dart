import 'package:flutter/material.dart';
import 'package:yummy_snack_shop/product.dart';

class CartService {
  static List<Product> _cartItems = [];

  static List<Product> get cartItems => _cartItems;

  static void addToCart(Product product) {
    _cartItems.add(product);
  }

  static void removeFromCart(Product product) {
    _cartItems.remove(product);
  }

  static double getTotalPrice() {
    double total = 0;
    for (var item in _cartItems) {
      total += item.price;
    }
    return total;
  }

  static void clearCart() {
    _cartItems.clear();
  }
}

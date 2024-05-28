import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yummy_snack_shop/products_screen.dart';
import 'auth_service.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, AsyncSnapshot<SharedPreferences> snapshot) {
        if (!snapshot.hasData) {
          return MaterialApp(
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
          );
        }

        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AuthService()),
          ],
          child: MaterialApp(
            title: 'Local Storage Auth Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: AuthWrapper(),
            routes: {
              '/home': (context) => HomeScreen(),
              '/login': (context) => LoginScreen(),
              '/signup': (context) => SignupScreen(),
              '/products': (context) => ProductsScreen(),
            },
          ),
        );
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final currentUser = authService.currentUser;

    if (currentUser == null) {
      return LoginScreen();
    } else {
      return HomeScreen();
    }
  }
}

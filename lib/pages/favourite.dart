import 'package:flutter/material.dart';
import 'package:splash_screen_project/pages/home.dart';

class FavoritesPage extends StatelessWidget {
  final List<Map<String, String>> favoriteProducts;

  const FavoritesPage({required this.favoriteProducts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          icon: Icon(Icons.navigate_before),
        ),
        title: Text('Favorites'),
      ),
      body: favoriteProducts.isEmpty
          ? Center(child: Text('No favorites yet!'))
          : ListView.builder(
              itemCount: favoriteProducts.length,
              itemBuilder: (context, index) {
                final product = favoriteProducts[index];
                return ListTile(
                  leading: Image.asset(product['image']!),
                  title: Text(product['name']!),
                  subtitle: Text(product['price']!),
                );
              },
            ),
    );
  }
}

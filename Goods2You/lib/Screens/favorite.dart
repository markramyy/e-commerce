import 'package:flutter/material.dart';
import 'package:ecommerce/database/DatabaseHelper.dart';
// Import your DatabaseHelper class

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final dbHelper = DatabaseHelper.instance;

  Future<List<Map<String, dynamic>>> _getFavoriteProducts() async {
    final db = await dbHelper.database;
    return await db.query('favorites');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _getFavoriteProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final favoriteProducts = snapshot.data!;
          // Build your UI using favoriteProducts
          return ListView.builder(
            itemCount: favoriteProducts.length,
            itemBuilder: (context, index) {
              final productId = favoriteProducts[index]['productId'];
              // You can retrieve product details using this productId
              return ListTile(
                title: Text('Product $productId'), // Display product details
              );
            },
          );
        } else {
          return Center(child: CircularProgressIndicator()); // Loading state
        }
      },
    );
  }
}

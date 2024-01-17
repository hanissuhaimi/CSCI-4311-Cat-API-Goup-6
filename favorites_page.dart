import 'package:flutter/material.dart';
import 'cat_model.dart';
import 'image_page.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Cats'),
      ),
      body: ListView.builder(
        itemCount: Cat.favorites.length,
        itemBuilder: (context, index) {
          final cat = Cat.favorites[index];
          return ListTile(
            title: Text(cat.id),
            leading: Image.network(cat.imageUrl),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImagePage(cat: cat),
                ),
              );
            },
          );
        },
      ),
    );
  }
}


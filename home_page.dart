import 'package:flutter/material.dart';
import 'cat_service.dart';
import 'cat_model.dart';
import 'favorites_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CatService _catService = CatService();
  Cat? cat; // Declare cat variable as nullable
  bool showNextImageButton = true; // Track if the "Next Image" button should be shown
  bool initialLikePressed = false; // Flag to track the initial like button press
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CATture'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: FutureBuilder(
              future: _catService.fetchRandomCat(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  cat = snapshot.data as Cat?;
                  return Image.network(
                    cat?.imageUrl ?? '', // Use null-aware operator to handle null
                    fit: BoxFit.cover, // Ensure the image covers the entire space
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(
                    cat?.isLiked == true ? Icons.favorite : Icons.favorite_border,
                    color: cat?.isLiked == true ? Colors.red : null,
                  ),
                  onPressed: () {
                    setState(() {
                      if (cat != null && !initialLikePressed) {
                        cat!.isLiked = true;
                        Cat.favorites.add(cat!);
                        initialLikePressed = true;
                      } else if (cat != null) {
                        cat!.isLiked = !cat!.isLiked;
                        if (cat!.isLiked) {
                          Cat.favorites.add(cat!);
                        } else {
                          Cat.favorites.remove(cat!);
                        }
                      }
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          cat?.isLiked == true ? 'Added to Favorites' : 'Removed from Favorites',
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                _fetchNextImage();
              },
              child: Text('Next Image'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoritesPage(),
                  ),
                );
              },
              child: Text('View Favorites'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _fetchNextImage() async {
    // Reset initial like button press flag
    initialLikePressed = false;

    // Fetch the next random cat image
    cat = await _catService.fetchRandomCat();

    setState(() {
      // Show the "Next Image" button
      showNextImageButton = true;
    });
  }
}



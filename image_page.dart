import 'package:flutter/material.dart';
import 'cat_model.dart';

class ImagePage extends StatefulWidget {
  final Cat cat;

  const ImagePage({Key? key, required this.cat}) : super(key: key);

  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cat Details'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(widget.cat.imageUrl),
          SizedBox(height: 20),
          Text('ID: ${widget.cat.id}'),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                widget.cat.isLiked = !widget.cat.isLiked;
                if (widget.cat.isLiked) {
                  Cat.favorites.add(widget.cat);
                } else {
                  Cat.favorites.remove(widget.cat);
                }
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    widget.cat.isLiked ? 'Added to Favorites' : 'Removed from Favorites',
                  ),
                ),
              );
            },
            child: Text(widget.cat.isLiked ? 'Remove from Favorites' : 'Add to Favorites'),
          ),
          
        ],
      ),
    );
  }
}


class Cat {
  String id;
  String imageUrl;
  bool isLiked;

  Cat({required this.id, required this.imageUrl, this.isLiked = false});

  factory Cat.fromJson(Map<String, dynamic> json) {
    return Cat(
      id: json['id'],
      imageUrl: json['url'],
    );
  }
  
  static List<Cat> favorites = [];
}


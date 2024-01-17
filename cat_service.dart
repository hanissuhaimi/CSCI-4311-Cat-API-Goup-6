import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api.dart';
import 'cat_model.dart';

class CatService {
  Future<Cat> fetchRandomCat() async {
    final response = await http.get(Uri.parse('$apiUrl/images/search'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return Cat.fromJson({
        'id': data[0]['id'],
        'url': data[0]['url'],
      });
    } else {
      throw Exception('Failed to load cat');
    }
  }
}


import 'dart:convert';

import 'package:the_cats_shop_app/models/cat_model.dart';
import 'package:http/http.dart' as http;

class CatsData {
  Future<List<CatModel>> getCats() async {
    final response = await http.get(
      Uri.parse('https://api.thecatapi.com/v1/images/?limit=10'),
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': '17d94b92-754f-46eb-99a0-65be65b5d18f',
      },
    );

    if (response.statusCode == 200) {
      return List.from(jsonDecode(response.body)).map(
        (catJson) {
          return CatModel.fromJson(catJson as Map<String, dynamic>);
        },
      ).toList();
    } else {
      throw Exception('Error');
    }
  }
}

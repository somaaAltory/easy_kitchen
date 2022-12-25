import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:easy_kitchen/models/recipe.dart';

class RecipeApi {
  static Future<List<Recipe>> getRecipe() async {
    var uri = Uri.https('tasty.p.rapidapi.com', '/recipes/list',
        {"from": "0", "size": "60"});

    final response = await http.get(uri, headers: {
      'X-RapidAPI-Key':  '2e4b91b8dfmshb11fed5f017c976p136391jsn351cba2a7f23',
      "x-rapidapi-host": "tasty.p.rapidapi.com",
      "useQueryString": "true"
    });

    Map data = jsonDecode(response.body);
    List _temp = [];

    for (var i in data['results']) {
      _temp.add(i['content']['details']);
    }

    return Recipe.recipesFromSnapshot(_temp);
  }
}
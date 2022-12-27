import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:easy_kitchen/models/recipe.dart';

class RecipeApi {
  static Future<List<Recipe>> getRecipe() async {
    //var uri = Uri.https('api.spoonacular.com/recipes/complexSearch/?apiKey=b5f902c80b7a4f4e9ced7fd3ca8224cc&number=20');

    final response = await http.get(Uri.parse(
        'https://api.spoonacular.com/recipes/complexSearch/?apiKey=b13abb543b844c47b376b12b186fdd6a&number=3'));
    //  headers:{ "Accept-Encoding": "gzip,deflate,compress" });


    Map data = jsonDecode(response.body);
    List _temp = [];

    //print(data);

    for (var i in data['results']) {
      int id =i['id'];
       var url_recipe = 'https://api.spoonacular.com/recipes/${id}/information?apiKey=b13abb543b844c47b376b12b186fdd6a';
       var response_recipe = await http.get(Uri.parse(url_recipe));

       Map recipe_data=jsonDecode(response_recipe.body);
       var recipe={
         'title' :recipe_data['title'],
         'id':i['id'],
         'image':recipe_data['image'],
         'extendedIngredients' :recipe_data['extendedIngredients']
       };

      _temp.add(recipe);

    }


    return Recipe.recipesFromSnapshot(_temp);
  }

}
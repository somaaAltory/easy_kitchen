import 'dart:convert';
import 'dart:io';

import 'package:easy_kitchen/features/pantry/models/ingredient.dart';
import 'package:easy_kitchen/features/recipes/api/spoonacular_api.dart';
import 'package:easy_kitchen/features/recipes/models/recipe.dart';
import 'package:easy_kitchen/features/recipes/models/recipeListItem.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../authentication/data/firebase_auth_repository.dart';
import '../../pantry/data/ingredients_repository.dart';

class RecipeRepository {
  final http.Client _client;
  final SpoonaCularAPI _spoonaCularAPI;

  RecipeRepository(this._client, this._spoonaCularAPI);

  Future<Recipe> getRecipeDetails(int id) =>
      _getData(
          uri: _spoonaCularAPI.recipesDetails(id),
          builder: (data) => Recipe.fromJson(data));

  Future<List<RecipeListItem>> getRecipes(int recipesNumber,
      String ingredients) async {
    try {
      final uri = _spoonaCularAPI.getRecipeByIngredients(recipesNumber, ingredients);
      return _getData(
        uri: uri,
        builder: (data) => RecipeListItem.recipeListFromJson(data),
      );
    } catch (e) {
      print('Error getting recipes: $e');
       return Future.error('Error getting recipes: $e');
    }

  }

  Future<List<RecipeListItem>> getRecipesComplex(int recipesNumber,
      String ingredients,String diet) async {
    try {
      final uri = _spoonaCularAPI.searchRecipes(recipesNumber, ingredients,diet);
      return _getData(
        uri: uri,
        builder: (data) => RecipeListItem.recipeListComplexFromJson(data),
      );
    } catch (e) {
      print('Error getting recipes: $e');
      return Future.error('Error getting recipes: $e');
    }

  }

  Future<T> _getData<T>({
    required Uri uri,
    required T Function(dynamic data) builder,
  }) async {
    // try {
      final response = await _client.get(uri);
      // switch (response.statusCode) {
      //   case 200:
          final data = json.decode(response.body);
          return builder(data);
        //case 401:
          throw Exception("Unauthorized");
       // case 404:
          throw Exception("Not found!");
      //  default:
          throw Exception("UnKnown");
      // }
    // } on SocketException catch (_) {
    //   rethrow;
    // }
  }
}
  final recipeRepositoryProvider=Provider<RecipeRepository>((ref){
    return RecipeRepository(http.Client(), SpoonaCularAPI());
  });

   Future<String> convertListItemToString(Future<List<Ingredient>> ingredientsList) async{
    var ingredient = await ingredientsList;
    String ingredients="";
    for (int i=0;i<ingredient.length;i++) {
      if (i!=ingredient.length-1){
        ingredients += "${ingredient[i].name!},+";
      }
      else {
        ingredients += ingredient[i].name!;
      }
    }
    return ingredients;
  }

  final recipesByIngredientsProvider = Provider <Future<List<RecipeListItem>>>((ref) async {
    final user = ref.read(authRepositoryProvider).currentUser;
    final recipeRepository=ref.watch(recipeRepositoryProvider);
    if (user == null) {
      throw AssertionError('User can\'t be null');
    }
    final repository = ref.watch(ingredientsRepositoryProvider);
      var fetchIngredients = repository.fetchIngredients(uid: user.uid);

       var listItemToString = convertListItemToString(fetchIngredients);

       String ingredientsAsString = await listItemToString;
    // print("this is the fetchIngredients : $ingredientsAsString");
       return recipeRepository.getRecipes(4 , ingredientsAsString);
  });





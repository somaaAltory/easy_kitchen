import 'dart:convert';
import 'dart:io';

import 'package:easy_kitchen/features/pantry/models/ingredient.dart';
import 'package:easy_kitchen/features/recipes/api/spoonacular_api.dart';
import 'package:easy_kitchen/features/recipes/models/recipeListItem.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../../models/recipe.dart';
import '../../authentication/data/firebase_auth_repository.dart';
import '../../pantry/data/ingredients_repository.dart';
import '../models/recipeList.dart';

class RecipeRepository {
  final http.Client _client;
  final SpoonaCularAPI _spoonaCularAPI;

  RecipeRepository(this._client, this._spoonaCularAPI);

  Future<Recipe> getRecipeDetails(String id) =>
      _getData(
          uri: _spoonaCularAPI.recipesDetails(id),
          builder: (data) => Recipe.fromJson(data));

  Future<List<RecipeListItem>> getRecipes(String recipesNumber,
      String ingredients) async {
    return _getData(
      uri: _spoonaCularAPI.getRecipeByIngredients(recipesNumber, ingredients),
      builder: (data) => RecipeListItem.recipeListFromJson(data),
    );
  }

  Future<T> _getData<T>({
    required Uri uri,
    required T Function(dynamic data) builder,
  }) async {
    try {
      final response = await _client.get(uri);
      switch (response.statusCode) {
        case 200:
          final data = json.decode(response.body);
          return builder(data);
        case 401:
          throw Exception("Unauthorized");
        case 404:
          throw Exception("Not found!");
        default:
          throw Exception("UnKnown");
      }
    } on SocketException catch (_) {
      rethrow;
    }
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

  final recipesByIngredientsProvider = Provider <Future<List<RecipeListItem>>>((ref) {
    final user = ref.read(authRepositoryProvider).currentUser;
    final recipeRepository=ref.watch(recipeRepositoryProvider);
    if (user == null) {
      throw AssertionError('User can\'t be null');
    }
    final repository = ref.watch(ingredientsRepositoryProvider);
      var fetchIngredients = repository.fetchIngredients(uid: user.uid);
       var listItemToString = convertListItemToString(fetchIngredients);
       return recipeRepository.getRecipes('3' , listItemToString as String);
  });
    



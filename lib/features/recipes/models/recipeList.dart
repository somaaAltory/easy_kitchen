import '../../../models/recipe.dart';

class RecipesList{
  late List<String> recipes ;

  RecipesList(this.recipes);
  factory RecipesList.fromJson(dynamic data){
    return data.map((recipe){
      return recipe["id"];
    }).toList();
  }
}
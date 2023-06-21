import 'package:easy_kitchen/features/recipes/models/recipeListItem.dart';
import 'package:easy_kitchen/features/favorites/data/recipeList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Screens/detail_screen.dart';
import '../data/recipe_repository.dart';
import '../models/recipe.dart';



Widget recipeItemCard(int id, String title, String image,
    int missedIngredientCount, int usedIngredientCount, context) {
  return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
    return InkWell(
      onTap: () {
        var recipeDetails = ref.watch(recipeRepositoryProvider).getRecipeDetails(id);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>
                DetailScreen(recipeDetails,title),
          ),
        );
      },
      child: Container(
        height: 140,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Container(
            height: 100,
            child: Row(children: [
              Expanded(
                flex: 6,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(image), fit: BoxFit.cover)),
                ),
              ),

              const Spacer(
                flex: 1,
              ),
              Expanded(
                flex: 14,
                child: Container(
                  padding: const EdgeInsets.only(top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      title.length > 20
                          ? Text("${title.substring(0, 20)}...",
                              style: const TextStyle(
                                fontSize: 20.0,
                              ))
                          : Text(title,
                              style: const TextStyle(
                                fontSize: 20.0,
                              )),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          missedIngredientCount > 0
                              ? Text(
                                  "You're messing $missedIngredientCount ingredients")
                              : const Text(""),
                          const Spacer(
                            flex: 1,
                          ),
                          IconButton(
                              onPressed: () {
                                  var recipeId = favoriteRecipeListItem.where((element) => element.id == id) ;
                                  if(!recipeId.isNotEmpty) {
                                    favoriteRecipeListItem.add(
                                      RecipeListItem(
                                          id: id,
                                          title: title,
                                          image: image,
                                          missedIngredientCount:
                                          missedIngredientCount,
                                          usedIngredientCount: usedIngredientCount),
                                    );
                                  }
                              },
                              icon:  const Icon(Icons.favorite_outline),),
                        ],
                      ),
                    ],
                    // Checkbox(value: this.value, onChanged: null)
                  ),
                ),
              ),

              // missedIngredientCount>0 ? Text("missedIngredientCount:$missedIngredientCount"): Text(""),
            ]),
          ),
        ),
      ),
    );
  });
}

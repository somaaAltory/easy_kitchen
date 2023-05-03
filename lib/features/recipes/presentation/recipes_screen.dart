import 'package:easy_kitchen/features/recipes/models/recipeListItem.dart';
import 'package:easy_kitchen/features/recipes/presentation/recipe_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/recipe_repository.dart';

class RecipesScreen extends ConsumerWidget {
  const RecipesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipesByIngredients = ref.watch(recipesByIngredientsProvider);
    return FutureBuilder<List<RecipeListItem>>(
      future: recipesByIngredients,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return recipeItemCard(
                    snapshot.data![index].id,
                    snapshot.data![index].title,
                    snapshot.data![index].image,
                    snapshot.data![index].missedIngredientCount,
                    snapshot.data![index].usedIngredientCount,context);
              });
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return const CircularProgressIndicator();
      },
    );
  }
}

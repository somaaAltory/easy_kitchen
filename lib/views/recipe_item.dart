import 'package:easy_kitchen/models/recipe.api.dart';
import 'package:easy_kitchen/models/recipe.dart';
import 'package:easy_kitchen/views/widgets/recipe_card.dart';
import 'package:flutter/material.dart';

class RecipeItem extends StatefulWidget {
  const RecipeItem({Key? key}) : super(key: key);


  @override
  _RecipeItemState createState() => _RecipeItemState();
}

class _RecipeItemState extends State<RecipeItem> {
  late List<Recipe> _recipes;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getRecipes();
  }

  Future<void> getRecipes() async {
    _recipes = await RecipeApi.getRecipe();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: _recipes.length,
          itemBuilder: (context, index) {
            return RecipeCard(
              recipe: _recipes[index],
            );
          },
        ));
  }
}
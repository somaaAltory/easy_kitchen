import 'package:easy_kitchen/models/recipe.api.dart';
import 'package:easy_kitchen/models/recipe.dart';
import 'package:easy_kitchen/views/widgets/recipe_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                title: _recipes[index].title,
                id: _recipes[index].id,
                thumbnailUrl: _recipes[index].images,
                extendedIngredients:_recipes[index].extendedIngredients,);
          },
        ));
  }
}
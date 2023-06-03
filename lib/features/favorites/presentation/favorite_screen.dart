
import 'package:easy_kitchen/features/favorites/data/recipeList.dart';
import 'package:flutter/material.dart';

import '../../recipes/presentation/recipe_widget.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);



  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final _searchController = TextEditingController();
  final _searchFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children:<Widget>[

          Container(
            height: MediaQuery.of(context).size.height -kBottomNavigationBarHeight-200,
            child: favoriteRecipeListItem.isNotEmpty ?
            ListView.builder(
              itemCount: favoriteRecipeListItem.length,
              itemBuilder: (context, index) {
                return recipeItemCard(
                    favoriteRecipeListItem[index].id,
                    favoriteRecipeListItem[index].title,
                    favoriteRecipeListItem[index].image,
                    favoriteRecipeListItem[index].missedIngredientCount,
                    favoriteRecipeListItem[index].usedIngredientCount,context);
              }):
         Center(
              child: SizedBox(
                height: 150,
                child: Column(
                  children: [
                  Image.asset("assets/icons/recipe-book.png",
                  fit: BoxFit.cover, // optional, controls how the image should be resized to fill its container
                ),
                    const SizedBox(height: 20,),
                    const Text('You have no favorites yet - start adding some!'),
                  ],
                ),
              ),),
          ),
                ]
      ),
    );
  }
}

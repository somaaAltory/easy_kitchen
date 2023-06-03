// import 'package:easy_kitchen/views/widgets/recipe_card.dart';
// import 'package:flutter/material.dart';
// import '../helpers/Ingredients.dart';
// import '../models/recipe.dart';
//
// class FavoriteScreen extends StatefulWidget {
//
//   const FavoriteScreen( );
//
//   @override
//   State<FavoriteScreen> createState() => _FavoriteScreenState();
// }
//
// class _FavoriteScreenState extends State<FavoriteScreen> {
//   static List<Recipe> favorites=[];
//   @override
//   void initState() {
//     favorites=recipes;
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // if (widget.favoriteRecipe.isEmpty) {
//     //   return const Center(
//     //     child: Text('You have no favorites yet - start adding some!'),
//     //   );
//     // } else {
//       return ListView.builder(itemBuilder: (ctx, index) {
//         return RecipeCard(
//           recipe: favorites[index],
//
//           // title: _favorites[index].title,
//           // id: _favorites[index].id,
//           // thumbnailUrl: _favorites[index].images,
//           // extendedIngredients: _favorites[index].extendedIngredients,
//           // duration: _favorites[index].duration,
//           // isCheap: _favorites[index].isCheap,
//         );
//       },
//           itemCount: favorites.length,
//       );
//     }
//   }
//

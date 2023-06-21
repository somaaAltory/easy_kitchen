import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../authentication/data/firebase_auth_repository.dart';
import '../../pantry/data/ingredients_repository.dart';
import '../data/recipe_repository.dart';
import '../models/recipeListItem.dart';

class RecipeScreenController extends StateNotifier<AsyncValue<List<RecipeListItem>>>{
  RecipeScreenController(this.ref) : super( const AsyncData([]));
  final Ref ref;

  Future <List<RecipeListItem>> filter (String diet) async {
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
  return recipeRepository.getRecipesComplex(4 , ingredientsAsString,diet);

      // state = const AsyncLoading();
      // state = await AsyncValue.guard(() =>recipeRepository.getRecipesComplex(4 , ingredientsAsString,diet));
      //

  }
}
final recipesScreenControllerProvider =
StateNotifierProvider<RecipeScreenController, AsyncValue<List<RecipeListItem>>>((ref) {
  return RecipeScreenController(ref);
});

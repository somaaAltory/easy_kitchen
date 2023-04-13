import 'dart:async';
import 'package:easy_kitchen/features/pantry/models/ingredient.dart';


import 'package:riverpod/riverpod.dart';

import '../../authentication/data/firebase_auth_repository.dart';
import 'package:easy_kitchen/features/pantry/data/ingredients_repository.dart';

class ingredientsScreenController extends StateNotifier<AsyncValue<void>>  {
  ingredientsScreenController( this.ref): super(const AsyncData(null));

  final Ref ref;

  FutureOr<void> build() {
    // ok to leave this empty if the return type is FutureOr<void>
  }

  Future<void> deleteIngredient(Ingredient ingredient) async {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser == null) {
      throw AssertionError('User can\'t be null');
    }
    final repository = ref.read(ingredientsRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
            () => repository.deleteIngredient(uid: currentUser.uid, ingredientId: ingredient.id));
  }
  Future<void> addIngredient(String ingredientName) async {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser == null) {
      throw AssertionError('User can\'t be null');
    }
    final repository = ref.read(ingredientsRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
            () => repository.addIngredient(uid: currentUser.uid,name: ingredientName));
  }

}

// final ingredientsScreenControllerProvider =
// AutoDisposeAsyncNotifierProvider<ingredientsScreenController, void>(
//     ingredientsScreenController() as ingredientsScreenController Function());

final ingredientsScreenControllerProvider = StateNotifierProvider<
    ingredientsScreenController, AsyncValue<void>>((ref) {
  return ingredientsScreenController(ref);
});
import 'dart:async';
import 'package:easy_kitchen/features/pantry/models/ingredient.dart';


import 'package:riverpod/riverpod.dart';

import '../../authentication/data/firebase_auth_repository.dart';
import 'package:easy_kitchen/features/pantry/data/ingredients_repository.dart';

class ingredientsScreenController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // ok to leave this empty if the return type is FutureOr<void>
  }

  Future<void> deleteJob(Ingredient ingredient) async {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser == null) {
      throw AssertionError('User can\'t be null');
    }
    final repository = ref.read(ingredientsRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
            () => repository.deleteIngredient(uid: currentUser.uid, ingredientId: ingredient.id));
  }
}

final ingredientsScreenControllerProvider =
AutoDisposeAsyncNotifierProvider<ingredientsScreenController, void>(
    ingredientsScreenController() as ingredientsScreenController Function());
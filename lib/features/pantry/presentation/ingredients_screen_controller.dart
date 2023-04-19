import 'dart:async';
import 'package:easy_kitchen/features/pantry/data/barcode_repository.dart';
import 'package:easy_kitchen/features/pantry/models/ingredient.dart';

import 'package:riverpod/riverpod.dart';

import '../../authentication/data/firebase_auth_repository.dart';
import 'package:easy_kitchen/features/pantry/data/ingredients_repository.dart';

class ingredientsScreenController extends StateNotifier<AsyncValue<void>> {
  ingredientsScreenController(this.ref) : super(const AsyncData(null));

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
    state = await AsyncValue.guard(() => repository.deleteIngredient(
        uid: currentUser.uid, ingredientId: ingredient.id));
  }

  Future<void> addIngredient(String ingredientName,DateTime expirationDate) async {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser == null) {
      throw AssertionError('User can\'t be null');
    }
    state = const AsyncLoading();
    final repository = ref.read(ingredientsRepositoryProvider);
    var ingredients = await repository.fetchIngredients(uid: currentUser.uid);
    var ingredientNames = ingredients.map((e) => e.name);
    if (!ingredientNames.contains(ingredientName)) {
      state = await AsyncValue.guard(() =>
          repository.addIngredient(uid: currentUser.uid, name: ingredientName,expirationDate: expirationDate));
    }
  }

  Future<void> addIngredientByScanCode(String ingredientBarcode) async {
    final ingredientName = await ref
        .read(barcodeRepositoryProvider)
        .getProductName(ingredientBarcode);
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser == null) {
      throw AssertionError('User can\'t be null');
    }
    final repository = ref.read(ingredientsRepositoryProvider);
    var ingredients = await repository.fetchIngredients(uid: currentUser.uid);
    var ingredientNames = ingredients.map((e) => e.name);
    if (!ingredientNames.contains(ingredientName)) {
      state = const AsyncLoading();
      state = await AsyncValue.guard(() =>
          repository.addIngredient(uid: currentUser.uid, name: ingredientName,expirationDate: DateTime.now().add(const Duration(days: 30))));
    }
  }
}

final ingredientsScreenControllerProvider =
    StateNotifierProvider<ingredientsScreenController, AsyncValue<void>>((ref) {
  return ingredientsScreenController(ref);
});

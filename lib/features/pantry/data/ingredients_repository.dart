import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_kitchen/features/pantry/models/ingredient.dart';
import 'package:riverpod/riverpod.dart';

import '../../authentication/data/firebase_auth_repository.dart';



class ingredientsRepository {
  ingredientsRepository(this._firestore);

  final FirebaseFirestore _firestore;

  static String pantryPath(String uid) => 'users/$uid/pantry';

  static String ingredientPath(String uid, String ingredientId) =>
      'users/$uid/pantry/$ingredientId';

  // create
  Future<void> addIngredient({required String uid,
    required String name,
   }) =>
      _firestore.collection(pantryPath(uid)).add({
        'name': name,
      });

  // update
  Future<void> updateIngredient(
      {required String uid, required Ingredient ingredient}) =>
      _firestore.doc(ingredientPath(uid, ingredient.id)).update(
          ingredient.toMap());

  // delete
  Future<void> deleteIngredient(
      {required String uid, required String ingredientId}) async {

    final ingredientRef = _firestore.doc(ingredientPath(uid, ingredientId));
    await ingredientRef.delete();
  }

  Stream<Ingredient> getIngredient(
      {required String uid, required String ingredientId}) =>
      _firestore
          .doc(ingredientPath(uid, ingredientId))
          .withConverter<Ingredient>(
        fromFirestore: (snapshot, _) =>
            Ingredient.fromMap(snapshot.data()!, snapshot.id),
        toFirestore: (ingredient, _) => ingredient.toMap(),
      )
          .snapshots()
          .map((snapshot) => snapshot.data()!);

  Stream<List<Ingredient>> getIngredients({required String uid}) =>
      queryIngredients(uid: uid)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());



  Query<Ingredient> queryIngredients({required String uid}) =>
      _firestore.collection(pantryPath(uid)).withConverter(
        fromFirestore: (snapshot, _) =>
            Ingredient.fromMap(snapshot.data()!, snapshot.id),
        toFirestore: (job, _) => job.toMap(),
      );

  Future<List<Ingredient>> fetchIngredients({required String uid}) async {
    final ingredient = await queryIngredients(uid: uid).get();
    return ingredient.docs.map((doc) => doc.data()).toList();
  }
}
final ingredientListProvider = Provider<Future<List<Ingredient>>>((ref) {
  final user = ref.watch(authStateChangesProvider).value;
  if (user == null) {
    throw AssertionError('User can\'t be null');
  }
  final repository = ref.watch(ingredientsRepositoryProvider);
  return repository.fetchIngredients(uid: user.uid);

});



final ingredientsStreamProvider = StreamProvider.autoDispose<List<Ingredient>>((ref) {
  final user = ref.watch(authStateChangesProvider).value;
  if (user == null) {
    throw AssertionError('User can\'t be null');
  }
  final repository = ref.watch(ingredientsRepositoryProvider);
  return repository.getIngredients(uid: user.uid);
});





final ingredientsQueryProvider = Provider<Query<Ingredient>>((ref) {
  final user = ref.read(authRepositoryProvider).currentUser;
  if (user == null) {
    throw AssertionError('User can\'t be null');
  }
  final repository = ref.watch(ingredientsRepositoryProvider);
  return repository.queryIngredients(uid: user.uid);
});

final ingredientStreamProvider =
StreamProvider.autoDispose.family<Ingredient, String>((ref, jobId) {
  final user = ref.watch(authStateChangesProvider).value;
  if (user == null) {
    throw AssertionError('User can\'t be null');
  }
  final repository = ref.watch(ingredientsRepositoryProvider);
  return repository.getIngredient(uid: user.uid, ingredientId: jobId);
});


final ingredientsRepositoryProvider = Provider<ingredientsRepository>((ref) {
  return ingredientsRepository(FirebaseFirestore.instance);
});





import 'package:easy_kitchen/features/pantry/data/ingredients_repository.dart';
import 'package:easy_kitchen/features/pantry/models/ingredient.dart';
import 'package:easy_kitchen/features/shopping/data/shoppingList.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'ingredients_screen_controller.dart';

class MyPantryScreen extends StatelessWidget {
  const MyPantryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Column(
        children: [
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final ingredientQuery = ref.watch(ingredientsQueryProvider);
              return FirestoreListView<Ingredient>(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                pageSize: 20,
                query: ingredientQuery,
                itemBuilder: (context, doc) {
                  final ingredient = doc.data();
                  return ingredientCard(ingredient);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
Widget ingredientCard(Ingredient ingredient)
{
  return  Consumer(
    builder: (BuildContext context, WidgetRef ref, Widget? child) {
      // final  ingredientControllerProvider = ref.watch(ingredientsScreenControllerProvider);
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Card(
          child: SizedBox(
            height: 80,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: <Widget>[
                  Text(
                    ingredient.name as String,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const Spacer(),
                  Text(
                     // ingredient.expirationDate!.toDate().day.toString(),
                     DateFormat.MMMMd().format(DateTime.fromMicrosecondsSinceEpoch(ingredient.expirationDate!.microsecondsSinceEpoch)),
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),

                  IconButton(
                    onPressed: () => ref.read(ingredientsScreenControllerProvider.notifier).deleteIngredient(ingredient),

                    icon: const Icon(Icons.delete_outline),
                  ),
                  IconButton(
                    onPressed: () {

                      var ingredientName = myShoppingList.where((element) => element== (ingredient.name as String)) ;
                      if(ingredientName.isEmpty) {
                        myShoppingList.add(ingredient.name);
                      }
                    },
                    icon: const Icon(Icons.shopping_cart_outlined),
                  ),
                ],
              ),
            ),
          ),
        ),
      );},
  );

}
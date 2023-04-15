import 'dart:developer';

import 'package:easy_kitchen/features/pantry/data/ingredients_repository.dart';
import 'package:easy_kitchen/features/pantry/models/ingredient.dart';
import 'package:easy_kitchen/helpers/helped_function.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

import 'ingredients_screen_controller.dart';

class MyPantryScreen extends StatelessWidget {
  const MyPantryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
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
        ));
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
                IconButton(
                  onPressed: () => ref.read(ingredientsScreenControllerProvider.notifier).deleteIngredient(ingredient),

                  icon: const Icon(Icons.delete_outline),
                ),
                IconButton(
                  onPressed: () {},
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

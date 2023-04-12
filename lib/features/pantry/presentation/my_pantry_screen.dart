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

class MyPantryScreen extends StatelessWidget {
  const MyPantryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final ingredientQuery = ref.watch(ingredientsQueryProvider);
            return FirestoreListView<Ingredient>(
              shrinkWrap: true,
              query: ingredientQuery,
              itemBuilder: (context, doc) {
                final ingredient = doc.data();
                return Dismissible(
                    key: Key(ingredient.id),
                    child: Card(
                      elevation: 4,
                      child: ListTile(
                        title: Text(ingredient.name as String),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          // color: Colors.red,
                          onPressed: () {},
                        ),
                      ),
                    ));
              },
            );
          },
        ),
      ],
    ));
  }
}

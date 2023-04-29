import 'package:easy_kitchen/features/recipes/models/recipeListItem.dart';
import 'package:easy_kitchen/helpers/Ingredients.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/recipes/data/recipe_repository.dart';

class IngredientsScreen extends StatefulWidget {
  const IngredientsScreen({Key? key}) : super(key: key);

  @override
  State<IngredientsScreen> createState() => _IngredientsScreenState();
}

class _IngredientsScreenState extends State<IngredientsScreen> {
  List items = ingredients_list.toList();
  bool value =false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final recipesByIngredients = ref.watch(recipesByIngredientsProvider);
             return FutureBuilder<List<RecipeListItem>>(
               future: recipesByIngredients,
               builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
               return ListView.builder(
                  itemCount: snapshot.data!.length(),
                  itemBuilder: (context, index) {
                    return Container(
                      height: 100,
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          height: 120,
                          padding: const EdgeInsets.all(0),
                          child: Row(children: [
                            Expanded(
                              flex: 6,
                              child: Container(
                                decoration:  BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(snapshot.data![index]["image"]),
                                        fit: BoxFit.fill)),
                              ),
                            ),
                            const Spacer(
                              flex: 1,
                            ),
                            Expanded(
                              flex: 14,
                              child: Container(
                                padding: const EdgeInsets.only(top: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  //mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(items[index],
                                        style: const TextStyle(
                                            fontSize: 20.0,)),

                                  ],
                                    // Checkbox(value: this.value, onChanged: null)
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    );
                  }); },
             ); },
          ),
    );

  }
}


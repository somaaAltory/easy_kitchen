import 'package:easy_kitchen/features/recipes/models/recipeListItem.dart';
import 'package:easy_kitchen/features/recipes/presentation/recipe_widget.dart';
import 'package:easy_kitchen/helpers/helped_function.dart';
import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/recipe_repository.dart';
import 'RecipeScreenController.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({Key? key}) : super(key: key);

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  TextEditingController editingController = TextEditingController();
  List<RecipeListItem> recipeListItem = [];
  List<RecipeListItem> recipeListItemDuplicate = [];
  String diet = "";
  bool flag = false;
  static const foodFilters = ['vegan', 'dairyFree','glutenFree','vegetarian'];

  void filterSearchResults(String query) {
    setState(() {
      flag=true;
      recipeListItem = recipeListItemDuplicate
          .where((item) =>
              (item.title.toLowerCase()).contains(query.toLowerCase()))
          .toList();
    });
  }

  void openFilterDialog() async {
    await FilterListDialog.display<String>(
      context,
      listData: foodFilters,
      height: 300,
      width: 100,
      selectedListData: [],
      choiceChipLabel: (user) => user,
      hideSearchField: true,
      themeData: FilterListThemeData(
        context,
        choiceChipTheme: ChoiceChipThemeData(
            selectedBackgroundColor: Theme.of(context).accentColor),
      ),
      hideSelectedTextCount: true,
      validateSelectedItem: (list, val) => list!.contains(val),
      onItemSearch: (user, query) {
        return user.toLowerCase().contains(query.toLowerCase());
      },
      onApplyButtonClick: (list) {
        setState(() {
          flag=true;
          recipeListItem = recipeListItemDuplicate;
          diet=list![0];
        });
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    onChanged: (value) {
                      filterSearchResults(value);
                    },
                    controller: editingController,
                    decoration: const InputDecoration(
                        labelText: "Search",
                        hintText: "Search",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)))),
                  ),
                ),
              ),
              const SizedBox(
                  width: 16.0), // Optional space between text field and button
              // Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child){
              //   // final complexRecipeProvider = ref.watch(recipesScreenControllerProvider);
              //
              //   return ElevatedButton(
              //     onPressed: () async {
              //        openFilterDialog();
              //        recipeListItemDuplicate= await ref.read(recipesScreenControllerProvider.notifier).filter(diet);
              //        recipeListItem=recipeListItemDuplicate;
              //        flag=true;
              //       // Handle button press
              //     },
              //     style: ElevatedButton.styleFrom(
              //       primary: Colors.white,
              //       onPrimary: Colors.blueGrey,
              //       padding:
              //       EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(
              //             10.0), // Set the border radius here
              //       ),
              //     ),
              //     child: const  Icon( Icons.filter_alt_outlined),
              //   );
              // }),
            ],
          ),
        ),
        Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final recipesByIngredients =
                  // ref.watch(recipesByIngredientsProvider);
               ref.read(recipesScreenControllerProvider.notifier).filter('Vegan');
            return
              // flag
              //   ? Expanded(
              //       child: ListView.builder(
              //           shrinkWrap: true,
              //           itemCount: recipeListItem.length,
              //           itemBuilder: (context, index) {
              //             return recipeItemCard(
              //                 recipeListItem[index].id,
              //                 recipeListItem[index].title,
              //                 recipeListItem[index].image,
              //                 recipeListItem[index].missedIngredientCount,
              //                 recipeListItem[index].usedIngredientCount,
              //                 context);
              //           }),
              //     )
                // :
            FutureBuilder<List<RecipeListItem>>(
                    future: recipesByIngredients,
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.hasData) {
                        recipeListItemDuplicate = snapshot.data!;
                        return Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return recipeItemCard(
                                    snapshot.data![index].id,
                                    snapshot.data![index].title,
                                    snapshot.data![index].image,
                                    snapshot.data![index].missedIngredientCount,
                                    snapshot.data![index].usedIngredientCount,
                                    context);
                              }),
                        );
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                      return const CircularProgressIndicator();
                    },
                  );
          },
        ),
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../helpers/Ingredients.dart';
import '../../models/recipe.dart';
import 'detail_screen.dart';

class RecipeCard extends StatelessWidget {
   final Recipe recipe;
  // final String title;
  // final int id;
  // final String thumbnailUrl;
  // final List extendedIngredients;
  // final bool isCheap;
  // final int duration;


  RecipeCard({
     required this.recipe
    // required this.title,
    // required this.id,
    // required this.thumbnailUrl,
    // required this.extendedIngredients,
    // required this.duration,
    // required this.isCheap
  });

  final List<bool> selection=<bool>[false];

  // String isMealCheap()
  // {
  //   if(isCheap)
  //     return "Cheap";
  //   return "Expensive";
  // }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => DetailScreen(
                    this.recipe.title, this.recipe.extendedIngredients, this.recipe.images),
            ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    recipe.images,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: Container(
                    width: 300,
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Text(
                      recipe.title,
                      style: TextStyle(fontSize: 26, color: Colors.white),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    children:  <Widget>[
                      Icon(Icons.schedule),
                      SizedBox(
                        width: 6,
                      ),
                      Text('${recipe.duration} min'),
                    ],
                  ),
                  Row(
                    children: const <Widget>[
                      Icon(
                        Icons.work
                      ),
                      SizedBox(width: 6,),
                      Text('Hard'),
                    ],
                  ),
                  Row(
                    children:  <Widget>[
                      ToggleButtons(
                        children: <Widget>[
                          Icon(Icons.favorite_outline),
                        ],
                        isSelected: selection,
                        onPressed: (int index){
                          recipes.add(recipe);
                          selection[index]= !selection[index];
                        },
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      // Text(isMealCheap()),
                    ],
                  )
                ],
              ),

            )
          ],
        ),
      ),
    );
  }
}

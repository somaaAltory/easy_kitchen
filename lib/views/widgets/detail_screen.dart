import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Screens/favorites_screen.dart';

class DetailScreen extends StatelessWidget {
  //final RecipeCard recipeCard;
  //  final String name;
  final String thumbnailUr;
  final List extendedIngredients;
  final String title;

  DetailScreen(this.title, this.extendedIngredients, this.thumbnailUr);
  
  
  
  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: child,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      backgroundColor: Theme.of(context).accentColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(thumbnailUr,
              fit: BoxFit.cover,
              )
            ),
            buildSectionTitle(context, 'Ingredients'),
            buildContainer(ListView.builder(
              itemBuilder: (ctx, index) => Card(
                color: Theme.of(context).accentColor,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    child: Text(extendedIngredients[index]["name"] as String)),
              ),
              itemCount: extendedIngredients.length,
            ),
            ),
            buildSectionTitle(context, 'Steps'),



          ],
        ),
      ),

    );
  }
}

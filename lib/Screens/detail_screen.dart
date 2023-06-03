import 'package:easy_kitchen/features/recipes/models/recipe.dart';
import 'package:flutter/material.dart';



class DetailScreen extends StatelessWidget {
  //final RecipeCard recipeCard;
  //  final String name;
  // final String thumbnailUr;
  // final List extendedIngredients;
  // final String title;
    final Future<Recipe> recipe;

   // DetailScreen(this.title, this.extendedIngredients, this.thumbnailUr);
   const DetailScreen(this.recipe, {Key? key});
  //
  
  
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
        backgroundColor: Theme.of(context).accentColor,
        title: Text("title"),
      ),

      body: FutureBuilder<Recipe>(
        future: recipe,
        builder: (BuildContext context,snapshot){
        return snapshot.hasData? SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 300,
                width: double.infinity,
                child: Image.network(snapshot.data!.images,
                fit: BoxFit.cover,
                )
              ),
              buildSectionTitle(context, 'Ingredients'),
              buildContainer(ListView.builder(
                itemBuilder: (ctx, index) => Card(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: Text(snapshot.data!.extendedIngredients[index]["name"] as String)),
                ),
                itemCount: snapshot.data!.extendedIngredients.length,
              ),
              ),
              buildSectionTitle(context, 'Steps'),
            ],
          ),
        ):
        Center(child: Text("dcscss"),);
  }
      ),

    );
  }
}


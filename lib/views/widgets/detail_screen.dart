import 'package:easy_kitchen/views/widgets/recipe_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  //final RecipeCard recipeCard;
  //  final String name;
  //  final String thumbnailUr;
   final int id;


  DetailScreen(this.id);

  @override
  _DetailScreenState createState() => _DetailScreenState(this.id);
}

class _DetailScreenState extends State<DetailScreen> {
  _DetailScreenState(int id);
  @override
  void initState() {
    super.initState();
    getRecipes();
  }

  Future<void> getRecipes() async {

    _recipes = await RecipeApi.getRecipe();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: SafeArea(
          child: Column(

            children: [
              SizedBox(height: 80,),
              Container(

                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Center(

                  child:Image.network(this.thumbnailUr),
                ),
              ),
              SizedBox(height: 40,),
              MaterialButton(
                minWidth: 200.0,
                shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(22.0)),
                height: 35,
                color: Colors.lightBlueAccent,
                child: Text(this.name,
                    style: new TextStyle(fontSize: 16.0, color: Colors.white)),
                onPressed: () {

                },
              ),

            ],

          ),
        ),
      ),
    );
  }


}
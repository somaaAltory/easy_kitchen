import 'package:easy_kitchen/features/recipes/models/recipe.dart';
import 'package:flutter/material.dart';



class DetailScreen extends StatelessWidget {
    final String title;
    final Future<Recipe> recipe;

   const DetailScreen(this.recipe,this.title ,{Key? key}) : super(key: key);
  //
  
  
  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
      ),
    );
  }

  Widget buildContainer(Widget child,var mediaQuery) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height:mediaQuery.height*0.55,
      width: mediaQuery.width*0.9,
      child: child,
    );
  }


  @override
  Widget build(BuildContext context) {
    var mediaQuerySize= MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Text(title,
            style: const TextStyle(
              fontSize: 18.0,
            )),
      ),

      body: FutureBuilder<Recipe>(
        future: recipe,
        builder: (BuildContext context,snapshot){
        return snapshot.hasData? SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: mediaQuerySize.height*0.01,),
              Container(
                height: mediaQuerySize.height*0.2,
                width: mediaQuerySize.width*0.7,
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
              ), mediaQuerySize
              ),
              buildSectionTitle(context, 'Steps'),
              buildContainer(ListView.builder(
                itemBuilder: (ctx, index) => Card(
                      child: Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              child: Text('#${(index+1)}'),
                            ),
                            title: Text(snapshot.data!.analyzedInstructions[0]['steps'][index]['step'] as String),
                          )
                        ],
                      ),

                ),
                itemCount: (snapshot.data!.analyzedInstructions[0]['steps']).length,
              ),mediaQuerySize
              ),
            ],
          ),
        ):
        Center(child: Text("dcscss"),);
  }
      ),

    );
  }
}


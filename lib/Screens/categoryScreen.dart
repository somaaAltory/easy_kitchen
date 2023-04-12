import 'package:easy_kitchen/views/widgets/category_widget.dart';
import 'package:flutter/material.dart';
import '../helpers/Ingredients.dart';
import 'my_pantry_screen.dart';

class CategoryScreen extends StatelessWidget {
   const CategoryScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(tabs: [
            Tab(child: Text('Pantry'),),
            Tab(child: Text('My Pantry'),),
          ]),
        ),
        body: TabBarView(
          children:[ ListView.builder(
              addAutomaticKeepAlives: false,
              itemCount: ingredientsByCategories.length,
              itemBuilder: (context, index) {
                return CategoryWidget(
                    ingredientsByCategories[index]['category'] as String , ingredientsByCategories[index]['ingredients']as List<String>);
              }),
            MyPantryScreen(),
        ]
        ),

        // floatingActionButton: FloatingActionButton.extended(
        //     label: const Text('My pantry',),
        //     onPressed: (){
        //       Navigator.push(context,MaterialPageRoute(builder: (context)=>MyPantryScreen()));
        //     }),
      ),
    );
  }
}

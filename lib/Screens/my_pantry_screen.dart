import 'package:easy_kitchen/helpers/Ingredients.dart';
import 'package:flutter/material.dart';

class MyPantryScreen extends StatefulWidget {
   const MyPantryScreen({Key? key}) : super(key: key);

  @override
  State<MyPantryScreen> createState() => _MyPantryScreenState();
}

class _MyPantryScreenState extends State<MyPantryScreen> {
  @override
  Widget build(BuildContext context) {
    return myPantryList.isNotEmpty? SingleChildScrollView(
          child: Column(children: <Widget>[
            const SizedBox(
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: myPantryList.length,
                itemBuilder: (context, index) {
                  return ingredientCard(myPantryList[index]);
                }
                ),
          ]),
        ):
           emptyIngredientsList(context);
  }
}

Widget emptyIngredientsList(context)
{
  return Center(
    child: Container(
      child: Center(
        child: Column(
          children:  const <Widget>[
            Image(image: NetworkImage('https://raw.githubusercontent.com/jch28/Super-Cook/master/src/images/Vegetables.orig.png')),
            Text('add your ingredients to get started'),
          SizedBox(height: 20,),
          ],
        ),
      ),
    ),
  )
    ;
}



Widget ingredientCard(String ingredientName)
{
  return  Container(
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: Card(
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Row(
          children: <Widget>[
            Text(
              ingredientName,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                myPantryList.remove(ingredientName);
              },
              icon: Icon(Icons.delete_outline),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.shopping_cart_outlined),
            ),
          ],
        ),
      ),
    ),
  );

}

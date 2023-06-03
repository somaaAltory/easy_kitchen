import 'package:easy_kitchen/features/shopping/data/shoppingList.dart';
import 'package:flutter/material.dart';
class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({Key? key}) : super(key: key);

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  @override
  Widget build(BuildContext context) {
    return  myShoppingList.isNotEmpty ?
    SingleChildScrollView(
      child: Column(
        children: [
          const Text("What's in my list",
          style: TextStyle(fontSize: 22,
          fontWeight: FontWeight.bold),),
          SizedBox(
             height: 250,
            child: ListView.builder(
                itemCount: myShoppingList.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                     height: 50,
                    child: Card(
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(myShoppingList[index],style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              if(!boughtIngredientList.contains(myShoppingList[index])){
                              setState(() {
                                boughtIngredientList.add(myShoppingList[index]);
                                myShoppingList.remove(myShoppingList[index]);
                              });}
                              else
                                {
                                  setState(() {
                                    myShoppingList.remove(myShoppingList[index]);
                                  });
                                }
                            },
                            icon: const Icon(Icons.add),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                myShoppingList.remove(myShoppingList[index]);
                              });
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
          const  SizedBox(height: 20,),
          const Text("What I got",
            style: TextStyle(fontSize: 22,
                fontWeight: FontWeight.bold),),
          SizedBox(
            height: 250,
            child: ListView.builder(
                itemCount: boughtIngredientList.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 50,
                    child: Card(
                      child: Text(boughtIngredientList[index],style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),),
                    ),
                  );
                }),
          ),
        ],
      ),
    ):
    Center(
      child: SizedBox(
        height: 150,
        child: Column(
          children: [
            Image.asset("assets/icons/recipe-book.png",
              fit: BoxFit.cover, // optional, controls how the image should be resized to fill its container
            ),
            const SizedBox(height: 20,),
            const Text('Your shopping list is empty!'),
          ],
        ),
      ),);
  }
}

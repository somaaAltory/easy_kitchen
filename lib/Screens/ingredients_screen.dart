import 'package:easy_kitchen/helpers/Ingredients.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemCount: items.length,
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
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage("https://media.istockphoto.com/id/1203599923/photo/food-background-with-assortment-of-fresh-organic-vegetables.jpg?b=1&s=170667a&w=0&k=20&c=fRNCED4dyey-i6K2RHTPaIm_HFLUr3hnj4J6WblHaXc="),
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
            }));

  }
}


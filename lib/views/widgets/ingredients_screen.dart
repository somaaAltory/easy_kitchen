import 'package:flutter/cupertino.dart';
import 'package:easy_kitchen/helpers/Ingredients.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class IngredientsScreen extends StatefulWidget {
  const IngredientsScreen({Key? key}) : super(key: key);

  @override
  State<IngredientsScreen> createState() => _IngredientsScreenState();
}

class _IngredientsScreenState extends State<IngredientsScreen> {
  List items = Ingredients_list.toList();
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
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage("https://media.istockphoto.com/id/1203599923/photo/food-background-with-assortment-of-fresh-organic-vegetables.jpg?b=1&s=170667a&w=0&k=20&c=fRNCED4dyey-i6K2RHTPaIm_HFLUr3hnj4J6WblHaXc="),
                                  fit: BoxFit.fill)),
                        ),
                      ),
                      Spacer(
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
                                  style: TextStyle(
                                      fontSize: 20.0,)),

                            ],
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
                // child: Card(
                //   elevation: 4,
                //  // color: Colors.white,
                //     child: Column(
                //   children: [
                //     ListTile(
                //         title: Text(items[index]),
                //         leading: Image(
                //             backgroundImage: NetworkImage(
                //                 "https://media.istockphoto.com/id/1203599923/photo/food-background-with-assortment-of-fresh-organic-vegetables.jpg?b=1&s=170667a&w=0&k=20&c=fRNCED4dyey-i6K2RHTPaIm_HFLUr3hnj4J6WblHaXc=")),
                //
                //     ),
                //   ],
                // ),
                // ),
              );
            }));












    // return Container(
    //     child: ListView.builder(
    //
    //     itemCount: items.length,
    //     itemBuilder: (context, index) {
    //       return Dismissible(
    //         key: Key(items[index]),
    //         background: Container(
    //           alignment: AlignmentDirectional.centerEnd,
    //           color: Colors.red,
    //           child: Icon(
    //             Icons.delete,
    //             color: Colors.white,
    //           ),
    //         ),
    //         onDismissed: (direction) {
    //           setState(() {
    //             items.removeAt(index);
    //           });
    //         },
    //         direction: DismissDirection.endToStart,
    //         child: Card(
    //           elevation: 5,
    //           child: Container(
    //             height: 100.0,
    //             child: Row(
    //               children: <Widget>[
    //                 Container(
    //                   height: 100,
    //                   child: Padding(
    //                     padding: EdgeInsets.fromLTRB(10, 2, 0, 0),
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: <Widget>[
    //                         Text(
    //                           items[index],
    //                             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)
    //
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //                 // IconButton(onPressed: (){},  icon: Icon(
    //                 //   Icons.add,))
    //               ],
    //             ),
    //           ),
    //         ),
    //       );
    //     })
    // );
  }
}

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//       backgroundColor: Colors.white,
//       body: ListView.builder(
//         itemCount: items.length,
//         // separatorBuilder: (context, int ) {
//         //   return Divider(color: Colors.white,);
//         // },
//         // shrinkWrap: true,
//         itemBuilder: (BuildContext context, int index) {
//           return GridView.count(
//             shrinkWrap: true,
//             //crossAxisSpacing: 0.0,
//             //mainAxisSpacing: 10.0,
//             crossAxisCount: 2,
//             childAspectRatio: 2.0,
//             children: List.generate(items.length, (index) {
//               return Container(
//                 decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey)
//                 ),
//                   child: Center(
//                       child: Text(items[index],
//                         style: TextStyle( fontWeight: FontWeight.bold, fontSize: 18,),
//                     ),
//                   ),
//               );
//             }),
//           );
//         },
//       ),
//
//   );

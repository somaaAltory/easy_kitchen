import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'detail_screen.dart';

class RecipeCard extends StatelessWidget {
  final String title;
  final int id;
  final String thumbnailUrl;
  final List extendedIngredients;

  RecipeCard({

    required this.title,
    required this.id,
    required this.thumbnailUrl,
    required this.extendedIngredients,

  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => DetailScreen(this.title,this.extendedIngredients,this.thumbnailUrl)));
      },
      child:
        Container(
          child:
          Card(
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
                          image: NetworkImage(thumbnailUrl),
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
                        Text(title,
                            style: TextStyle(
                              fontSize: 20.0,)),

                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ),
        )
      // child: Container(
      //
      //   margin: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      //   width: MediaQuery.of(context).size.width,
      //
      //   height: 180,
      //   decoration: BoxDecoration(
      //     color: Colors.black,
      //     borderRadius: BorderRadius.circular(15),
      //
      //     boxShadow: [
      //       BoxShadow(
      //         color: Colors.black.withOpacity(0.6),
      //         offset: Offset(
      //           0.0,
      //           10.0,
      //         ),
      //         blurRadius: 10.0,
      //         spreadRadius: -6.0,
      //       ),
      //     ],
      //     image: DecorationImage(
      //       colorFilter: ColorFilter.mode(
      //         Colors.black.withOpacity(0.35),
      //         BlendMode.multiply,
      //       ),
      //       image: NetworkImage(thumbnailUrl),
      //       fit: BoxFit.cover,
      //     ),
      //   ),
      //   child: Stack(
      //
      //     children: [
      //
      //       Align(
      //         child: Padding(
      //           padding: EdgeInsets.symmetric(horizontal: 5.0),
      //           child: Text(
      //             title,
      //             style: TextStyle(
      //               fontSize: 19,
      //             ),
      //             overflow: TextOverflow.ellipsis,
      //             maxLines: 2,
      //             textAlign: TextAlign.center,
      //           ),
      //         ),
      //         alignment: Alignment.center,
      //       ),
      //       Align(
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             Container(
      //               padding: EdgeInsets.all(5),
      //               margin: EdgeInsets.all(10),
      //               decoration: BoxDecoration(
      //                 color: Colors.black.withOpacity(0.4),
      //                 borderRadius: BorderRadius.circular(15),
      //               ),
      //               child: Row(
      //                 children: [
      //                   Icon(
      //                     Icons.star,
      //                     color: Colors.yellow,
      //                     size: 18,
      //                   ),
      //                   SizedBox(width: 7),
      //                   //Text(title),
      //                 ],
      //               ),
      //             ),
      //             Container(
      //
      //               padding: EdgeInsets.all(5),
      //               margin: EdgeInsets.all(10),
      //
      //               decoration: BoxDecoration(
      //                 color: Colors.black.withOpacity(0.4),
      //                 borderRadius: BorderRadius.circular(15),
      //               ),
      //               child: Row(
      //                 children: [
      //                   Icon(
      //                     Icons.schedule,
      //                     color: Colors.yellow,
      //                     size: 18,
      //                   ),
      //                   SizedBox(width: 7),
      //                 //  Text(cookTime),
      //                 ],
      //               ),
      //             )
      //           ],
      //         ),
      //         alignment: Alignment.bottomLeft,
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
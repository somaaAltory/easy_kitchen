import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';

class CategoreyWidget extends StatefulWidget {
  const CategoreyWidget({Key? key}) : super(key: key);

  @override
  State<CategoreyWidget> createState() => _CategoreyWidgetState();
}

class _CategoreyWidgetState extends State<CategoreyWidget> {
  List<MultiSelectCard> multiSelectCard= [];
  var list = [1, 2, 3, 4, 5, 6, 7,
    1, 2, 3, 4, 5, 6, 7,
    1, 2, 3, 4, 5, 6, 7,];

  var listforui = [];

  int itemcounttoshow = 4;

  @override
  void initState() {
    listforui.addAll(list.getRange(0, itemcounttoshow));
    super.initState();
  }

  Widget build(BuildContext context) {
    // return MaterialApp(
    //   home: Scaffold(
    //     body: Wrap(
    //       children: [
    //         for (var shop in listforui)
    //           Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 4.0),
    //             child: Chip(
    //               label: Text(shop.toString()),
    //               shape: const StadiumBorder(
    //                 side: BorderSide(
    //                   color: Color(0xFFBDBDBD),
    //                 ),
    //               ),
    //             ),
    //           ),
    //         if (list.length > itemcounttoshow && listforui.length < list.length)
    //           Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 4.0),
    //             child: GestureDetector(
    //               onTap: () => setState(
    //                       () => listforui.addAll(list.skip(itemcounttoshow))),
    //               child: const Chip(
    //                 label: Text("ShowMore"),
    //                 shape: StadiumBorder(
    //                   side: BorderSide(
    //                     color: Color(0xFFBDBDBD),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ),
    //       ],
    //     ),
    //   ),
    // );

    return Scaffold(
      body: Card(
        margin: const EdgeInsets.symmetric(vertical: 20,horizontal: 25),
        elevation: 2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: Image(image: NetworkImage('https://raw.githubusercontent.com/jch28/Super-Cook/master/src/images/Vegetables.orig.png')),
                title: Text('The Enchanted Nightingale'),

              ),
              const SizedBox(height: 20,),
              const Divider(
                  color: Colors.black26
              ),
              const SizedBox(
                height: 10,
              ),
              MultiSelectContainer(
                  itemsDecoration: MultiSelectDecorations(
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.07),
                          borderRadius: BorderRadius.circular(20)),
                      selectedDecoration: BoxDecoration(
                          color: Colors.blueGrey[800],
                          borderRadius: BorderRadius.circular(20)),
                      disabledDecoration: BoxDecoration(
                          color: Colors.grey,
                          border: Border.all(color: Colors.grey[500]!),
                          borderRadius: BorderRadius.circular(10)),
                  ),
                  items:[MultiSelectCard(value: 'banana',label:'banananan')],
              , onChange: (allSelectedItems, selectedItem) {}),
            ],
          ),
      ),
    );
  }

  generateSelectCardList() {}
}



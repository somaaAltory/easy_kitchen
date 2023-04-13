import 'package:easy_kitchen/Screens/categoryScreen.dart';
import 'package:easy_kitchen/Screens/my_pantry_screen.dart';
import 'package:easy_kitchen/helpers/Ingredients.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_select_flutter/dialog/mult_select_dialog.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import 'ingredients_screen_controller.dart';

class CategoryWidget extends StatefulWidget {
   String categoryName;
   List<String> ingredients;
   CategoryWidget(this.categoryName,this.ingredients);


  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  bool showMoreEnabled =true;
  List<MultiSelectCard> multiSelectItemList= [];

  List<MultiSelectCard> minMultiSelectItemList= [];

   late int  itemCountToShow ;

  @override
  void initState() {
    multiSelectItemList = generateSelectCardList(widget.ingredients);
    itemCountToShow = (multiSelectItemList.length/2).round();
    minMultiSelectItemList.addAll(multiSelectItemList.getRange(0, itemCountToShow));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return
          Card(
          margin: const EdgeInsets.symmetric(vertical: 20,horizontal: 25),
          elevation: 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  leading: Image(image: NetworkImage('https://raw.githubusercontent.com/jch28/Super-Cook/master/src/images/Vegetables.orig.png')),
                  title: Text('category'),

                ),
                const SizedBox(height: 20,),
                const Divider(
                    color: Colors.black26
                ),
                const SizedBox(
                  height: 10,
                ),
                Consumer(
                  builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  return MultiSelectContainer(
                      itemsDecoration: MultiSelectDecorations(
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.07),
                              borderRadius: BorderRadius.circular(20)),
                          selectedDecoration: BoxDecoration(
                              color: Colors.blueGrey[800],
                              borderRadius: BorderRadius.circular(20)),
                          disabledDecoration: BoxDecoration(
                              color: Colors.grey,
                              // border: Border.all(color: Colors.grey[500]!),
                              borderRadius: BorderRadius.circular(10)),
                      ),
                      items:minMultiSelectItemList ,
                   onChange: (allSelectedItems, selectedItem) {
                     // MultiSelectDialog(
                     //   items: ["week","month"].map((e) => MultiSelectItem<String>(e,e)).toList(),
                     //   onConfirm: (values) {}, initialValue: [],
                     // );
                        String select = selectedItem.toString();
                        ref.read(ingredientsScreenControllerProvider.notifier).addIngredient(select);

                   });},
                ),
                if(showMoreEnabled )
                MultiSelectContainer(items: [MultiSelectCard(value: 'show more',label: 'show more')], onChange:(allSelectedItems, selectedItem) {
                  setState(() {
                    showMoreEnabled=!showMoreEnabled;
                    minMultiSelectItemList.addAll(multiSelectItemList.skip(itemCountToShow));
                  });
                })

              ],

            ),
       );
  }

  List<MultiSelectCard>  generateSelectCardList(List<String> list) {

    multiSelectItemList.addAll(list.map((e) =>  MultiSelectCard(value: e.toString(),label: e.toString())));
    return multiSelectItemList;
  }

}



import 'package:easy_kitchen/features/pantry/presentation/category_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../helpers/Ingredients.dart';
import './my_pantry_screen.dart';
import 'ingredients_screen_controller.dart';


class CategoryScreen extends ConsumerWidget {
  const CategoryScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context , WidgetRef ref) {
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
              const MyPantryScreen(),
            ]
        ),
          floatingActionButton : FloatingActionButton(onPressed:() async {
              String barcodeNumber = await scanBarcode();
              ref.read(ingredientsScreenControllerProvider.notifier).addIngredientByScanCode(barcodeNumber);

          }  ,
            child: Icon(Icons.camera,),)

      ),
    );
  }
  Future<String> scanBarcode() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode("#ff6666", "Cancel", false, ScanMode.DEFAULT);
    var barcodeScanNumber = barcodeScanRes ;
    return barcodeScanNumber;
  }
}

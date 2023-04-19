import 'package:easy_kitchen/features/pantry/presentation/category_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../helpers/Ingredients.dart';
import './my_pantry_screen.dart';
import 'ingredients_screen_controller.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  bool _isPantryButtonPressed=false;
  bool _isMyPantryButtonPressed=false;

  void updatePantryButtonState(bool isPressed)
  {
    setState(() {
      _isPantryButtonPressed=isPressed;
    });
  }
  void updateMyPantryButtonState(bool isPressed)
  {
    setState(() {
      _isMyPantryButtonPressed=isPressed;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BuildCategoriesScreenBody(isButton1Pressed: _isPantryButtonPressed,isButton2Pressed: _isMyPantryButtonPressed,),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          floatingButtonWidget(context,'Pantry',(){
            updateMyPantryButtonState(false);
            updatePantryButtonState(true);
          }),
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return
              FloatingActionButton(onPressed: () async {
                String barcodeNumber = await scanBarcode();
                ref.read(ingredientsScreenControllerProvider.notifier).addIngredientByScanCode(barcodeNumber);

              },
                child: Icon(Icons.camera,),);

            }
          ),
          floatingButtonWidget(context,'My pantry',(){
            updatePantryButtonState(false);
            updateMyPantryButtonState(true);
          }),

        ],
      ),
    );
  }
}

class BuildCategoriesScreenBody extends StatelessWidget {
  final bool isButton1Pressed;
  final bool isButton2Pressed;

  const BuildCategoriesScreenBody({Key? key,
    required this.isButton1Pressed,
    required this.isButton2Pressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(isButton2Pressed){
      return const MyPantryScreen();
    }
    else{
      return ListView.builder(
          addAutomaticKeepAlives: false,
          itemCount: ingredientsByCategories.length,
          itemBuilder: (context, index) {
            return CategoryWidget(
              ingredientsByCategories[index]['category'] as String,
              ingredientsByCategories[index]['ingredients'] as List<String>,
              ingredientsByCategories[index]['image'] as String,
            );
          });
    }
  }
}

Widget floatingButtonWidget(context,String buttonText,Function onPress)
{
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
    child: ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(horizontal: 5.0),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).accentColor),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
      ),
      child:
      TextButton(

        style: TextButton.styleFrom(
          textStyle: const TextStyle(fontSize: 20,),
        ),
        onPressed: (){
          onPress();
        },
        child:  Text(buttonText,style: const TextStyle(color: Colors.white),),
      ),
    ),
  );

}
Future<String> scanBarcode() async {
  String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode("#ff6666", "Cancel", false, ScanMode.DEFAULT);
  var barcodeScanNumber = barcodeScanRes ;
  return barcodeScanNumber;
}
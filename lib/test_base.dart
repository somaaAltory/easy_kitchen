import 'package:easy_kitchen/helpers/helped_function.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import './helpers/Ingredients.dart';
import 'models/barcode_api.dart';


class PantryScreen extends StatefulWidget {
  const PantryScreen({Key? key}) : super(key: key);


  @override
  State<PantryScreen> createState() => _PantryScreenState();
}

class _PantryScreenState extends State<PantryScreen> {
  List ingredientsList = List.empty(growable: true);
  final db = FirebaseFirestore.instance.collection('pantry');
  late  String barcodeScanNumber = '';
  String title = "";
  String description = "";
  String productName='';
  @override
  void initState() {
    super.initState();
    // initIngredients();
  }

  void addIngredient(String ingredient)
  {
    String id = db.doc().id;
    db.doc(id).set({"name":ingredient,"id":id});
    ingredientsList.add(ingredient);
  }




  Future<void> scanBarcode() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode("#ff6666", "Cancel", false, ScanMode.DEFAULT);
    barcodeScanNumber = barcodeScanRes ;
    print("barcode scanned!$barcodeScanRes");
    // return barcodeScanRes;
  }


  deleteIngredients(item) async {
     final db = FirebaseFirestore.instance;
     db.collection("pantry").doc(item).delete().then(
          (doc) => print("Document deleted"),
      onError: (e) => print("Error updating document $e"),

    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("pantry").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong kkkkkkkkkk');
            } else if (snapshot.hasData || snapshot.data != null) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    QueryDocumentSnapshot<Object?>? documentSnapshot =
                    snapshot.data?.docs[index];
                    ingredientsList.add(documentSnapshot!["name"]);
                    return Dismissible(
                        key: Key(index.toString()),
                        child: Card(
                          elevation: 4,
                          child: ListTile(
                            title: Text( documentSnapshot["name"]),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                             // color: Colors.red,
                              onPressed: () {
                                 setState(() {
                                   deleteIngredients((documentSnapshot  != null) ? (documentSnapshot["id"]) : "");

                                });

                              },
                            ),
                          ),
                        ));
                  });
            }
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.red,
                ),
              ),
            );
          },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,

        children: [
          FloatingActionButton(
            onPressed: () async {
              await showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return  MultiSelectBottomSheet(
                      searchable: true,
                      items: ingredients_list.map((e) => MultiSelectItem<dynamic>(e,e)).toList(),
                      listType: MultiSelectListType.LIST,
                      onConfirm: (values) {
                        setState(() {
                          for (var ingredient in  values)
                          {
                            addIngredient(ingredient as String);
                          }
                        },
                        );

                      }, initialValue: [],
                    );
                  });
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          FloatingActionButton(onPressed:() async {
            scanBarcode();
            await BarcodeApi.getProductName( barcodeScanNumber);
            setState(() {
             productName= BarcodeApi.productName;
            if(productName != "product not found")
              {
                if(!ingredientsList.contains(productName)) {
                  addIngredient(productName);
                }
                else{
                  showErrorMessage("product already in your pantry ", context);
                }

              }
           else
              {
                showErrorMessage("product not found", context);
              }
           });
          }  ,
          child: Icon(Icons.camera,),),
        ],
      ),

    );
  }
}
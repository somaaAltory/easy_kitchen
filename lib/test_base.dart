import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import './helpers/Ingredients.dart';

class PantryScreen extends StatefulWidget {
  const PantryScreen({Key? key}) : super(key: key);


  @override
  State<PantryScreen> createState() => _PantryScreenState();
}

class _PantryScreenState extends State<PantryScreen> {
  List todos = List.empty(growable: true);
  String title = "";
  String description = "";
  @override
  void initState() {
    super.initState();
    // initIngredients();
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
                    // todos.add(documentSnapshot);
                    return Dismissible(
                        key: Key(index.toString()),
                        child: Card(
                          elevation: 4,
                          child: ListTile(
                            title: Text((documentSnapshot != null) ? (documentSnapshot["name"]) : ""),
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
      floatingActionButton: FloatingActionButton(
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
                      for (var i in  values)
                      {
                        var  db = FirebaseFirestore.instance;
                        String id = db.collection('pantry').doc().id;
                        db.collection("pantry").doc(id).set({"name":i,"id":id});
                        // todos.add({"name":i,"id":id} );
                      }

                    },
                    );

                  }, initialValue: [],
                );
                // return AlertDialog(
                //   shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(10)),
                //   title: const Text("Add Ingredient"),
                //   content: Container(
                //     width: 400,
                //     height: 100,
                //     child: Column(
                //       children: [
                //         TextField(
                //           onChanged: (String value) {
                //             title = value;
                //           },
                //         ),
                //         TextField(
                //           onChanged: (String value) {
                //             description = value;
                //           },
                //         ),
                //       ],
                //     ),
                //   ),
                //   actions: <Widget>[
                //     TextButton(
                //         onPressed: () {
                //           setState(() {
                //             //todos.add(title);
                //            // createToDo();
                //           });
                //           Navigator.of(context).pop();
                //         },
                //         child: const Text("Add"))
                //   ],
                // );
              });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
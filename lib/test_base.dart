import 'package:easy_kitchen/models/Ingredients.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'helpers/Ingredients.dart';


class PantryScreen extends StatefulWidget {
  const PantryScreen({Key? key}) : super(key: key);


  @override
  State<PantryScreen> createState() => _PantryScreenState();
}

class _PantryScreenState extends State<PantryScreen> {
  List todos = List.empty();
  String title = "";
  String description = "";
  @override
  void initState() {
    super.initState();
   // initIngredients();
  }


  deleteTodo(item) {

    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("pantry").doc(item);

    documentReference.delete().whenComplete(() => print("deleted successfully"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("pantry").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          } else if (snapshot.hasData || snapshot.data != null) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  QueryDocumentSnapshot<Object?>? documentSnapshot =
                  snapshot.data?.docs[index];
                  return Dismissible(
                      key: Key(index.toString()),
                      child: Card(
                        elevation: 4,
                        child: ListTile(
                          title: Text((documentSnapshot != null) ? (documentSnapshot["name"]) : ""),
                          // subtitle: Text((documentSnapshot != null)
                          //     ? ((documentSnapshot["todoDesc"] != null)
                          //     ? documentSnapshot["todoDesc"]
                          //     : "")
                          //     : ""),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                           // color: Colors.red,
                            onPressed: () {
                              setState(() {
                                todos.removeAt(index);
                                deleteTodo((documentSnapshot != null) ? (documentSnapshot["id"]) : "");
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
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  title: const Text("Add Todo"),
                  content: Container(
                    width: 400,
                    height: 100,
                    child: Column(
                      children: [
                        TextField(
                          onChanged: (String value) {
                            title = value;
                          },
                        ),
                        TextField(
                          onChanged: (String value) {
                            description = value;
                          },
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () {
                          setState(() {
                            //todos.add(title);
                           // createToDo();
                          });
                          Navigator.of(context).pop();
                        },
                        child: const Text("Add"))
                  ],
                );
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
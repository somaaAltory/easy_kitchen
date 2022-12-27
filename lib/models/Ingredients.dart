import 'package:cloud_firestore/cloud_firestore.dart';

class Ingredient{
  String name;
  String id;

  Ingredient( this.name, this.id);

  Map <String, dynamic> toJson() => {
    'name': name,
    'id': id,
  };

  // initIngredients(List Ingredients_list) {
  //   for (var element in Ingredients_list  ) {
  //     DocumentReference documentReference =
  //     FirebaseFirestore.instance.collection("pantry").doc();
  //     Ingredient ingredient=Ingredient(element , documentReference.id);
  //
  //     documentReference.set(ingredient.toJson())
  //         .whenComplete(() => print("Data stored successfully"));
  //   }
  // }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';



@immutable
class Ingredient extends Equatable {
   Ingredient({required this.expirationDate,required this.name,required this.id});
  final String? name;
  final String id;
  late Timestamp? expirationDate;

  @override


  factory Ingredient.fromMap(Map<String, dynamic> data, String id) {
    final name = data['name'] as String;
    final expirationDate = data['expirationDate'] as Timestamp;
    return Ingredient(
      expirationDate: expirationDate,
      name: name,
      id: id
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'expirationDate':expirationDate
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  // @override
  // // TODO: implement props
  // List<Object?> get props => throw UnimplementedError();


}
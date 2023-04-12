import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';



@immutable
class Ingredient extends Equatable {
  const Ingredient({required this.name,required this.id});
  final String? name;
  final String id;


  @override
  // List<Object> get props => [name];


  factory Ingredient.fromMap(Map<String, dynamic> data, String id) {
    final name = data['name'] as String;
    return Ingredient(
      name: name,
      id: id
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
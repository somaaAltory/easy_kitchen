import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_kitchen/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  createUser(UserModel user) async{
    await _db.collection("users").add(user.toJson()).whenComplete(
            () =>
            Get.snackbar(
              "Success",
              "Your account has been created.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Color.fromRGBO(76, 175, 80, 0.1),
              colorText: Color.fromRGBO(76, 175, 80, 10),)
    )
        .catchError((error, stackTrace) {
      Get.snackbar(("Error"), "Somthing went wrong .Try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Color.fromRGBO(244, 67, 54, 0.1));
      print(error.toString());
    });
  }
  }


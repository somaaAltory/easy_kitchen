import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;


class BarcodeApi{
  static String productName = '';


  static Future<void> getProductName(String barcode) async {

    final response = await http.get(Uri.parse(
        'https://world.openfoodfacts.org/api/v0/product/$barcode.json'));
    Map data = jsonDecode(response.body);
     if (data['status']==0)
       {
         productName= 'product not found';
       }
     else
       {
         productName=data['product']['product_name'];
       }
     print("product name $productName");

  }

}
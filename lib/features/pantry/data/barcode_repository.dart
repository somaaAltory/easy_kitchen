import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class barodeRepository {
  barodeRepository(this._client);
  final http.Client _client;
  //final String _api;
  Future<String> getProductName(String barcode) async {
    final response = await http.get(Uri.parse(
        'https://world.openfoodfacts.org/api/v0/product/$barcode.json'));
    Map data = jsonDecode(response.body);
    if (data['status'] == 0) {
      return "product not found";
    } else {

      return data['product']['product_name'];
    }
  }
}

final barcodeRepositoryProvider = Provider<barodeRepository>((ref) {
  return barodeRepository(http.Client());
});

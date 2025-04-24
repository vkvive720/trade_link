import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/models/product_model.dart';

import '../global_varibles.dart';


class ProductController {
  // Load the uploaded products.
  Future<List<Product>> loadPopularProducts() async {
    try {
      final http.Response response = await http.get(
        Uri.parse("$uri/api/popular-products"),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      print(response.body);

      if (response.statusCode == 200) {
        final jsonBody = jsonDecode(response.body);
        List<dynamic> data;

        // Check if the response is a list or a map containing products.
        if (jsonBody is List) {
          data = jsonBody;
        } else if (jsonBody is Map<String, dynamic> &&
            jsonBody.containsKey('products')) {
          data = jsonBody['products'];
        } else {
          throw Exception("Invalid JSON structure");
        }

        List<Product> products = data
            .map((json) =>
            Product.fromMap(json as Map<String, dynamic>))
            .toList();

        return products;
      } else {
        throw Exception("Failed to load products: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to load products: $e");
    }
  }

  Future<List<Product>> loadProductByCategory(String category)async{
    try{
      final http.Response response = await http.get(Uri.parse("$uri/api/products-by-category/$category"),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },);
      print(response.body);

      if (response.statusCode == 200) {
        final jsonBody = jsonDecode(response.body);
        List<dynamic> data;

        // Check if the response is a list or a map containing products.
        if (jsonBody is List) {
          data = jsonBody;
        } else if (jsonBody is Map<String, dynamic> &&
            jsonBody.containsKey('products')) {
          data = jsonBody['products'];
        } else {
          throw Exception("Invalid JSON structure");
        }

        List<Product> products = data
            .map((json) =>
            Product.fromMap(json as Map<String, dynamic>))
            .toList();


        return products;
      } else {
        throw Exception("Failed to load products: ${response.statusCode}");
        return [];
      }

    }
    catch(e)
    {
      throw Exception("Failed to load products: $e");
      return [];

    }

  }
}

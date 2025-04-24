import 'dart:io';
import 'dart:convert';


import 'package:http/http.dart' as http;

import '../global_varibles.dart';
import '../models/category_model.dart';
import '../services/manage_http_response.dart';


class CategoryController {
 

  // Load the uploaded categories.
  Future<List<Category>> loadCategories() async {
    try {
      http.Response response = await http.get(
        Uri.parse("$uri/api/categories"),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        final jsonBody = jsonDecode(response.body);
        List<dynamic> data;

        // Check if the response is already a list.
        if (jsonBody is List) {
          data = jsonBody;
        }
        // If it's a Map, extract the list from the 'categories' key.
        else if (jsonBody is Map<String, dynamic> &&
            jsonBody.containsKey('categories')) {
          data = jsonBody['categories'];
        } else {
          throw Exception("Invalid JSON structure");
        }

        List<Category> categories = data
            .map((category) =>
            Category.fromMap(category as Map<String, dynamic>))
            .toList();

        return categories;
      } else {
        throw Exception("Failed to load categories");
      }
    } catch (e) {
      throw Exception("Failed to load categories: $e");
    }
  }

}


import 'dart:convert';
import 'package:http/http.dart' as http;
import '../global_varibles.dart';
import '../models/sub_category_model.dart';

class SubcategoryController {
  Future<List<Subcategory>> getSubcategoryByName(String categoryName) async {
    try {
      final url = Uri.parse("$uri/api/category/$categoryName/subcategories");
      final http.Response response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        if (data.isNotEmpty) {
          return data.map((subcategory) => Subcategory.fromJson(subcategory)).toList();
        } else {
          print("No subcategories found");
          return [];
        }
      }
      else if(response.statusCode==404)
      {
        print("subCategoriesnot found eooro 404");
        return [];
      }
      else {
        print("Error: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Exception occurred in fecting subcategories: $e");
      return [];
    }
    // return [];
  }
}

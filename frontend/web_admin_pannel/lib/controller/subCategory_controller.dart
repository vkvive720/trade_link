import 'dart:convert';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:http/http.dart' as http;
import 'package:web_admin_pannel/models/subCategoru_models.dart';
import 'package:web_admin_pannel/services/manage_http_response.dart';

import '../global_variable.dart';

class SubCategoryController {
  Future<void> uploadSubcategory({
    required String categoryId,
    required String categoryName,
    required dynamic pickedImage,
    required String subCategoryName,
    required context,
  }) async {
    try {
      final cloudinary = CloudinaryPublic("dtnvzpzsv", "o8in1ps3");
      CloudinaryResponse imageResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(
          pickedImage,
          identifier: "pickedImage",
          folder: 'categoryImage',
        ),
      );
      var url = Uri.parse("$uri/api/subcategories");
      String image = imageResponse.secureUrl;

      Subcategory subcategory = Subcategory(
        id: "",
        categoryId: categoryId,
        categoryName: categoryName,
        image: image,
        subcategoryName: subCategoryName,
      );

      var response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: subcategory.toJson(),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      manageHttpResponse(response: response, context: context, onSuccess: () {
        showSnackBar(context, "Subcategory Uploaded Successfully");
      });
    } catch (e) {
      print("Error uploading subcategory: $e");
    }
  }

  // Load all subcategories.
  Future<List<Subcategory>> loadSubcategories() async {
    try {
      http.Response response = await http.get(
        Uri.parse("$uri/api/subcategories"),
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
        // If it's a Map, extract the list from the 'subcategories' key.
        else if (jsonBody is Map<String, dynamic> &&
            jsonBody.containsKey('subcategories')) {
          data = jsonBody['subcategories'];
        } else {
          throw Exception("Invalid JSON structure");
        }

        List<Subcategory> subcategories = data
            .map((item) => Subcategory.fromJson(item as Map<String, dynamic>))
            .toList();

        return subcategories;
      } else {
        throw Exception("Failed to load subcategories");
      }
    } catch (e) {
      throw Exception("Failed to load subcategories: $e");
    }
  }
}

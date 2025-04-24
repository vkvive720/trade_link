import 'dart:io';
import 'dart:convert';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:http/http.dart' as http;
import 'package:web_admin_pannel/services/manage_http_response.dart';

import '../global_variable.dart';
import '../models/category_screen.dart';

class CategoryController {
  Future<void> uploadCategory({
    required dynamic pickedImage,
    required dynamic pickedBanner,
    required String name,
    required context,
  }) async {
    try {
      // Upload images to Cloudinary.
      final cloudinary = CloudinaryPublic("dtnvzpzsv", "o8in1ps3");
      CloudinaryResponse imageResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(
          pickedImage,
          identifier: "pickedImage",
          folder: 'categoryImage',
        ),
      );
      String image = imageResponse.secureUrl;

      CloudinaryResponse bannerResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(
          pickedBanner,
          identifier: "pickedBanner",
          folder: 'categoryImage',
        ),
      );
      String banner = bannerResponse.secureUrl;

      print("Image URL: $image");
      print("Banner URL: $banner");

      // Build the URL in the module style.
      // If your backend is hosted locally at 192.168.0.107:3000, use Uri.http.
      // If your backend supports HTTPS, use Uri.https.
      // Here, we're using HTTP:
      // var url = Uri.http(uri, "/api/categories");
      var url = Uri.parse("$uri/api/categories");

      // Create the category object.
      Category category = Category(
        id: "", // backend will generate _id if applicable.
        name: name,
        image: image,
        banner: banner,
      );

      // Send a POST request with JSON data.
      var response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: category.toJson(),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      // Handle the response.
      manageHttpResponse(response: response, context: context, onSuccess: () {
        showSnackBar(context, "Uploaded Category");
      });
    } catch (e) {
      print("Error uploading to Cloudinary or posting category: $e");
    }
  }

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

import 'dart:io';


import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:http/http.dart' as http;
import 'package:vendor_app/models/product.dart';
import 'package:vendor_app/services/manage_http_response.dart';

import '../global_varibles.dart';

class ProductController {
  Future<void> uploadProduct({
    required String productName,
    required String fullName,
    required int productPrice,
    required int quantity,
    required String description,
    required String category,
    required String subCategory,
    required String vendorId,
    required List<File>? pickedImages,
    required context,
  }) async {
    try {
      List<String> images = [];

      if (pickedImages != null && pickedImages.isNotEmpty) {
        final cloudinary = CloudinaryPublic("dtnvzpzsv", "o8in1ps3");
        print("Total images picked: ${pickedImages.length}");

        for (var i = 0; i < pickedImages.length; i++) {
          try {
            print("Uploading image ${i + 1}/${pickedImages.length}: ${pickedImages[i].path}");

            CloudinaryResponse imageResponse = await cloudinary.uploadFile(
              CloudinaryFile.fromFile(
                pickedImages[i].path,  // Using fromFile instead of fromBytesData
                folder: productName,
              ),
            );

            print("Upload success: ${imageResponse.secureUrl}");
            images.add(imageResponse.secureUrl);
          } catch (e) {
            print("Cloudinary upload failed for image ${i + 1}: $e");
          }
        }

        // Debug: Ensure images list is populated
        print("Final Image URLs: $images");
        if (images.isEmpty) {
          showSnackBar(context, "Image upload failed. Please try again.");
          return;
        }

        if (category.isNotEmpty && subCategory.isNotEmpty) {
          final Product product = Product(
            id: "", // Check if an empty id is valid
            vendorId: vendorId,
            productName: productName,
            images: images,
            productPrice: productPrice,
            quantity: quantity,
            fullName: fullName,
            category: category,
            subcategory: subCategory,
            description: description,
          );

          // Debug: Print JSON payload
          String jsonPayload = product.toJson();
          print("JSON Payload: $jsonPayload");

          http.Response response = await http.post(
            Uri.parse("$uri/api/add-product"),
            headers: {
              "Content-Type": "application/json; charset=UTF-8",
            },
            body: jsonPayload,
          );

          print("Response Status: ${response.statusCode}");
          print("Response Body: ${response.body}");

          manageHttpResponse(
              response: response,
              context: context,
              onSuccess: () {
                showSnackBar(context, "Product uploaded successfully!");
              });
        } else {
          showSnackBar(context, "Please select both a category and subcategory");
        }
      } else {
        showSnackBar(context, "Please pick at least one image");
      }
    } catch (e) {
      // Handle errors here
      showSnackBar(context, "Error uploading product: $e");
    }
  }
}

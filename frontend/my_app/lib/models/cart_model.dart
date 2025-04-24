import 'dart:convert';

class Cart {
  final String productName;
  final int productPrice;
  final String category;
  final List<String> images; // Assuming list of image URLs or paths.
  final String vendorID;
  final int productQuantity; // Total available quantity of the product.
  final int quantity;        // Quantity added to the cart.
  final String productID;    // Changed from int to String.
  final String description;
  final String fullName;     // Vendor full name.

  Cart({
    required this.productName,
    required this.productPrice,
    required this.category,
    required this.images,
    required this.vendorID,
    required this.productQuantity,
    required this.quantity,
    required this.productID,
    required this.description,
    required this.fullName,
  });

  // Convert Cart object to a Map.
  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'productPrice': productPrice,
      'category': category,
      'images': images,
      'vendorID': vendorID,
      'productQuantity': productQuantity,
      'quantity': quantity,
      'productID': productID,
      'description': description,
      'fullName': fullName,
    };
  }

  // Convert the Cart object to a JSON string.
  String toJson() => jsonEncode(toMap());

  // Create a Cart object from a Map.
  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      productName: map['productName'] as String,
      productPrice: map['productPrice'] as int,
      category: map['category'] as String,
      images: List<String>.from(map['images']),
      vendorID: map['vendorID'] as String,
      productQuantity: map['productQuantity'] as int,
      quantity: map['quantity'] as int,
      productID: map['productID'] as String,
      description: map['description'] as String,
      fullName: map['fullName'] as String,
    );
  }

  // Create a Cart object from a JSON string.
  factory Cart.fromJson(String source) => Cart.fromMap(jsonDecode(source));
}

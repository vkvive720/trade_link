import 'dart:convert';

class Product {
  final String id;
  final String vendorId;
  final String fullName; // New field as per backend schema
  final String productName;
  final List<String> images;
  final int productPrice; // Updated from "price"
  final int quantity;
  final String category;
  final String subcategory;
  final String description;

  Product({
    required this.id,
    required this.vendorId,
    required this.fullName,
    required this.productName,
    required this.images,
    required this.productPrice,
    required this.quantity,
    required this.category,
    required this.subcategory,
    required this.description,
  });

  // Serialization: Convert Product object to a Map so we can easily convert it to JSON
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'vendorId': vendorId,
      'fullName': fullName,
      'productName': productName,
      'images': images,
      'productPrice': productPrice,
      'quantity': quantity,
      'category': category,
      'subcategory': subcategory,
      'description': description,
    };
  }

  // Convert Product to JSON string
  String toJson() => jsonEncode(toMap());

  // Deserialization: Create a Product object from a Map
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['_id'] as String? ?? '',
      vendorId: map['vendorId'] as String? ?? '',
      fullName: map['fullName'] as String? ?? '',
      productName: map['productName'] as String? ?? '',
      images: List<String>.from(map['images'] as List<dynamic>? ?? []),
      productPrice: map['productPrice'] as int? ?? 0,
      quantity: map['quantity'] as int? ?? 0,
      category: map['category'] as String? ?? '',
      subcategory: map['subcategory'] as String? ?? '',
      description: map['description'] as String? ?? '',
    );
  }

  // Convert JSON string back to a Product object
  factory Product.fromJson(String source) =>
      Product.fromMap(jsonDecode(source) as Map<String, dynamic>);
}

import 'dart:convert';

class Subcategory {
  final String id;
  final String categoryId;
  final String categoryName;
  final String image;
  final String subcategoryName;

  Subcategory({
    required this.id,
    required this.categoryId,
    required this.categoryName,
    required this.image,
    required this.subcategoryName,
  });

  // Serialization: Convert Subcategory object to a Map using '_id' as key for id.
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'image': image,
      'subcategoryName': subcategoryName,
    };
  }

  // Convert Subcategory object to JSON string.
  String toJson() => jsonEncode(toMap());

  // Deserialization: Create a Subcategory object from a Map.
  factory Subcategory.fromJson(Map<String, dynamic> map) {
    return Subcategory(
      id: map['_id'] as String? ?? '',
      categoryId: map['categoryId'] as String? ?? '',
      categoryName: map['categoryName'] as String? ?? '',
      image: map['image'] as String? ?? '',
      subcategoryName: map['subcategoryName'] as String? ?? '',
    );
  }

  // Convert from JSON string to a Subcategory object.

}

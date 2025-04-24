import 'dart:convert';

class Category {
  final String id;
  final String name;
  final String image;
  final String banner;

  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.banner,
  });

  // Serialization: Convert Category object to a Map using '_id' as key for id.
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'image': image,
      'banner': banner,
    };
  }

  // Convert Category object to JSON string.
  String toJson() => jsonEncode(toMap());

  // Deserialization: Create a Category object from a Map.
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['_id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      image: map['image'] as String? ?? '',
      banner: map['banner'] as String? ?? '',
    );
  }

  // Convert from JSON string to a Category object.
  factory Category.fromJson(String source) =>
      Category.fromMap(jsonDecode(source) as Map<String, dynamic>);
}

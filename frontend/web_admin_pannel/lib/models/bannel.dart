import 'dart:convert';

class BannerModel {
  final String id;
  final String image;

  BannerModel({required this.id, required this.image});

  // Serialization: Convert BannerModel object to a Map using '_id' as key for id.
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'image': image,
    };
  }

  // Convert BannerModel object to JSON string.
  String toJson() => jsonEncode(toMap());

  // Deserialization: Create a BannerModel object from a Map.
  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(
      id: map['_id'] as String? ?? '',
      image: map['image'] as String? ?? '',
    );
  }


  // Convert from JSON string to a BannerModel object.
  factory BannerModel.fromJson(String source) =>
      BannerModel.fromMap(jsonDecode(source) as Map<String, dynamic>);
}

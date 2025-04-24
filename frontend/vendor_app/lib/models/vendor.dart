import 'dart:convert';

class Vendor {
  final String id;
  final String fullName;
  final String email;
  final String state;
  final String city;
  final String locality;
  final String role;
  final String password;

  Vendor({
    required this.id,
    required this.fullName,
    required this.email,
    required this.state,
    required this.city,
    required this.locality,
    required this.role,
    required this.password,
  });

  // Serialization: Convert Vendor object to a Map so we can eaisly convert to json
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'state': state,
      'city': city,
      'locality': locality,
      'role': role,
      'password': password, // Store passwords securely in real apps
    };
  }

  // Convert to  back to JSON
  String toJson() => jsonEncode(toMap());

  // Deserialization: Create a Vendor object from a Map
  factory Vendor.fromMap(Map<String, dynamic> map) {
    return Vendor(
      id: map['_id'] as String? ?? '',
      fullName: map['fullName'] as String? ?? '',
      email: map['email'] as String? ?? '',
      state: map['state'] as String? ?? '',
      city: map['city'] as String? ?? '',
      locality: map['locality'] as String? ?? '',
      role: map['role'] as String? ?? '',
      password: map['password'] as String? ?? '',
    );
  }

  // Convert from JSON
  factory Vendor.fromJson(String source) =>
      Vendor.fromMap(jsonDecode(source) as Map<String, dynamic>);
}

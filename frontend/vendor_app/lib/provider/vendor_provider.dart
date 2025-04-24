import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/vendor.dart';

class VendorProvider extends StateNotifier<Vendor?> {
  // Initialize with null to indicate no vendor is logged in
  VendorProvider() : super(null);

  // Setter: update vendor from JSON
  void setVendor(String vendorJson) {
    state = Vendor.fromJson(vendorJson);
  }

  // Clear the vendor state (e.g. on logout)
  void signOut() {
    state = null;
  }

  void clearVendor() {
    state = null;
  }
}

final vendorProvider = StateNotifierProvider<VendorProvider, Vendor?>(
      (ref) => VendorProvider(),
);

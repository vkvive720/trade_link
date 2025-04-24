import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendor_app/provider/vendor_provider.dart';
import 'package:vendor_app/views/main_screen.dart';
import 'package:vendor_app/views/vendor_auth_screen/vendor_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // Check for a saved vendor token and vendor data, then update the vendor state.
  Future<void> _checkTokenAndSetVendor(WidgetRef ref) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('vendor_auth_token');
    String? vendorJson = preferences.getString('vendor');
    if (token != null && vendorJson != null) {
      ref.read(vendorProvider.notifier).setVendor(vendorJson);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vendor App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: VendorMainScreen(),
      // home: FutureBuilder(
      //   future: _checkTokenAndSetVendor(ref),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const Center(child: CircularProgressIndicator());
      //     }
      //     final vendor = ref.watch(vendorProvider);
      //     // If a vendor is logged in, show the vendor main screen; otherwise, the login screen.
      //     return vendor != null ? const VendorMainScreen() : const VendorLoginScreen();
      //   },
      // ),
    );
  }
}



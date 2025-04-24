import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vendor_app/views/vendor_auth_screen/vendor_registor_screen.dart';
// Import your vendor main screen

import '../../controllers/vendor_auth_controller.dart';
import '../main_screen.dart';

class VendorLoginScreen extends ConsumerStatefulWidget {
  const VendorLoginScreen({Key? key}) : super(key: key);

  @override
  _VendorLoginScreenState createState() => _VendorLoginScreenState();
}

class _VendorLoginScreenState extends ConsumerState<VendorLoginScreen> {
  bool _obscurePassword = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final VendorAuthController _vendorAuthController = VendorAuthController();
  late String email;
  late String password;
  bool _isLoading = false; // Flag for loading state

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Title
                  Text(
                    "Login Your Vendor Account",
                    style: GoogleFonts.lato(
                      color: const Color(0xFF0d120E),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.2,
                      fontSize: 23,
                    ),
                  ),
                  // Subtitle
                  Text(
                    'Manage your vendor operations seamlessly',
                    style: GoogleFonts.lato(
                      color: const Color(0xFF0d120E),
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Illustration Image (use vendor-specific image if available)
                  Image.asset(
                    'assets/images/Illustration.png',
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(height: 16),
                  // Email Label
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24),
                      child: Text(
                        'Email',
                        style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  // Email TextField
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: TextFormField(
                      onChanged: (value) {
                        email = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  // Password Label
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24, top: 8),
                      child: Text(
                        'Password',
                        style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  // Password TextField with hide/show icon
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: TextFormField(
                      onChanged: (value) {
                        password = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your password';
                        }
                        return null;
                      },
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Sign in Button with loading indicator
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6C63FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: _isLoading
                            ? null
                            : () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _isLoading = true;
                            });
                            try {
                              await _vendorAuthController.signInVendor(
                                context: context,
                                email: email,
                                password: password,
                                ref: ref,
                              );
                              // After successful sign in, navigate to the vendor main screen.
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const VendorMainScreen(),
                                ),
                                    (route) => false,
                              );
                            } finally {
                              setState(() {
                                _isLoading = false;
                              });
                            }
                          }
                        },
                        child: _isLoading
                            ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                            : Text(
                          'Sign in',
                          style: GoogleFonts.lato(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Navigation to Vendor Register Screen
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Need an account? ",
                        style: GoogleFonts.nunitoSans(),
                      ),
                      InkWell(
                        onTap: () {
                          // Navigate to Vendor Register screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const VendorRegisterScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Sign up",
                          style: GoogleFonts.nunitoSans(
                            color: const Color(0xFF6C63FF),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

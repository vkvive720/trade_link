import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vendor_app/views/vendor_auth_screen/vendor_sign_in.dart';

import '../../controllers/vendor_auth_controller.dart';


class VendorRegisterScreen extends StatefulWidget {
  const VendorRegisterScreen({Key? key}) : super(key: key);

  @override
  State<VendorRegisterScreen> createState() => _VendorRegisterScreenState();
}

class _VendorRegisterScreenState extends State<VendorRegisterScreen> {
  bool _obscurePassword = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final VendorAuthController _vendorAuthController = VendorAuthController();

  late String email;
  late String fullName;
  late String password;
  late String role;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              // The Column is centered vertically.
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Title
                  Text(
                    "SignUp Your Vendor Account",
                    style: GoogleFonts.getFont(
                      'Lato',
                      color: const Color(0xFF0d120E),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.2,
                      fontSize: 23,
                    ),
                  ),
                  // Subtitle
                  Text(
                    'Manage your vendor operations seamlessly',
                    style: GoogleFonts.getFont(
                      'Lato',
                      color: const Color(0xFF0d120E),
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Illustration Image
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
                        style: GoogleFonts.getFont(
                          'Nunito Sans',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  // Email TextField
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: TextFormField(
                      onChanged: (value) {
                        email = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Enter your email';
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

                  // Full Name Label
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24, top: 8),
                      child: Text(
                        'Full Name',
                        style: GoogleFonts.getFont(
                          'Nunito Sans',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  // Full Name TextField
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: TextFormField(
                      onChanged: (value) {
                        fullName = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Enter your full name';
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter your full name',
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),

                  // Role Label
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24, top: 8),
                      child: Text(
                        'Role',
                        style: GoogleFonts.getFont(
                          'Nunito Sans',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  // Role TextField
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: TextFormField(
                      onChanged: (value) {
                        role = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Enter your role';
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter your role',
                        prefixIcon: const Icon(Icons.business),
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
                        style: GoogleFonts.getFont(
                          'Nunito Sans',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  // Password TextField with hide/show icon
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: TextFormField(
                      onChanged: (value) {
                        password = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Enter your password';
                        return null;
                      },
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
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

                  // Sign Up Button
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
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await _vendorAuthController.signUpVendor(
                              context: context,
                              email: email,
                              fullName: fullName,
                              password: password,
                              role: role,
                            );
                          }
                        },
                        child: Text(
                          'Sign Up',
                          style: GoogleFonts.getFont(
                            'Lato',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Already have an account? Login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: GoogleFonts.getFont('Nunito Sans'),
                      ),
                      InkWell(
                        onTap: () {
                          // Navigate to Vendor Login screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const VendorLoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Sign in",
                          style: GoogleFonts.getFont(
                            'Nunito Sans',
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

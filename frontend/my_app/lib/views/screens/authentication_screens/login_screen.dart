import 'dart:core';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/controllers/auth_controller.dart';
import 'package:my_app/views/screens/authentication_screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  AuthController _authController = AuthController();
  late String email;
  late String password;
  bool _isLoading = false; // Added flag for loading state

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formkey,
          child: Center(
            child: SingleChildScrollView(
              // The Column is centered vertically.
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Title
                  Text(
                    "Login Your Account",
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
                    'To Explore the world exclusive',
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
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: TextFormField(
                      onChanged: (value) {
                        email = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) return 'enter the email';
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'enter your email',
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
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: TextFormField(
                      onChanged: (value) {
                        password = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) return 'enter your password';
                        return null;
                      },
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        hintText: 'enter your password',
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
                        // Disable button when loading
                        onPressed: _isLoading
                            ? null
                            : () async {
                          if (_formkey.currentState!.validate()) {
                            setState(() {
                              _isLoading = true;
                            });
                            try {
                              await _authController.signInUsers(
                                context: context,
                                email: email,
                                password: password,
                              );
                            } finally {
                              setState(() {
                                _isLoading = false;
                              });
                            }
                          } else {
                            print("fail");
                          }
                        },
                        child: _isLoading
                            ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                            : Text(
                          'Sign in',
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
                        "Need an account? ",
                        style: GoogleFonts.getFont('Nunito Sans'),
                      ),
                      InkWell(
                        onTap: () {
                          // Navigate to Register screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegisterScreen()),
                          );
                        },
                        child: Text(
                          "Sign up",
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

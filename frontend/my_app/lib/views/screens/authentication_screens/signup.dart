import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // The Column is centered vertically. If you want it starting
        // from the top, remove 'mainAxisAlignment: center'.
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

            // Illustration
            Image.asset(
              'assets/images/Illustration.png',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 16),

            // Email label
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
            // Email text field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'enter your email',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),

            // Password label
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
            // Password text field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'enter your password',
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Sign Up button
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
                  onPressed: () {
                    // Handle sign-up logic here
                  },
                  child: Text(
                    'Sign Up',
                    style: GoogleFonts.getFont(
                      'Lato',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
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
                    // Navigate to Login screen
                  },
                  child: Text(
                    "Login",
                    style: GoogleFonts.getFont(
                      'Nunito Sans',
                      color: Color(0xFF6C63FF),
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
    );
  }
}

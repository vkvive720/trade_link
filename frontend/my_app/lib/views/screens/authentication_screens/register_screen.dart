import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/controllers/auth_controller.dart';
import 'package:my_app/views/screens/authentication_screens/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<RegisterScreen> {
  bool _obscurePassword = true;
  final GlobalKey<FormState> _formkey= GlobalKey<FormState>();
  final AuthController _authController=AuthController();
  late String email;
  late String fullName;
  late String password;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key:_formkey,
          child: Center(
            child: SingleChildScrollView(
              // The Column is centered vertically.
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Title
                  Text(
                    "SignUp Your Account",
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
                    padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: TextFormField(
                      onChanged: (value){
                        email=value;
                      },
                      validator: (value){
                        if(value!.isEmpty) return 'enter your email';
                        else return null;

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
          
                  // New Full Name Label
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
                      onChanged: (value){
                        fullName=value;
                      },
                      validator: (value){
                        if(value!.isEmpty ) return 'fill the name';
                        else return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'enter your full name',
                        prefixIcon: const Icon(Icons.person),
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
                      onChanged: (value){
                        password=value;
                      },
                      validator: (value){
                        if(value!.isEmpty) return 'Fill the Password';
                        else return null;
                      },
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        hintText: 'enter your password',
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
                        onPressed: () async{
                          // Handle sign up logic here
                          print(email);print(fullName);print(password);

                          if(_formkey.currentState!.validate())
                            {
                              print("corect data");
                              await _authController.signUpUser(context: context, email: email, fullName: fullName, password: password);
                            }
                          else{
                            print("failed sometih");
                          }
                          // Handle sign up logic here
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
                        "Already Have an account? ",
                        style: GoogleFonts.getFont('Nunito Sans'),
                      ),
                      InkWell(
                        onTap: () {
                          // Navigate to Login screen
                          print("going to login screen");
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginScreen()));
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

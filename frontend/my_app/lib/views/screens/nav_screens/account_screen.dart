import 'package:flutter/material.dart';
import 'package:my_app/controllers/auth_controller.dart';

class AccountScreen extends StatelessWidget {

  final AuthController _authController =AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: (){
              _authController.signOutUser(context: context); 
            },
            child: Text("SignOut")),
      ),
    );;
  }
}

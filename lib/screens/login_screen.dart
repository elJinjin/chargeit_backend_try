import 'dart:developer';
import 'package:chargit/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  final _auth = AuthService();
  
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
    @override
  void dispose() {
    // super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  // Function to handle the login action
  void handleLogin(BuildContext context) {
    String email = emailController.text;
    String password = passwordController.text;

    // Print the values or use them in your logic
    print('Email: $email');
    print('Password: $password');

    // You can now pass this data to a backend or navigate to another screen
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Login", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _signIn(context),
                child: Text("Login"),
              ),
              TextButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen())),
                child: Text("Don't have an account? Signup"),
              ),
            ],
          ),
        ),
      ),
    );
  }
  gotoHomeScreen(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  _signIn(BuildContext context)async{
    final user = await _auth.loginUserWithEmailAndPassword(emailController.text, passwordController.text);
    if (user != null){
      log("User logged in successfully");
      gotoHomeScreen(context);
    }
  }
}

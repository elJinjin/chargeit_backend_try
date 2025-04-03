import 'dart:developer';
import 'package:chargit/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'home_screen.dart';

class SignupScreen extends StatelessWidget {
  final _auth = AuthService();
  
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Signup", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Name"),
              ),
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
                onPressed: () => _signup(context),
                child: Text("Signup"),
              ),
              TextButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen())),
                child: Text("Already have an account? Login"),
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
  
  _signup(BuildContext context)async {
    final user = await _auth.createUserWithEmailAndPassword(emailController.text, passwordController.text);
    if (user != null){
      log("User created successfully");
      gotoHomeScreen(context);
    }
  }

}


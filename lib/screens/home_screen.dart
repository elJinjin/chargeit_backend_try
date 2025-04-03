import 'package:chargit/screens/login_screen.dart';
import 'package:chargit/services/auth_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthService _auth = AuthService();
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await _auth.signout();
            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
          },
          child: Text("Logout"),
        ),
      ),
    );
  }
}

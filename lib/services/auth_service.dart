import 'dart:developer';  // Importing the log function to log errors for debugging

import 'package:firebase_auth/firebase_auth.dart';  // Importing FirebaseAuth for user authentication

class AuthService {
  // Create an instance of FirebaseAuth to interact with Firebase's authentication system
  final _auth = FirebaseAuth.instance;

  // Function to create a new user with email and password
  Future<User?> createUserWithEmailAndPassword(
    String email, // Email provided by the user
    String password, // Password provided by the user
  ) async {
    try {
      // Try to create a user using the provided email and password
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email, // Pass the email
        password: password, // Pass the password
      );

      // If successful, return the created user
      return cred.user;
    } catch (e) {
      // If an error occurs (e.g., user already exists, weak password), log the error
      log(e.toString());  // Logs the error message for debugging
    }
  }

  // Function to log in an existing user using email and password
  Future<User?> loginUserWithEmailAndPassword(
    String email, // Email provided by the user
    String password, // Password provided by the user
  ) async {
    try {
      // Try to sign in with the provided email and password
      final cred = await _auth.signInWithEmailAndPassword(
        email: email, // Pass the email
        password: password, // Pass the password
      );

      // If successful, return the logged-in user
      return cred.user;
    } catch (e) {
      // If an error occurs (e.g., wrong credentials), log the error
      log(e.toString());  // Logs the error message for debugging
    }
  }

  // Function to sign out the currently authenticated user
  Future<void> signout() async {
    try {
      // Try to sign out the current user
      await _auth.signOut();
      log("logged out");
    } catch (e) {
      // If an error occurs during sign-out, log the error
      log(e.toString());  // Logs the error message for debugging
    }
  }
}

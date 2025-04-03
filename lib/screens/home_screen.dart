import 'dart:developer';

import 'package:chargit/screens/login_screen.dart';
import 'package:chargit/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final db = FirebaseFirestore.instance;
  final TextEditingController textController1 = TextEditingController();
  final TextEditingController textController2 = TextEditingController();
  bool _isTextFieldVisible = false; // Track if TextField should be visible
  final TextEditingController _textController = TextEditingController(); // Controller for TextField

final AuthService _auth = AuthService();
  //set up a user object to add to the database
  final user = <String, dynamic>{
    "first": "eljin",
    "middle": "Mathison",
    "last": "Turing",
    "born": 1911
  };
  String dataInspiration = ""; 

  @override
  void initState() {
    super.initState();
    addUserFirestore();
  }

// write database
  Future <void> addUserFirestore() async {
      db.collection("users").add(user).then((DocumentReference doc) =>
      print('DocumentSnapshot added with ID: ${doc.id}'));
  }

  Future <void> getUserInspiration() async{
  //read database
      final docRef = db.collection("sampleData").doc("Inspiration");
        docRef.get().then(
          (DocumentSnapshot doc) {
            final data = doc.data() as Map<String, dynamic>;
            dataInspiration = "Quote: ${data['Quote']} Author: ${data['Author']}";
          },
          onError: (e) => print("Error getting document: $e"),
        );
  }

  Future <void> saveInputDatabase() async {
    String text1 = textController1.text;
    String text2 = textController2.text;
    final customID = "Inspiration";
    //dialog box
    if (text1.isEmpty || text2.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Error"),
          content: Text("Fields cannot be empty!"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        ),
      );
      return; // Stop further execution
    }

    final userInput = <String, dynamic>{
      "Quote": text1,
      "Author": text2,
    };
    //update database
    try {
      db.collection("sampleData").doc(customID).set(userInput).then((_) =>
    print('Poem added with ID: ${customID}'));
    } catch (e) {
      log("Error adding document: $e");
    }
    textController1.clear();
    textController2.clear();
  }

Future <void> deleteDocID() async {
  //delete doc from database
  db.collection("sampleData").doc("Inspiration").delete().then(
        (doc) => print("Document deleted"),
        onError: (e) => print("Error updating document $e"),
      );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: textController1,
              decoration: InputDecoration(labelText: "Insert quote"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: textController2,
              decoration: InputDecoration(labelText: "Insert author"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                saveInputDatabase() ;
              },
              child: Text("Save"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                getUserInspiration();
                setState(() {
                  _isTextFieldVisible = !_isTextFieldVisible; // Toggle visibility
                });
              },
              child: Text("Read"),
            ),
            SizedBox(height: 20),

            // Conditionally show the TextField based on _isTextFieldVisible
            if (_isTextFieldVisible) 
              TextField(
                controller: _textController,
                decoration: InputDecoration(labelText: dataInspiration),
              ),

            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                deleteDocID() ;
              },
              child: Text("Delete"),
            ),
            ElevatedButton(
              onPressed: () async {
                await _auth.signout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}

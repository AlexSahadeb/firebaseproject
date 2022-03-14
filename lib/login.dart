// import 'package:auth/homescreen.dart';
// import 'package:auth/signUp.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/homeScreen.dart';
import 'package:flutter_firebaseapp/signUp.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  signIn() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
      var authCradential = userCredential.user;
      print(authCradential!.uid);
      if (authCradential.uid.isNotEmpty) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return ListTile(
                title: Text("Something is worng"),
              );
            });
        //Fluttertoast.showToast(msg: "Something is worng");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showDialog(
            context: context,
            builder: (context) {
              return ListTile(
                title: Text("No user found for that email."),
              );
            });
        //  Fluttertoast.showToast(msg: "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        showDialog(
            context: context,
            builder: (context) {
              return ListTile(
                title: Text("Wrong password provided for that user."),
              );
            });
        //Fluttertoast.showToast(msg: "Wrong password provided for that user.");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(hintText: "Email"),
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(hintText: "Password"),
            ),
            ElevatedButton(
                onPressed: () {
                  signIn();
                },
                child: Text("Log  In")),
            SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SignUp()));
              },
              child: Text(
                "Register",
                style: TextStyle(fontSize: 26, color: Colors.red),
              ),
            )
          ],
        ),
      ),
    );
  }
}

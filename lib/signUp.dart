// import 'package:auth/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  signUp() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
      var authCradential = userCredential.user;
      print(authCradential!.uid);
      if (authCradential.uid.isNotEmpty) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SignUpCompleted()));
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return ListTile(
                title: Text("Something is worng"),
              );
            });
        //  Fluttertoast.showToast(msg: "Something is worng");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showDialog(
            context: context,
            builder: (context) {
              return ListTile(
                title: Text("The password provided is too weak."),
              );
            });

        // Fluttertoast.showToast(msg: "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        showDialog(
            context: context,
            builder: (context) {
              return ListTile(
                title: Text("The account already exists for that email."),
              );
            });
        // Fluttertoast.showToast(
        //     msg: "The account already exists for that email.");
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
                  signUp();
                },
                child: Text("SignUp")),
            SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: Text(
                "Log In",
                style: TextStyle(fontSize: 26, color: Colors.red),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SignUpCompleted extends StatelessWidget {
  const SignUpCompleted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("SignUp Completed"),
      ),
    );
  }
}

import 'dart:collection';

import 'package:flutter/material.dart';
import '../theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class SignupPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final userNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: Container(
        padding: EdgeInsets.fromLTRB(40.0, 80.0, 40.0, 20.0),
        child: Column(
          children: <Widget>[
            Image.asset(
              "assets/Logo_ET.png",
              width: 192.0,
            ),
            SizedBox(height: 30.0),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Email",
                hintStyle: TextStyle(fontStyle: FontStyle.italic),
                prefixIcon: Icon(Icons.person),
                contentPadding: EdgeInsets.all(14.0),
                border: new OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(24.0),
                  ),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 15.0),
            TextField(
              controller: userNameController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "User Name",
                hintStyle: TextStyle(fontStyle: FontStyle.italic),
                prefixIcon: Icon(Icons.person),
                contentPadding: EdgeInsets.all(14.0),
                border: new OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(24.0),
                  ),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 15.0),
            TextField(
              controller: passController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Pass Word",
                hintStyle: TextStyle(fontStyle: FontStyle.italic),
                prefixIcon: Icon(Icons.lock),
                contentPadding: EdgeInsets.all(14.0),
                border: new OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(24.0),
                  ),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 15.0),
            RaisedButton(
              onPressed: () async {
                FirebaseUser user = await _auth.createUserWithEmailAndPassword(
                    email: emailController.text, password: passController.text);
                if (user != null) {
                  String uid = user.uid;
                  DatabaseReference reference = FirebaseDatabase.instance
                      .reference()
                      .child("Users")
                      .child(uid);
                  Map<String, String> userInfo = new HashMap();
                  userInfo["id"] = uid;
                  userInfo["userName"] = userNameController.text;
                  userInfo["img"] =
                      "https://avatarfiles.alphacoders.com/124/thumb-124140.png";
                  reference.set(userInfo);
                  Navigator.pushReplacementNamed(context, "/");
                }
              },
              padding: EdgeInsets.fromLTRB(40.0, 11.0, 40.0, 11.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.archive,
                    color: Color.fromRGBO(28, 28, 28, .46),
                    size: 24.0,
                  ),
                  Text(
                    "SIGN UP",
                    style: TextStyle(
                        color: Color.fromRGBO(245, 238, 238, 1),
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              color: secondary,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:collection';

class LoginPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: Container(
        padding: EdgeInsets.fromLTRB(40.0, 50.0, 40.0, 20.0),
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
              onPressed: () {
                _auth
                    .signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passController.text)
                    .then((user) {
                  _saveUidCurrentUser(user.uid);
                  Map<String, String> userInfo = new HashMap();
                  userInfo["status"] = "online";
                  _updateCurrentUserInfo(userInfo, user.uid).then((_) {
                    Navigator.pushReplacementNamed(context, '/etapp');
                  });
                });
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
                    "SIGN IN",
                    style: TextStyle(
                        color: Color.fromRGBO(245, 238, 238, 1),
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              color: secondary,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Don't have an account! ",
                        style: TextStyle(
                            color: secondary,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/signup');
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: secondary,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _saveUidCurrentUser(uid) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("uidCurrentUser", uid);
  }

  Future<void> _updateCurrentUserInfo(
      Map<String, String> userInfo, String currentUserUid) {
    return Firestore.instance
        .collection("Users")
        .document(currentUserUid)
        .updateData(userInfo);
  }
}

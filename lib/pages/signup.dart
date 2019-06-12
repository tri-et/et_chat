import 'dart:collection';

import 'package:flutter/material.dart';
import '../theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final userNameController = TextEditingController();
  final FocusNode myFocusNode = new FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: Container(
        padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 25, bottom: 0),
              child: Image.asset('assets/Logo_ET.png'),
            ),
            SizedBox(height: 30.0),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white,
              ),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.grey,
                  ),
                  hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontStyle: FontStyle.italic,
                      fontSize: 17),
                  hintText: "Email",
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                onSubmitted: (String) =>
                    FocusScope.of(context).requestFocus(myFocusNode),
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
                  DocumentReference reference =
                      Firestore.instance.collection("Users").document(uid);
                  Map<String, String> userInfo = new HashMap();
                  userInfo["id"] = uid;
                  userInfo["userName"] = userNameController.text;
                  userInfo["img"] =
                      "https://avatarfiles.alphacoders.com/124/thumb-124140.png";
                  userInfo["status"] = "offline";
                  reference.setData(userInfo);
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
            SizedBox(height: 10.0),
            FlatButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/');
              },
              child: new Text(
                'Click here to Login Page',
                style: TextStyle(
                  fontSize: 14.0,
                  color: secondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

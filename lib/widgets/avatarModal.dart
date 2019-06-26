import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:et_chat/pages/app.dart';
import 'package:et_chat/pages/setting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AvatarModal {
  showImageSelection(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text('View profile picture'),
                  onTap: () => AvatarModal.showProfileImage(context)),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Take a picture'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo),
                title: Text('Select a picture'),
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  static void showProfileImage(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 650,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                ListTile(
                    leading: Icon(Icons.close),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return ETPage();
                          },
                        ),
                      );
                    }),
                SizedBox(
                  height: 80,
                ),
                Image.asset(
                  "assets/avatar.jpg",
                  width: 250,
                  height: 250,
                ),
              ],
            ),
          );
        });
  }
  // static _getCurrentUserInfo() async {
  //   FirebaseUser user = await FirebaseAuth.instance.currentUser();
  //   DocumentSnapshot userInfo =
  //       await Firestore.instance.collection("Users").document(user.uid).get();
  //       return userInfo.data["img"];
  // }
}

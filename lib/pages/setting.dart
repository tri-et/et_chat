import 'dart:collection';
import 'dart:io';

import 'package:et_chat/widgets/avatarModal.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  DocumentSnapshot _userInfo;
  AvatarModal modal = new AvatarModal();
  bool isUploading = false;

  @override
  void initState() {
    super.initState();
    modal.imagePicker().listen((img) {
      _uploadImage(img, _userInfo.documentID);
    });
    _getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    if (_userInfo != null) {
      return Container(
        padding: EdgeInsets.only(top: 10.0),
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          children: <Widget>[
            Center(
              child: GestureDetector(
                onTap: () {
                  return modal.showImageSelection(context, _userInfo);
                },
                child: Stack(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage(_userInfo.data["img"]),
                      maxRadius: 60.0,
                    ),
                    isUploading
                        ? _loading()
                        : Container(width: 0.0, height: 0.0)
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text(_userInfo.data["userName"],
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.keyboard),
              trailing: Icon(Icons.keyboard_arrow_right),
              title: Text('Code QR'),
              onTap: () {
                print('1235656');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.power_settings_new),
              title: Text('Sign Out'),
              onTap: () {
                Map<String, String> userInfo = new HashMap();
                userInfo["status"] = "offline";
                Firestore.instance
                    .collection("Users")
                    .document(_userInfo.documentID)
                    .updateData(userInfo);
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, "/");
              },
            ),
          ],
        ),
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }

  Widget _loading() {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(45.0),
          decoration: new BoxDecoration(
            color: Color.fromRGBO(225, 225, 225, .8),
            borderRadius: BorderRadius.all(Radius.circular(60.0)),
          ),
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
          ),
        ),
      ),
    );
  }

  Future _getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString("currentUid");
    DocumentSnapshot userInfo =
        await Firestore.instance.collection("Users").document(uid).get();
    setState(() {
      _userInfo = userInfo;
    });
  }

  Future _uploadImage(File img, String uid) async {
    StorageReference reference = FirebaseStorage.instance.ref().child(uid);
    StorageUploadTask uploadTask = reference.putFile(img);
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
      print('55555');
    });
  }
}

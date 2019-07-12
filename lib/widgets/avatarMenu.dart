import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'avatarProfile.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class AvatarMenu extends StatefulWidget {
  final DocumentSnapshot userInfo;
  AvatarMenu({this.userInfo});
  @override
  _AvatarMenuState createState() => _AvatarMenuState();
}

class _AvatarMenuState extends State<AvatarMenu> {
  DocumentSnapshot _userInfo;
  File image;
  pickImageFromGallery() async {
    File img = await ImagePicker.pickImage(source: ImageSource.gallery);
    print(img.path);
    if (img != null) {
      image = img;
      setState(() {});
    }
    String fileName = basename(img.path);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
  }

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  Widget showImage() {
    return Stack(
      children: <Widget>[
        Center(
          child: image == null
              ? new Text('')
              : new Image.file(
                  image,
                  width: 240.0,
                  height: 240.0,
                ),
        ),
      
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        showImage(),
        ListTile(
          leading: Icon(Icons.account_circle),
          title: Text('View Profile Picture'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AvatarProfile(_userInfo.data['img'])));
          },
        ),
        ListTile(
          leading: Icon(Icons.camera_alt),
          title: Text('Take a picture'),
          onTap: () async {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.photo),
          title: Text('Select a picture'),
          onTap: () async {
            await pickImageFromGallery();
          },
        )
      ],
    );
  }

  Future _getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString("uidCurrentUser");
    DocumentSnapshot userInfo =
        await Firestore.instance.collection("Users").document(uid).get();
    setState(() {
      _userInfo = userInfo;
    });
  }
}

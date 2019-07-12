import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'avatarProfile.dart';
import 'dart:io';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
class AvatarMenu extends StatelessWidget {
  final DocumentSnapshot userInfo;
  AvatarMenu({this.userInfo,this.image});
  final File image;
  static Future getImageFromCamera() async {
    File img = await ImagePicker.pickImage(source: ImageSource.camera);
    print("Select from ${img.path}");
    return img;
  }

  static Future getImageFromLibary() async {
    File img = await ImagePicker.pickImage(source: ImageSource.gallery);
    print("Select from ${img.path}");
    return img;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.account_circle),
          title: Text('View Profile Picture'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AvatarProfile(userInfo.data['img'])));
          },
        ),
        ListTile(
          leading: Icon(Icons.camera_alt),
          title: Text('Take a picture'),
          onTap: () {
            Navigator.pop(context);
            getImageFromCamera();
          },
        ),
        ListTile(
          leading: Icon(Icons.photo),
          title: Text('Select a picture'),
          onTap: () {
            Navigator.pop(context);
            getImageFromLibary();
          },
        )
      ],
    );
  }
}

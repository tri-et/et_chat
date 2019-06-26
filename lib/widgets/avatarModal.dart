import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'avatarProfile.dart';
import 'package:image_picker/image_picker.dart';

class AvatarModal {
  StreamController<File> imgController;
  Stream<File> imagePicker() {
    imgController = new StreamController<File>();
    return imgController.stream;
  }

  showImageSelection(BuildContext context, DocumentSnapshot userInfo) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
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
                          builder: (context) =>
                              AvatarProfile(userInfo.data['img'])));
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Take a picture'),
                onTap: () {
                  Navigator.pop(context);
                  _getImgFromCamera();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo),
                title: Text('Select a picture'),
                onTap: () {
                  Navigator.pop(context);
                  _getImgFromgallery();
                },
              )
            ],
          );
        });
  }

  Future _getImgFromCamera() async {
    File img = await ImagePicker.pickImage(source: ImageSource.camera);
    imgController.add(img);
  }

  Future _getImgFromgallery() async {
    File img = await ImagePicker.pickImage(source: ImageSource.gallery);
    imgController.add(img);
  }
}

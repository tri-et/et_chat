import 'package:et_chat/theme.dart';
import 'package:flutter/material.dart';

class AvatarModal {
  AvatarModal();
  dynamic showCaptureModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FlatButton(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.account_circle),
                        SizedBox(
                          width: 20,
                        ),
                        Text("View Profile Picture")
                      ],
                    ),
                    onPressed: () => AvatarModal.showProfileImage(context)),
                Divider(
                  height: 25,
                  color: secondary,
                ),
                FlatButton(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.camera_alt),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Select Profile Picture")
                    ],
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          );
        });
  }

  static dynamic showProfileImage(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 500,
            child: FlatButton(
              child: Icon(Icons.close),
              onPressed: (){
                Navigator.pushReplacementNamed(context, "/setting");
              },
            ),
          );
        });
  }
}

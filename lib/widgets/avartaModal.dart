import 'package:flutter/material.dart';

class AvatarModal {
  showCaptureModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    height: 50.0,
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.account_box, color: Colors.black38),
                        Container(
                          margin: const EdgeInsets.only(left: 30.0),
                          child: Text("View Profile Picture"),
                        )
                      ],
                    ),
                  ),
                  onTap: (){
                    print("Show Image");
                  },
                ),
                Container(
                  height: 50.0,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.camera_alt, color: Colors.black38),
                      Container(
                        margin: const EdgeInsets.only(left: 30.0),
                        child: Text("Select Profile Picture"),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}

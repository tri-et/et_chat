import 'package:flutter/material.dart';
// import './drawCircle.dart';

class Avatar extends StatelessWidget {
  final String imgUrl;
  final String status;
  Avatar(this.imgUrl, [this.status]);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CircleAvatar(
          backgroundImage: imgUrl == ""
              ? ExactAssetImage("assets/avatar.jpg")
              : NetworkImage(imgUrl),
          minRadius: 30,
          maxRadius: 30,
        ),
        Positioned(
          top: 40.0,
          right: 1.0,
          child: Icon(
            Icons.fiber_manual_record,
            color: this.status == "offline" ? Colors.grey : Colors.green,
          ),
        ),
      ],
    );
  }
}

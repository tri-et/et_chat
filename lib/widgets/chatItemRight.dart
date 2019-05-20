import 'package:flutter/material.dart';

class ChatItemRight extends StatelessWidget {
  final dynamic message;
  final String img;
  ChatItemRight(this.message, this.img);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8.0),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * .6,
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(189, 225, 135, 130),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(0.0),
                bottomLeft: Radius.circular(12.0),
                bottomRight: Radius.circular(12.0),
              ),
            ),
            child: Text(
              message["message"],
              style: TextStyle(
                fontSize: 14.0,
                color: Color.fromARGB(198, 77, 66, 66),
              ),
            ),
          ),
          SizedBox(width: 10.0),
          CircleAvatar(
            backgroundImage: img == ""
                ? ExactAssetImage("assets/avatar.jpg")
                : NetworkImage(img),
            minRadius: 25,
            maxRadius: 25,
          ),
        ],
      ),
    );
  }
}

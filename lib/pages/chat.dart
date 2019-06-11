import 'package:et_chat/theme.dart';
import 'package:et_chat/widgets/avatar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../widgets/chatItemLeft.dart';
import '../widgets/chatItemRight.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Chat extends StatefulWidget {
  final String uid;
  Chat(this.uid);
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  String img = "";
  String imgCurrentUser = "";
  String userName = "";
  String uidFriend = "";
  String uidUser = "";
  String uidChat = "";
  FirebaseAuth auth;
  final msgController = TextEditingController();
  CollectionReference referenceChat = Firestore.instance.collection("Chats");
  CollectionReference referenceHis = Firestore.instance.collection("Histories");
  Widget _buildListItem(BuildContext context, dynamic message) {
    return this.uidUser == message["sender"]
        ? ChatItemRight(message, imgCurrentUser)
        : ChatItemLeft(message, img);
  }

  @override
  void initState() {
    super.initState();
    _getCurrentUserInfo();
    Firestore.instance
        .collection("Users")
        .document(widget.uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      setState(() {
        img = snapshot.data["img"];
        userName = snapshot.data["userName"];
      });
    });
  }

  void _getCurrentUserInfo() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot userInfo =
        await Firestore.instance.collection("Users").document(user.uid).get();
    setState(() {
      imgCurrentUser = userInfo.data["img"];
      this.uidUser = user.uid;
      uidChat = _generateChannel(user.uid, widget.uid);
    });
  }

  void sendMsg() {
    Map<String, String> obMsg = new Map<String, String>();
    obMsg["sender"] = uidUser;
    obMsg["receiver"] = uidFriend;
    obMsg["message"] = msgController.text;
    obMsg["timestamp"] = new DateTime.now().millisecondsSinceEpoch.toString();
    referenceChat
        .document(this.uidChat)
        .collection("Messages")
        .document()
        .setData(obMsg)
        .then((onValue) {
      obMsg["name"] = userName;
      obMsg["img"] = img;
      referenceHis
          .document(uidUser)
          .collection("Histories")
          .document(uidUser)
          .setData(obMsg);
      this.msgController.clear();
    });
  }

  _generateChannel(currentUid, friendUid) {
    String channelGenerate = "";
    if (friendUid.compareTo(currentUid) == 1) {
      channelGenerate = friendUid + currentUid;
    } else {
      channelGenerate = currentUid + friendUid;
    }
    return channelGenerate;
  }

  @override
  Widget build(BuildContext context) {
    if (uidChat == "") {
      return Scaffold(
        body: Center(
          child: Text("Connecting..."),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Color(0XFFFFFFFF),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              width: double.infinity,
              color: Colors.white,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Positioned(
                    left: 15.0,
                    top: 0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.keyboard_arrow_left,
                        size: 35.0,
                        color: Color.fromARGB(225, 120, 107, 107),
                      ),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Avatar(img),
                      SizedBox(height: 10.0),
                      Text(
                        userName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Color(0XFFF1DBDB),
                child: StreamBuilder(
                  stream: Firestore.instance
                      .collection("Chats")
                      .document(this.uidChat)
                      .collection("Messages")
                      .orderBy("timestamp", descending: true)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        reverse: true,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (BuildContext context, int index) =>
                            _buildListItem(
                                context, snapshot.data.documents[index]),
                      );
                    } else {
                      return Center(
                          child: Text(
                        'Loading...',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ));
                    }
                  },
                ),
              ),
            ),
            Container(
              height: 50.0,
              padding: EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10.0,
                    color: Colors.black26,
                    offset: Offset(0.0, -5.0),
                  )
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Flexible(
                    child: TextField(
                      controller: msgController,
                      decoration: InputDecoration(
                        hintText: "Type a message",
                        hintStyle: TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                        border: new OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.all(0.0),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.send,
                      color: secondary,
                    ),
                    onPressed: sendMsg,
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }
  }
}

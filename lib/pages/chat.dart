import 'package:et_chat/theme.dart';
import 'package:et_chat/widgets/avatar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/chatItemLeft.dart';
import '../widgets/chatItemRight.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  FirebaseAuth auth;
  DatabaseReference reference = FirebaseDatabase.instance.reference();

  final msgController = TextEditingController();
  Widget _buildListItem(BuildContext context, dynamic message) {
    return this.uidUser == message["sender"]
        ? ChatItemRight(message, imgCurrentUser)
        : ChatItemLeft(message, img);
  }

  _readCurrentUid() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString("currentUid");
    setState(() {
      this.uidUser = value;
      _getCurrentUserInfo(value);
    });
  }

  _getCurrentUserInfo(uid) {
    reference.child("Users").child(uid).once().then((DataSnapshot snapshot) {
      setState(() {
        imgCurrentUser = snapshot.value["img"];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _readCurrentUid();
    setState(() {
      uidFriend = widget.uid;
    });
    reference
        .child("Users")
        .child(widget.uid)
        .once()
        .then((DataSnapshot snapshot) {
      setState(() {
        img = snapshot.value["img"];
        userName = snapshot.value["userName"];
      });
    });
  }

  void sendMsg() {
    Map<String, String> obMsg = new Map<String, String>();
    obMsg["sender"] = uidUser;
    obMsg["receiver"] = widget.uid;
    obMsg["message"] = msgController.text;
    obMsg["timestamp"] = new DateTime.now().millisecondsSinceEpoch.toString();
    reference
        .child("Chats")
        .child(this.generateChannel())
        .push()
        .set(obMsg)
        .then((onValue) {
      this.msgController.clear();
    });
  }

  generateChannel() {
    String uidChat = "";
    if (uidFriend.compareTo(uidUser) == 1) {
      uidChat = uidFriend + uidUser;
    } else {
      uidChat = uidUser + uidFriend;
    }
    return uidChat;
  }

  @override
  Widget build(BuildContext context) {
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
                stream: FirebaseDatabase.instance
                    .reference()
                    .child("Chats")
                    .child(this.generateChannel())
                    .onValue,
                builder: (BuildContext context, AsyncSnapshot<Event> snapshot) {
                  if (snapshot.hasData &&
                      snapshot.data.snapshot.value != null) {
                    Map map = snapshot.data.snapshot.value;
                    List dataSorted = map.values.toList();
                    dataSorted.sort((a, b) {
                      return b["timestamp"].compareTo(a["timestamp"]);
                    });
                    return ListView.builder(
                      reverse: true,
                      itemCount: map.values.toList().length,
                      itemBuilder: (BuildContext context, int index) =>
                          _buildListItem(context, dataSorted[index]),
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

class Item {
  String message;
  String receiver;
  String sender;
  String timestamp;
}

import 'package:et_chat/widgets/chatHistoryItem.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:et_chat/theme.dart';

class ChatHistoryPage extends StatefulWidget {
  @override
  _ChatHistoryPageState createState() => _ChatHistoryPageState();
}

class _ChatHistoryPageState extends State<ChatHistoryPage> {
  FirebaseUser currentUser;
  TextEditingController _filter = TextEditingController();
  String txtSearchUser = "";
  @override
  void initState() {
    _filter.addListener(() {
      setState(() {
        txtSearchUser = _filter.text;
      });
    });
    super.initState();
    _getCurrentUser();
  }

  @override
  void dispose() {
    _filter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (currentUser != null)
      return Scaffold(
        appBar: AppBar(
          backgroundColor: secondary,
          elevation: 0.0,
          title: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(00.0, 8.0, 00.0, 8.0),
                  child: TextField(
                    controller: _filter,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromRGBO(255, 255, 255, .45),
                      hintText: "Type a text",
                      contentPadding: EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                      hintStyle: TextStyle(fontStyle: FontStyle.italic),
                      suffixIcon: _iconSearch(),
                      border: new OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(24.0),
                        ),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: StreamBuilder(
          stream: Firestore.instance
              .collection("Histories")
              .document(currentUser.uid)
              .collection("Histories")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (txtSearchUser == "") {
                      return _buildListItem(
                          context, snapshot.data.documents[index]);
                    } else {
                      if (snapshot.data.documents[index].data["userName"]
                          .contains(txtSearchUser.toLowerCase())) {
                        return _buildListItem(
                            context, snapshot.data.documents[index]);
                      } else {
                        return Container();
                      }
                    }
                  });
            } else {
              return Center(
                  child: Text(
                'Loading...',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ));
            }
          },
        ),
      );
    return Center(
      child: Text("Connecting..."),
    );
  }

  _getCurrentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    setState(() {
      currentUser = user;
    });
  }

  Widget _iconSearch() {
    return IconButton(
      icon: Icon(txtSearchUser == "" ? Icons.search : Icons.close),
      onPressed: () {
        setState(() {
          txtSearchUser = "";
        });
        _filter.clear();
      },
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot user) {
    return ChatHistoryItem(user);
  }
}

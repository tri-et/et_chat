import 'package:et_chat/widgets/chatHistoryItem.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../theme.dart';

class ChatHistoryPage extends StatefulWidget {
  @override
  _ChatHistoryPageState createState() => _ChatHistoryPageState();
}

class _ChatHistoryPageState extends State<ChatHistoryPage> {
  FirebaseUser currentUser;
  TextEditingController searchController = TextEditingController();
  String txtSearchHistory = "";
  @override
  void initState() {
    searchController.addListener(() {
      setState(() {
        txtSearchHistory = searchController.text;
      });
    });
    super.initState();
    _getCurrentUser();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (currentUser != null)
      return Scaffold(
        appBar: AppBar(
          backgroundColor: secondary,
          elevation: 0.0,
          title: Container(
            margin: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
            child: TextField(
              enableInteractiveSelection: false,
              controller: searchController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromRGBO(255, 255, 255, .45),
                hintText: "Type a text",
                contentPadding: EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                hintStyle: TextStyle(fontStyle: FontStyle.italic),
                suffixIcon: IconButton(
                  icon:
                      Icon(txtSearchHistory == "" ? Icons.search : Icons.close),
                  onPressed: () {
                    setState(() {
                      txtSearchHistory = "";
                    });
                    searchController.clear();
                  },
                ),
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
                  if (txtSearchHistory == "") {
                    return _buildListItem(
                        context, snapshot.data.documents[index]);
                  } else {
                    if (snapshot.data.documents[index].data["name"]
                        .contains(txtSearchHistory)) {
                      return _buildListItem(
                          context, snapshot.data.documents[index]);
                    } else {
                      return Container();
                    }
                  }
                },
              );
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

  Widget _buildListItem(BuildContext context, DocumentSnapshot user) {
    return ChatHistoryItem(user);
  }
}

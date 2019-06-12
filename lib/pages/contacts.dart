import 'package:flutter/material.dart';
import '../widgets/contactItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:et_chat/theme.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  FirebaseUser currentUser;
  TextEditingController _filter = TextEditingController();
  String searchUser ="";
  @override
  void initState() {
    _filter.addListener(() {
      setState(() {
        searchUser = _filter.text;
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
    if (currentUser != null) {
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
          stream: Firestore.instance.collection("Users").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index) {
                    if (searchUser == "") {
                      return _buildListItem(
                          context, snapshot.data.documents[index]);
                    } else {
                      if (snapshot.data.documents[index].data["userName"]
                          .contains(searchUser.toLowerCase())) {
                        return _buildListItem(
                            context, snapshot.data.documents[index]);
                      } else {
                        return Container();
                      }
                    }
                  }
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      );
    } else {
      return CircularProgressIndicator();
    }
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot user) {
    return ContactItem(user);
  }

  Widget _iconSearch() {
    return IconButton(
      icon: Icon(searchUser == "" ? Icons.search : Icons.close),
      onPressed: () {
        setState(() {
          searchUser = "";
        });
        _filter.clear();
      },
    );
  }

  _getCurrentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    setState(() {
      currentUser = user;
    });
  }
}

class SearchService {
  searchByName(String searchField) {
    return Firestore.instance
        .collection("Users")
        .where("userName", isEqualTo: searchField.substring(0, 1).toUpperCase())
        .getDocuments();
  }
}

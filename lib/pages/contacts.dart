import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/contactItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  FirebaseUser currentUser;
  final searchController = TextEditingController();
  String txtSearchContact = "";
  @override
  void initState() {
    searchController.addListener(() {
      setState(() {
        txtSearchContact = searchController.text;
      });
    });
    super.initState();
    _getCurrentUser();
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
                          icon: Icon(txtSearchContact == ""
                              ? Icons.search
                              : Icons.close),
                          onPressed: () {
                            setState(() {
                              txtSearchContact = "";
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
                IconButton(
                  icon: Icon(Icons.person_add),
                  iconSize: 32.0,
                  onPressed: () {},
                )
              ],
            )),
        body: StreamBuilder(
          stream: Firestore.instance.collection("Users").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (txtSearchContact == "") {
                      return _buildListItem(
                          context, snapshot.data.documents[index]);
                    } else {
                      if (snapshot.data.documents[index].data["userName"]
                          .contains(txtSearchContact)) {
                        return _buildListItem(
                            context, snapshot.data.documents[index]);
                      } else {
                        return Container();
                      }
                    }
                  });
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

  _getCurrentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    setState(() {
      currentUser = user;
    });
  }
}

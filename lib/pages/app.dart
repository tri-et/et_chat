import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'contacts.dart';
import 'chatHistory.dart';
import 'setting.dart';
import '../theme.dart';

class ETPage extends StatefulWidget {
  @override
  _ETPageState createState() => _ETPageState();
}

class _ETPageState extends State<ETPage> {
  int _selectedPage = 0;
  bool isShowAppBar = true;
  final _pageOptions = [
    ContactsPage(),
    ChatHistoryPage(),
    SettingPage(),
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isShowAppBar
          ? AppBar(
              backgroundColor: secondary,
              elevation: 0.0,
              title: Container(
                margin: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromRGBO(255, 255, 255, .45),
                    hintText: "Type a text",
                    contentPadding: EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                    hintStyle: TextStyle(fontStyle: FontStyle.italic),
                    suffixIcon: Icon(Icons.search),
                    border: new OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(24.0),
                      ),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            )
          : null,
      body: _pageOptions[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: secondary,
        currentIndex: _selectedPage,
        fixedColor: Colors.white,
        iconSize: 35,
        onTap: (int index) {
          setState(() {
            _selectedPage = index;
            if (index == 2)
              isShowAppBar = false;
            else
              isShowAppBar = true;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

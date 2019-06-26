import 'package:et_chat/pages/profile.dart';
import 'package:flutter/material.dart';
import './pages/login.dart';
import './pages/app.dart';
import './pages/signup.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        accentColor: Colors.deepPurple,
      ),
      routes: {
        '/': (BuildContext context) => LoginPage(),
        '/etapp': (BuildContext context) => ETPage(),
        '/signup': (BuildContext context) => SignupPage(),
        '/profile': (BuildContext context) => Profile(),
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (BuildContext context) => Scaffold(
            appBar: AppBar(
              title: Text('Unknow'),
            ),
            body: Center(
              child: Text('Unknow'),
            ),
          ),
        );
      },
    );
  }
}

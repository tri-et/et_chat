import 'package:flutter/material.dart';
import './pages/login.dart';
import './pages/app.dart';
import './pages/signup.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        accentColor: Colors.deepPurple,
        // fontFamily: "RobotoMono",
      ),
      // home: AuthPage(),
      routes: {
        '/': (BuildContext context) => LoginPage(),
        '/etapp': (BuildContext context) => ETPage(),
        '/signup': (BuildContext context) => SignupPage(),
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

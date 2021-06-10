import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/pages/user/login.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/pages/user/profile.dart';
import 'package:frontend/pages/user/registration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;

Future main() async {
  await dotenv.load(fileName: '.env.development');
  await firebase_core.Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => MyHomePage(title: 'Chat App'),
        '/login': (context) => LoginPage(),
        '/registration': (context) => RegistrationPage(),
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<String?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('user');

    return user;
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      body: FutureBuilder(
          future: getUser(),
          builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
            if (snapshot.hasData) {
              return ProfilePage();
            } else {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 150, vertical: 200),
                child: Center(
                  child: Column(
                    children: [
                      FloatingActionButton.extended(
                        heroTag: 'loginbtn',
                        onPressed: () {
                          Navigator.pushNamed(context, LoginPage.routeName);
                        },
                        label: Text('Login'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FloatingActionButton.extended(
                        heroTag: 'regbtn',
                        onPressed: () {
                          Navigator.pushNamed(
                              context, RegistrationPage.routeName);
                        },
                        label: Text('Register'),
                      )
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }
}

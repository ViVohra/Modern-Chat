// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gossip/Services/Authentication.dart';
import 'package:gossip/Views/Home.dart';
import 'package:gossip/Views/SignIn.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Gossip Application',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FutureBuilder(
        future: AuthMethods().getCurrentUser(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return Home();
          } else {
            return SignIn();
          }
        },
      ),
    );
  }
}

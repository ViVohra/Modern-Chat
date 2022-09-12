// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gossip/Services/Authentication.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('The Gossip Application'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            AuthMethods().signInWithGoogle(context);
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24), color: Colors.red),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Sign In With Google',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

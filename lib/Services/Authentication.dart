// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gossip/Helper/SharedPreference_Helper.dart';
import 'package:gossip/Services/Database.dart';
import 'package:gossip/Views/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;

  getCurrentUser() async {
    return await auth.currentUser;
  }

  signInWithGoogle(BuildContext context) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    UserCredential result = await firebaseAuth.signInWithCredential(credential);
    User userDetail = result.user;

    SharedPreferenceHelper().saveUserEmail(userDetail.email.toString());
    SharedPreferenceHelper().saveUserId(userDetail.uid);
    SharedPreferenceHelper()
        .saveUserName(userDetail.email.replaceAll("@gmail.com", ""));
    SharedPreferenceHelper().saveUserProfileUrl(userDetail.photoURL.toString());

    Map<String, dynamic> userInfomap = {
      "email": userDetail.email,
      "name": userDetail.displayName,
      "username": userDetail.email.replaceAll("@gmail.com", ""),
      "imgurl": userDetail.photoURL
    };
    DatabaseMethods()
        .addUserInfoToDB(userDetail.uid, userInfomap)
        .then((value) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    });
  }

  Future signOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    auth.signOut();
  }
}
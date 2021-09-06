import 'package:bag_of_words/page/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Application {
  static Application? _instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  static Application getInstance() => _instance ?? Application();

  bool isAuthenticated() => _auth.currentUser != null;

  User? getFirebaseUser() => _auth.currentUser;

  signIn() async {
    GoogleSignInAccount? googleAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication gSignInAuth =
        await googleAccount!.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: gSignInAuth.accessToken,
      idToken: gSignInAuth.idToken,
    );
    await _auth.signInWithCredential(credential);
  }

  signOut(context) async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
      (e) => false,
    );
  }
}

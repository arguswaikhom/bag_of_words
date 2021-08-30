import 'package:bag_of_words/controller/Application.dart';
import 'package:bag_of_words/page/Homepage.dart';
import 'package:bag_of_words/page/LoginPage.dart';
import 'package:bag_of_words/res/AppColor.dart';
import 'package:bag_of_words/res/AppString.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppString.appName,
      theme: ThemeData(
        primaryColor: AppColor.darkBg,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        backgroundColor: AppColor.dark,
      ),
      home: _getInitialPage(),
    );
  }

  Widget _getInitialPage() {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(child: CircularProgressIndicator());
        }

        final isAuthenticated = Application.getInstance().isAuthenticated();
        if (isAuthenticated) return HomePage();
        return LoginPage();
      },
    );
  }
}

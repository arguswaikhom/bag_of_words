import 'package:bag_of_words/controller/Application.dart';
import 'package:bag_of_words/page/Homepage.dart';
import 'package:bag_of_words/res/AppAsset.dart';
import 'package:bag_of_words/res/AppColor.dart';
import 'package:bag_of_words/res/AppString.dart';
import 'package:bag_of_words/widget/CircleWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: AppColor.darkBg,
        body: _getBodyWidget(),
      ),
    );
  }

  _getBodyWidget() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 64, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // _getBubbles(),
          ClipRRect(
            borderRadius: BorderRadius.circular(64),
            child: Image.asset(AppAsset.icon),
          ),
          SizedBox(height: 36),
          Text(
            AppString.appName,
            style: TextStyle(
              fontSize: 22,
              color: AppColor.dark5,
            ),
          ),
          Expanded(child: Container()),
          InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            child: Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColor.light4,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.login_rounded,
                    color: AppColor.dark7,
                    size: 28,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    AppString.signInWithGoogle,
                    style: TextStyle(color: AppColor.dark7, fontSize: 18),
                  ),
                ],
              ),
            ),
            onTap: () async {
              await Application.getInstance().signIn();
              if (await Application.getInstance().isAuthenticated()) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                  (e) => false,
                );
              }
            },
          )
        ],
      ),
    );
  }

  _getBubbles() {
    return Container(
      width: 250,
      height: 250,
      child: Stack(
        children: [
          CircleWidget(color: AppColor.dark2, diameter: 150),
          CircleWidget(color: AppColor.dark3, diameter: 50),
          Positioned(
            right: 0,
            child: CircleWidget(color: AppColor.dark3, diameter: 50),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CircleWidget(color: AppColor.dark3, diameter: 50),
          ),
          Align(
            alignment: Alignment.center,
            child: CircleWidget(color: AppColor.dark3, diameter: 100),
          ),
          Align(
            alignment: Alignment.center,
            child: CircleWidget(color: AppColor.dark4, diameter: 50),
          )
        ],
      ),
    );
  }
}

import 'package:bag_of_words/controller/Application.dart';
import 'package:bag_of_words/res/app_color.dart';
import 'package:flutter/material.dart';

class HomePageActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            tileColor: Colors.transparent,
            title: Text(
              "Sign out",
              style: TextStyle(color: AppColor.light),
            ),
            leading: Icon(
              Icons.logout,
              color: AppColor.light,
            ),
            onTap: () async {
              await Application.getInstance().signOut(context);
            },
          ),
        ],
      ),
    );
  }
}

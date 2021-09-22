import 'package:bag_of_words/data/repos/auth/auth_repo.dart';
import 'package:bag_of_words/res/app_color.dart';
import 'package:flutter/material.dart';

class HomePageActions extends StatelessWidget {
  final AuthRepo authRepo;

  HomePageActions(this.authRepo);

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
            onTap: () async => await authRepo.logOut(),
          ),
        ],
      ),
    );
  }
}

import 'package:bag_of_words/bloc/auth/auth_bloc.dart';
import 'package:bag_of_words/bloc/auth/auth_state.dart';
import 'package:bag_of_words/data/repos/auth_repo.dart';
import 'package:bag_of_words/res/app_color.dart';
import 'package:bag_of_words/res/app_string.dart';
import 'package:bag_of_words/res/app_style.dart';
import 'package:bag_of_words/views/pages/home_page.dart';
import 'package:bag_of_words/views/widgets/app_circle_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();

  static Route route() => MaterialPageRoute<void>(builder: (_) => LoginPage());
}

class _LoginScreenState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    BlocListener<AuthBloc, AuthState>(
      listener: (context, authState) {
        if (authState.status == AuthStatus.AUTHENTICATED) {
          Navigator.of(context).pushAndRemoveUntil(
            HomePage.route(),
            (route) => false,
          );
        }
      },
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  AppCircleLogo(radius: 120),
                  SizedBox(height: 32.0),
                  Text(AppString.appName, style: AppStyle.tsAppName),
                ],
              ),
              SignInButton(
                Buttons.GoogleDark,
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                onPressed: () async {
                  try {
                    await context.read<AuthRepo>().logIn();
                  } catch (_) {
                    Fluttertoast.showToast(
                      msg: AppString.failedToSignIn,
                      textColor: AppColor.dark,
                      backgroundColor: AppColor.light,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

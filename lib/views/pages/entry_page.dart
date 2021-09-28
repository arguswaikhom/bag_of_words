import 'package:bag_of_words/bloc/auth/auth_bloc.dart';
import 'package:bag_of_words/bloc/auth/auth_state.dart';
import 'package:bag_of_words/res/app_color.dart';
import 'package:bag_of_words/res/app_string.dart';
import 'package:bag_of_words/utils/extensions/navigator_state_x.dart';
import 'package:bag_of_words/views/pages/home_page.dart';
import 'package:bag_of_words/views/pages/login_page.dart';
import 'package:bag_of_words/views/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EntryPage extends StatefulWidget {
  EntryPage({Key? key}) : super(key: key);

  @override
  _EntryPageState createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: AppString.appName,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: AppColor.darkBg,
        ),
      ),
      builder: (context, child) {
        return BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthStatus.AUTHENTICATED:
                _navigator.pushAndRemoveAll(HomePage.route());
                break;
              case AuthStatus.UNAUTHENTICATED:
                _navigator.pushAndRemoveAll(LoginPage.route());
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}

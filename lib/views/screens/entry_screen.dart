import 'package:bag_of_words/bloc/auth/auth_bloc.dart';
import 'package:bag_of_words/bloc/auth/auth_state.dart';
import 'package:bag_of_words/res/app_color.dart';
import 'package:bag_of_words/res/app_string.dart';
import 'package:bag_of_words/utils/extensions/navigator_state_x.dart';
import 'package:bag_of_words/views/screens/home_screen.dart';
import 'package:bag_of_words/views/screens/login_screen.dart';
import 'package:bag_of_words/views/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EntryScreen extends StatefulWidget {
  EntryScreen({Key? key}) : super(key: key);

  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: AppString.appName,
      theme: ThemeData(
        primaryColor: AppColor.darkBg,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        backgroundColor: AppColor.dark,
      ),
      builder: (context, child) {
        return BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthStatus.AUTHENTICATED:
                _navigator.pushAndRemoveAll(HomeScreen.route());
                break;
              case AuthStatus.UNAUTHENTICATED:
                _navigator.pushAndRemoveAll(LoginScreen.route());
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashScreen.route(),
    );
  }
}

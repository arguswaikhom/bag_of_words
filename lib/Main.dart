import 'package:bag_of_words/app.dart';
import 'package:bag_of_words/bloc/app_bloc_observer.dart';
import 'package:bag_of_words/data/repos/auth/auth_repo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App(authRepo: AuthRepo()));
}

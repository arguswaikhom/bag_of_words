import 'package:bag_of_words/bloc/auth/auth_bloc.dart';
import 'package:bag_of_words/data/repos/auth_repo.dart';
import 'package:bag_of_words/views/pages/entry_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  final AuthRepo authRepo;

  const App({Key? key, required this.authRepo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );

    return RepositoryProvider.value(
      value: authRepo,
      child: BlocProvider(
        create: (_) => AuthBloc(authRepo: authRepo),
        child: EntryPage(),
      ),
    );
  }
}

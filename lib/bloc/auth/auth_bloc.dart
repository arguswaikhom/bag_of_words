import 'dart:async';

import 'package:bag_of_words/bloc/auth/auth_event.dart';
import 'package:bag_of_words/bloc/auth/auth_state.dart';
import 'package:bag_of_words/data/repos/auth/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo _authRepo;
  late StreamSubscription<AuthStatus> _authStatusSub;

  AuthBloc({
    required AuthRepo authRepo,
  })  : _authRepo = authRepo,
        super(AuthState.unknown()) {
    _authStatusSub = authRepo.status.listen(
      (status) => add(AuthEventStatusChanged(status)),
    );
  }

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthEventStatusChanged) {
      switch (event.status) {
        case AuthStatus.AUTHENTICATED:
          yield AuthState.authenticated(_authRepo.getAuthenticatedUser());
          break;
        case AuthStatus.UNAUTHENTICATED:
          yield AuthState.unauthenticated();
          break;
        default:
          yield AuthState.unknown();
      }
    } else if (event is AuthEventLogout) {
      await _authRepo.logOut();
      yield AuthState.unauthenticated();
    } else if (event is AuthEventLogin) {
      try {
        await _authRepo.logIn();
      } on Exception {
        rethrow;
      }
      yield AuthState.authenticated(_authRepo.getAuthenticatedUser());
    }
  }

  @override
  Future<void> close() {
    _authStatusSub.cancel();
    _authRepo.dispose();
    return super.close();
  }
}

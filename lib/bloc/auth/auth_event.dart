import 'package:bag_of_words/bloc/auth/auth_state.dart';
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthEventStatusChanged extends AuthEvent {
  final AuthStatus status;

  AuthEventStatusChanged(this.status);
}

class AuthEventLogout extends AuthEvent {}

class AuthEventLogin extends AuthEvent {}

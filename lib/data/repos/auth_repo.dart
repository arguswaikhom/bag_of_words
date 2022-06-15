import 'dart:async';

import 'package:bag_of_words/bloc/auth/auth_state.dart';
import 'package:bag_of_words/utils/exceptions/authentication_failed_exception.dart';
import 'package:bag_of_words/utils/exceptions/unauthenticated_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final StreamController<AuthStatus> _controller =
      StreamController<AuthStatus>();

  Stream<AuthStatus> get status async* {
    try {
      getAuthenticatedUser();
      yield AuthStatus.AUTHENTICATED;
    } on Exception {
      yield AuthStatus.UNAUTHENTICATED;
    } finally {
      yield* _controller.stream;
    }
  }

  User getAuthenticatedUser() {
    final User? user = _auth.currentUser;
    if (user != null && user.uid.isNotEmpty) return user;
    throw UnauthenticatedException();
  }

  Future<void> logIn() async {
    try {
      GoogleSignInAccount? aAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication? gAuth = await aAccount?.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: gAuth?.accessToken,
        idToken: gAuth?.idToken,
      );
      await _auth.signInWithCredential(credential);

      /// Just to make sure that getting user doesn't throw any exception
      getAuthenticatedUser();
    } on Exception catch (e) {
      print(e);
      _controller.add(AuthStatus.UNAUTHENTICATED);
      throw AuthenticationFailedException();
    }
    _controller.add(AuthStatus.AUTHENTICATED);
  }

  Future<void> logOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    _controller.add(AuthStatus.UNAUTHENTICATED);
  }

  void dispose() => _controller.close();
}

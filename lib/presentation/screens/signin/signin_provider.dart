import 'package:contribute/core/utils/notifier_state.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SigninProvider extends ChangeNotifier {
  NotifierState _notifierState = NotifierState.initial;
  NotifierState get notifierState => _notifierState;

  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    try {
      _setState(NotifierState.loading);
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        return;
      }

      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
    } on Exception catch (e) {
      debugPrint(e.toString());
    }

    // notifyListeners();
  }

  Future logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
    _setState(NotifierState.loaded);
    // notifyListeners();
  }

  void _setState(NotifierState notifierState) {
    _notifierState = notifierState;
    notifyListeners();
  }
}

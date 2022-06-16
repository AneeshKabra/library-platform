import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart' as google;
import 'package:firebase_auth/firebase_auth.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final _googleSignIn = google.GoogleSignIn(scopes: ['email']);

  googlelogin() async {
    try {
      final user = await _googleSignIn.signIn();
      final googleAuth = await user!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final result =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return result.user!.email;
    } catch (e) {
      print(e);
    }
  }
}


import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'Google_home.dart';

class Google extends StatefulWidget {
  @override
  State<Google> createState() => _GoogleState();
}

class _GoogleState extends State<Google> {
  User? user;

  Future<User?> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final FirebaseAuth auth = FirebaseAuth.instance;

    final GoogleSignInAccount? googleSignInAccount =
    await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
        await auth.signInWithCredential(credential);

        UserCredential result = await auth.signInWithCredential(credential);
        User? user = result.user;
        user = userCredential.user;
        if (result != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => google_home(user!.displayName.toString(),
                    user.email.toString(), user.photoURL.toString()),
              ));
        } else {}
        log("Google SignIn ~~>> ${user.toString()}");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          log(e.code);
        } else if (e.code == 'invalid-credential') {
          log(e.code);
        }
      } catch (e) {
        log(e.toString());
      }
    } else {
      log("Google SignIn 123~~>> ${user.toString()}");
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () {
                signInWithGoogle();
              },
              child: const Icon(Icons.supervised_user_circle, size: 40),
            ),
          ],
        ),
      ),
    );
  }
}

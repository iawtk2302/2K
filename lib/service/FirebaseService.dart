import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../router/routes.dart';

class FirebaseService {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  signInWithGoole() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);
        await _auth.signInWithCredential(authCredential);
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

  signInWithFB() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      await _auth.signInWithCredential(facebookAuthCredential);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

  signInWithEmailPassword(String emailAddress, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  createAccount(String email, String password, BuildContext context) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FirebaseAuth.instance.currentUser?.sendEmailVerification();
      Navigator.pushReplacementNamed(context, Routes.login);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        const snackBar = SnackBar(
          content: Text('The password provided is too weak.'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        const snackBar = SnackBar(
          content: Text('The account already exists for that email.'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      print(e);
    }
  }
  resetPass(String email,BuildContext context)async{
    await FirebaseAuth.instance
    .sendPasswordResetEmail(email: email);
    const snackBar = SnackBar(
          backgroundColor: Colors.green,
          content: Text('Please check your email.'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}

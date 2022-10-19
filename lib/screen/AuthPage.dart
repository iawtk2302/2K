import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sneaker_app/screen/FillProfilePage.dart';
import 'package:sneaker_app/screen/HomePage.dart';
import 'package:sneaker_app/screen/LoginPage.dart';
import 'package:sneaker_app/screen/MainPage.dart';
import 'package:sneaker_app/screen/OnBoardingPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }
          else if(snapshot.hasData&&snapshot.data!.emailVerified){
            return const MainPage();
          }
          else if(snapshot.hasData){
            return const LoginPage();
          }
          else {
            return const OnBoardingPage();
          }
      },),
    );
  }
}
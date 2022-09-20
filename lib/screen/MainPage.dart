import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sneaker_app/screen/HomePage.dart';
import 'package:sneaker_app/screen/LoginPage.dart';
import 'package:sneaker_app/screen/OnBoardingPage.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

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
            return const HomePage();
          }
          else if(snapshot.hasData){
            return const LoginPage();
          }
          else{
            return const OnBoardingPage();
          }
      },),
    );
  }
}
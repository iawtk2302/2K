import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:sneaker_app/screen/AuthPage.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: "assets/images/Logo_Light.png",
      nextScreen: const AuthPage(),
      splashIconSize: 350,
    );
  }
}

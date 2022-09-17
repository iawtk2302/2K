import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sneaker_app/router/routes.dart';
import 'package:sneaker_app/screen/HomePage.dart';
import 'package:sneaker_app/screen/LoginPage.dart';
import 'package:sneaker_app/screen/SplashScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '2K',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Urbanist"
      ),
      home: const SplashScreen(),
      onGenerateRoute: getRoute,
    );
  }
}

Route? getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:{
        return MaterialPageRoute(builder: (context) => const LoginPage(),settings: settings);
      }
      case Routes.home:{
        return MaterialPageRoute(builder: (context) => const HomePage(),settings: settings);
      }    
    }
    return null;
}
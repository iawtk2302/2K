import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sneaker_app/router/routes.dart';
import 'package:sneaker_app/screen/FillProfilePage.dart';
import 'package:sneaker_app/screen/ForgotPassPage.dart';
import 'package:sneaker_app/screen/HomePage.dart';
import 'package:sneaker_app/screen/LoginPage.dart';
import 'package:sneaker_app/screen/MainPage.dart';
import 'package:sneaker_app/screen/Register.dart';
import 'package:sneaker_app/screen/SplashScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
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
        fontFamily: "Urbanist",
        textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.black,
        selectionColor: Colors.black,
        selectionHandleColor: Colors.black,
     ),
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
      case Routes.register:{
        return MaterialPageRoute(builder: (context) => const RegisterPage(),settings: settings);
      }
      case Routes.forgot:{
        return MaterialPageRoute(builder: (context) => const ForgotPassPage(),settings: settings);
      }
      case Routes.home:{
        return MaterialPageRoute(builder: (context) => const HomePage(),settings: settings);
      }    
      case Routes.main:{
        return MaterialPageRoute(builder: (context) => const MainPage(),settings: settings);
      }
      case Routes.fillProfilePage:{
        return MaterialPageRoute(builder: (context) => const FillProfilePage(),settings: settings);
      }
    }
    return null;
}
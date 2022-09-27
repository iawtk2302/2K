import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sneaker_app/bloc/brand_bloc.dart';
import 'package:sneaker_app/bloc/home/home_bloc.dart';
import 'package:sneaker_app/router/routes.dart';
import 'package:sneaker_app/screen/ForgotPassPage.dart';
import 'package:sneaker_app/screen/HomePage.dart';
import 'package:sneaker_app/screen/LoginPage.dart';
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
    return BlocProvider(
      create: (context) => HomeBloc()..add(LoadHome()),
      child: MaterialApp(
        title: '2K',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: "Urbanist"),
        home: const SplashScreen(),
        onGenerateRoute: getRoute,
      ),
    );
  }
}

Route? getRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.login:
      {
        return MaterialPageRoute(
            builder: (context) => const LoginPage(), settings: settings);
      }
    case Routes.register:
      {
        return MaterialPageRoute(
            builder: (context) => const RegisterPage(), settings: settings);
      }
    case Routes.forgot:
      {
        return MaterialPageRoute(
            builder: (context) => const ForgotPassPage(), settings: settings);
      }
    case Routes.home:
      {
        return MaterialPageRoute(
            builder: (context) => const HomePage(), settings: settings);
      }
  }
  return null;
}

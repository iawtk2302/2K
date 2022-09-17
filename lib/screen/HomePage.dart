import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sneaker_app/router/routes.dart';
import 'package:sneaker_app/service/FirebaseService.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${FirebaseAuth.instance.currentUser!.displayName}"),
            ElevatedButton(onPressed: ()=>signOut(context), child: Text("signout"))
          ],
        )
    ),
    );
  }
}

signOut(BuildContext context)async{
  await FirebaseService().signOut();
  Navigator.pushReplacementNamed(context, Routes.login);
}
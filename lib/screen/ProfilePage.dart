import 'package:flutter/material.dart';
import 'package:sneaker_app/service/FirebaseService.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: ElevatedButton(
        onPressed: signOut, 
        child: Text("Sign out")
        ),
    );
  }
}

signOut(){
  FirebaseService().signOut();
}
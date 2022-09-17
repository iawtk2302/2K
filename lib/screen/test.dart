import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

appTest() async {
  if (await FirebaseAuth.instance.currentUser != null) {
    return Container();
} else {

}
}
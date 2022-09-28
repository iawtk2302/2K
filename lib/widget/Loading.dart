import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width:double.infinity,
      color: Colors.white,
      child: const SpinKitFoldingCube(
      color: Colors.black,
      size: 50.0,
  )
    );
  }
}
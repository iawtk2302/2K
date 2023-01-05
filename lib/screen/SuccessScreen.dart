import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sneaker_app/widget/CustomButton.dart';

import '../router/routes.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
     
          children: [
             SizedBox(height: 50,),
            Image.asset(
              "assets/images/success1.png",
              height: 400,
              width: 300,
            ),
            Text(
              "Order Complete!".tr,
              style: TextStyle(
                  color: Color(0xFF27AE60),
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text("Your payment was successful!".tr,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
            ),
            SizedBox(height: 40,),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF27AE60),
                    elevation: 0,
                    minimumSize: Size(350, 50),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    )),
                child: Text(
                  "Back To Home".tr,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16),
                ),
                onPressed: (){
                  Navigator.pushNamed(context, Routes.main);
                }),
          ],
        ),
      ),
    );
  }
}

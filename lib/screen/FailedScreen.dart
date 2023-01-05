import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../router/routes.dart';


class FailedPage extends StatelessWidget {
  const FailedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
         
          children: [
            SizedBox(height: 50,),
            Image.asset(
              "assets/images/failed1.png",
              height: 400,
              width: 300,
            ),
            Text(
              "Order Failed!".tr,
              style: TextStyle(
                  color: Color(0xFFFF5656),
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: SizedBox(
                width: 250,
                child: Text("Oops! An error occured while approving the order. You can try again.".tr,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,),textAlign: TextAlign.center,)),
            ),
            SizedBox(height: 40,),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF5656),
                    elevation: 0,
                    minimumSize: Size(350, 50),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    )),
                child: Text(
                  "Try Again".tr,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16),
                ),
                onPressed: (){
                  Navigator.pop(context);
                }),
                // ElevatedButton(
                // style: ElevatedButton.styleFrom(
                //     backgroundColor: Color(0xFF27AE60),
                //     elevation: 0,
                //     minimumSize: Size(350, 50),
                //     shape: const RoundedRectangleBorder(
                //       borderRadius: BorderRadius.all(Radius.circular(50)),
                //     )),
                // child: Text(
                //   "Try Again",
                //   style: TextStyle(
                //       fontWeight: FontWeight.bold,
                //       color: Colors.white,
                //       fontSize: 16),
                // ),
                // onPressed: (){
                //   Navigator.pushNamed(context, Routes.main);
                // }),
          ],
        ),
      ),
    );
  }
}
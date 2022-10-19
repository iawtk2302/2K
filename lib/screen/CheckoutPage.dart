import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sneaker_app/widget/ItemAddress.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDFDFD),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: (){Navigator.pop(context);},
          child: Icon(Icons.chevron_left,color: Colors.black,)),
        title: Text("Checkout", style: TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.bold),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text("Shipping Address",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            ),
            ItemAddress(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Container(
                height: 1,
                color: Color(0xFFECECEC),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text("Order List",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            ),
          ]),
        ),
      ),
    );
  }
}
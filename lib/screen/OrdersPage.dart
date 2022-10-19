import 'package:flutter/material.dart';
import 'package:sneaker_app/router/routes.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(children: [
        ElevatedButton(onPressed: (){Navigator.pushNamed(context, Routes.checkout);}, child: Text("checkout"))
      ]),
    );
  }
}

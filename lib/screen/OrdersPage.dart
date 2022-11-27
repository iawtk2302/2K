import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sneaker_app/router/routes.dart';
import 'package:sneaker_app/screen/order_active.dart';
import 'package:sneaker_app/screen/order_canceled.dart';
import 'package:sneaker_app/screen/order_completed.dart';
import 'package:sneaker_app/screen/track_order_screen.dart';
import 'package:sneaker_app/themes/Colors.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(
              'My orders',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  fontFamily: 'Urbanist'),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                onPressed: () {},
              )
            ],
            bottom: const TabBar(
              indicatorColor: Colors.black,
              labelColor: Colors.black,
              labelStyle: TextStyle(fontSize: 16),
              tabs: [
                Tab(text: 'Active'),
                Tab(
                  text: 'Completed',
                ),
                Tab(
                  text: 'Canceled',
                ),
              ],
            ),
            backgroundColor: Theme.of(context).canvasColor,
            elevation: 0.5,
          ),
          body: const TabBarView(
            children: [
              OrderActive(),
              OrderCompleted(),
              OrderCanceled(),
            ],
          ),
        ),
      ),
    );
  }
}

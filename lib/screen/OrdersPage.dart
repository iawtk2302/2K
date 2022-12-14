import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: Theme.of(context).scaffoldBackgroundColor,

            // Status bar brightness (optional)
            statusBarIconBrightness:
                Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          title: Text(
            'My orders',
            style: TextStyle(
                // color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22,
                fontFamily: 'Urbanist'),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.search,
                // color: Colors.black,
              ),
              onPressed: () {},
            )
          ],
          bottom: TabBar(
            indicatorColor: Theme.of(context).textTheme.bodyText2!.color,
            // labelColor: Colors.black,
            labelStyle: const TextStyle(fontSize: 16),
            tabs: const [
              Tab(text: 'Active'),
              Tab(
                text: 'Completed',
              ),
              Tab(
                text: 'Canceled',
              ),
            ],
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
    );
  }
}

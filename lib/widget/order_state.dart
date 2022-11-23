import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sneaker_app/model/order.dart';

import '../screen/track_order_screen.dart';
import 'item_status_order.dart';

class OrderState extends StatelessWidget {
  const OrderState({
    Key? key,
    required this.statusNum,
    required this.order,
  }) : super(key: key);

  final int statusNum;
  final Order order;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Item_Status_Order(
                icon: FontAwesomeIcons.box, isActive: !(statusNum < 0)),
            const Text('__'),
            Item_Status_Order(
                icon: FontAwesomeIcons.truck, isActive: !(statusNum < 1)),
            const Text('__'),
            Item_Status_Order(
                icon: FontAwesomeIcons.peopleCarryBox,
                isActive: !(statusNum < 2)),
            const Text('__'),
            Item_Status_Order(
                icon: FontAwesomeIcons.boxOpen, isActive: !(statusNum < 3)),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          convertText(),
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 17,
              fontFamily: 'Urbanist'),
        ),
      ],
    );
  }

  String convertText() {
    switch (order.state) {
      case 'packing':
        return 'Package is Packing';
      case 'delivery':
        return 'Package in Delivery';
      case 'delivered':
        return 'Package is Delivered';
      case 'completed':
        return 'Package is Completed';
    }
    return '';
  }
}

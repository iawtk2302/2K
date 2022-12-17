import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
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
                icon: FontAwesomeIcons.box,
                isActive: !(statusNum < 0) && statusNum != 4),
            const Text('__'),
            Item_Status_Order(
                icon: FontAwesomeIcons.truck,
                isActive: !(statusNum < 1) && statusNum != 4),
            const Text('__'),
            Item_Status_Order(
                icon: FontAwesomeIcons.peopleCarryBox,
                isActive: !(statusNum < 2) && statusNum != 4),
            const Text('__'),
            Item_Status_Order(
                icon: FontAwesomeIcons.boxOpen,
                isActive: !(statusNum < 3) && statusNum != 4),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          convertText().tr,
          style: TextStyle(
              // color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 17,
              fontFamily: 'Urbanist'),
        ),
      ],
    );
  }

  String convertText() {
    switch (statusNum) {
      case 0:
        return 'Package is Packing';
      case 1:
        return 'Package in Delivery';
      case 2:
        return 'Package is Delivered';
      case 3:
        return 'Package is Completed';
      case 4:
        return 'Package is Canceled';
    }
    return '';
  }
}

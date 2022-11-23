import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Item_Status_Order extends StatelessWidget {
  const Item_Status_Order({
    Key? key,
    required this.icon,
    required this.isActive,
  }) : super(key: key);
  final IconData icon;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FaIcon(
          icon,
          color: isActive ? Colors.black : Colors.grey,
        ),
        const SizedBox(
          height: 10,
        ),
        FaIcon(
          !isActive
              ? FontAwesomeIcons.circleCheck
              : FontAwesomeIcons.solidCircleCheck,
          size: 15,
        ),
      ],
    );
  }
}

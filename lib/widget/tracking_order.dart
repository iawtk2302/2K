import 'package:flutter/material.dart';
import '../model/order.dart';

class OrderTracking extends StatelessWidget {
  const OrderTracking({
    Key? key,
    required this.order,
  }) : super(key: key);
  final Order order;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ID Order',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    fontFamily: 'Urbanist'),
              ),
              Text(
                '#' + order.idOrder!,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    fontFamily: 'Urbanist'),
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Date Created'),
              Text(
                '${order.dateCreated!.toDate().day}' +
                    '/${order.dateCreated!.toDate().month}' +
                    '/${order.dateCreated!.toDate().year}',
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Date Delivered'), Text('JHJS3724EFJAWE')],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Date Completed'),
              Text(
                '${order.dateCompleted!.toDate().day}' +
                    '/${order.dateCompleted!.toDate().month}' +
                    '/${order.dateCompleted!.toDate().year}',
              )
            ],
          ),
        ],
      ),
    );
  }
}
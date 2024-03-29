import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/order.dart';

class OrderTracking extends StatelessWidget {
  const OrderTracking({
    Key? key,
    required this.order,
  }) : super(key: key);
  final MyOrder order;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ID Order'.tr,
                style: TextStyle(
                    // color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    fontFamily: 'Urbanist'),
              ),
              Text(
                '#' + order.idOrder!,
                style: TextStyle(
                    // color: Colors.black,
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
              Text('Date Created'.tr),
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
            children: [Text('Date Delivered'.tr), Text('27/11/2023')],
          ),
          SizedBox(
            height: 8,
          ),
          if (order.state == 'completed')
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Date Completed'.tr),
                Text(
                  '${order.dateCompleted!.toDate().day}' +
                      '/${order.dateCompleted!.toDate().month}' +
                      '/${order.dateCompleted!.toDate().year}',
                )
              ],
            ),
          if (order.state == 'canceled')
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Date Canceled'),
                Text(
                  '${order.dateCanceled!.toDate().day}' +
                      '/${order.dateCanceled!.toDate().month}' +
                      '/${order.dateCanceled!.toDate().year}',
                )
              ],
            ),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sneaker_app/widget/cart_item.dart';
import 'package:sneaker_app/widget/order_item.dart';

import '../bloc/my_order/my_order_bloc.dart';
import '../model/order.dart';
import '../model/product.dart';
import '../model/product_cart.dart';
import '../widget/Loading.dart';

class OrderCanceled extends StatefulWidget {
  const OrderCanceled({super.key});

  @override
  State<OrderCanceled> createState() => _OrderCanceledState();
}

class _OrderCanceledState extends State<OrderCanceled> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyOrderBloc, MyOrderState>(
      builder: (context, state) {
        if (state is MyOrderLoading) {
          return Loading();
        } else if (state is MyOrderLoaded) {
          List<MyOrder> listOrder = [];
          listOrder = state.listOrder
              .where(
                (element) => element.state == 'canceled',
              )
              .toList();
          if (listOrder.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                    image: AssetImage('assets/images/clipboard.png'),
                    width: 250,
                    height: 250,
                    fit: BoxFit.contain),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'You don\'t have an order yet'.tr,
                  style: const TextStyle(
                      // color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'Urbanist'),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'You don\'t have a cancel orders at this time'.tr,
                  style: const TextStyle(
                      // color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Urbanist'),
                )
              ],
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    listOrder.length,
                    (index) => Column(
                          children: [
                            ItemOrder(
                              order: listOrder[index],
                            ),
                            SizedBox(
                              height: 16,
                            )
                          ],
                        )),
              ),
            );
          }
        } else
          return SizedBox();
      },
    );
  }
}

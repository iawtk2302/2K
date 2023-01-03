import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        } else
          return SizedBox();
      },
    );
  }
}

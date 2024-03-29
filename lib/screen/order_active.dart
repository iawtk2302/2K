import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sneaker_app/widget/Loading.dart';
import 'package:sneaker_app/widget/order_item.dart';

import '../bloc/my_order/my_order_bloc.dart';
import '../model/order.dart';
import '../model/product.dart';
import '../model/product_cart.dart';

class OrderActive extends StatefulWidget {
  const OrderActive({super.key});

  @override
  State<OrderActive> createState() => _OrderActiveState();
}

final Product product = Product(
    idCategory: "Ca32",
    idProduct: '111',
    name: 'OLD SKOOL',
    image: [
      'https://images.vans.com/is/image/Vans/VN0A4BW2RV2-HERO?wid=1600&hei=1600&fmt=jpeg&qlt=90&resMode=sharp2&op_usm=0.9,1.7,8,0'
    ],
    description: 'aaa',
    gender: ['Men'],
    categoryName: 'Vans',
    price: 333);

final ProductCart productCart =
    ProductCart(product: product, amount: 3, size: 32);

class _OrderActiveState extends State<OrderActive> {
  Future<void> _refreshRandomNumbers() =>
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {});
      });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyOrderBloc, MyOrderState>(
      builder: (context, state) {
        if (state is MyOrderLoading) {
          return const Loading();
        } else if (state is MyOrderLoaded) {
          List<MyOrder> listOrder = [];
          listOrder = state.listOrder
              .where(
                (element) =>
                    element.state != 'completed' && element.state != 'canceled',
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
                  'You don\'t have an active orders at this time'.tr,
                  style: const TextStyle(
                      // color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Urbanist'),
                )
              ],
            );
          } else {
            return Container(
              padding: const EdgeInsets.only(top: 20),
              color: Theme.of(context).scaffoldBackgroundColor,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      listOrder.length,
                      (index) => RefreshIndicator(
                            onRefresh: _refreshRandomNumbers,
                            child: Column(
                              children: [
                                ItemOrder(
                                  order: listOrder[index],
                                ),
                                const SizedBox(
                                  height: 16,
                                )
                              ],
                            ),
                          )),
                ),
              ),
            );
          }
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

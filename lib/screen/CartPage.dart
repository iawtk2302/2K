import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sneaker_app/widget/Loading.dart';
import 'package:sneaker_app/widget/custom_textbutton.dart';

import '../bloc/cart/card_bloc.dart';
import '../router/routes.dart';
import '../widget/cart_item.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int quantity = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 0.5,
          title: Text(
            'My Cart',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22,
                fontFamily: 'Urbanist'),
          )),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return Loading();
          } else if (state is CartLoaded) {
            return Stack(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(children: [
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                      itemCount: state.cart.products.length,
                      itemBuilder: (context, index) => CartItem(
                        product: state.cart.products[index],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 90,
                  )
                ]),
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      color: Colors.white,
                      height: 80,
                      width: double.infinity,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Total price',
                                  style: TextStyle(),
                                ),
                                Text(
                                  '\$${state.cart.calculatePrice()}' + '.00',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                )
                              ],
                            ),
                            Container(
                              width: 220,
                              height: 55,
                              child: CustomTextButton(
                                onPressed: () {
                                  if (state.cart.products.isNotEmpty) {
                                    Navigator.pushNamed(
                                        context, Routes.checkout,
                                        arguments: state.cart.products);
                                  }
                                },
                                text: 'Checkout',
                                hasLeftIcon: false,
                                isDark: true,
                                hasRightIcon: true,
                              ),
                            )
                          ]),
                    ),
                  ))
            ]);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

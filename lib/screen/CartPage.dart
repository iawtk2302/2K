import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sneaker_app/widget/Loading.dart';

import '../bloc/cart/card_bloc.dart';
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
      appBar: AppBar(title: Text('My Cart')),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return Loading();
          } else if (state is CartLoaded) {
            return Padding(
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
                )
              ]),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

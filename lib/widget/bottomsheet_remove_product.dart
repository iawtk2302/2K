import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cart/card_bloc.dart';
import '../model/product_cart.dart';
import 'cart_item.dart';
import 'custom_textbutton.dart';

class BottomSheet_RemoveProduct extends StatefulWidget {
  const BottomSheet_RemoveProduct({super.key, required this.product});
  final ProductCart product;
  @override
  State<BottomSheet_RemoveProduct> createState() =>
      BottomSheet_RemoveProductState();
}

class BottomSheet_RemoveProductState extends State<BottomSheet_RemoveProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Remove From Cart',
              style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 10,
              child: Divider(
                height: 1,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CartItem(product: widget.product),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 10,
              child: Divider(
                height: 1,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 70,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width / 3 + 20,
                      child: CustomTextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        text: 'Cancel',
                        hasLeftIcon: false,
                        isDark: false,
                        hasRightIcon: false,
                      )),
                  Container(
                      // height: 80,
                      width: MediaQuery.of(context).size.width / 3 + 20,
                      child: CustomTextButton(
                        onPressed: () {
                          context.read<CartBloc>()
                            ..add(CartProductRemove(
                                product: ProductCart(
                                    product: widget.product.product,
                                    amount: widget.product.amount,
                                    size: widget.product.size)));
                          Navigator.pop(context);
                        },
                        text: 'Yes, Remove',
                        hasLeftIcon: false,
                        isDark: true,
                        hasRightIcon: false,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

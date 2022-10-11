import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sneaker_app/modal/product.dart';

import '../bloc/cart/card_bloc.dart';

class CartItem extends StatefulWidget {
  const CartItem({super.key, required this.product});
  final Product product;
  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int quantity = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 216, 211, 211),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      height: 160,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: Row(children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                  fit: BoxFit.cover, imageUrl: widget.product.image![0]),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                    flex: 3,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Text(
                            widget.product.name!,
                            maxLines: 2,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                        Expanded(
                          child: Material(
                              color: Colors.transparent,
                              child: IconButton(
                                  splashRadius: 20,
                                  onPressed: () {
                                    context.read<CartBloc>()
                                      ..add(CartProductRemove(
                                          product: widget.product));
                                  },
                                  icon: Icon(Icons.delete))),
                        )
                      ],
                    )),
                Expanded(
                    child: Row(
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.grey),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Size = 42',
                      style: TextStyle(
                          fontFamily: 'Urbanist', fontWeight: FontWeight.w500),
                    )
                  ],
                )),
                Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${(widget.product.price)?.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        Material(
                          color: Color(0xFFF3F3F3),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          child: Container(
                            width: 100,
                            height: 35,
                            decoration: BoxDecoration(
                                // color: Color(0xFFF3F3F3),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Row(children: [
                              Expanded(
                                child: IconButton(
                                  splashRadius: 17,
                                  icon: Icon(
                                    Icons.horizontal_rule,
                                    size: 18,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (quantity > 0) quantity--;
                                    });
                                  },
                                ),
                              ),
                              Expanded(
                                child: Center(
                                    child: Text(
                                  quantity.toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Urbanist'),
                                )),
                              ),
                              Expanded(
                                child: IconButton(
                                  splashRadius: 17,
                                  icon: Icon(
                                    Icons.add,
                                    size: 18,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      quantity++;
                                    });
                                  },
                                ),
                              )
                            ]),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          )
        ]),
      ),
    );
    ;
  }
}

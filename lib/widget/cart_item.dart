import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sneaker_app/model/product.dart';
import 'package:sneaker_app/model/product_cart.dart';
import 'package:sneaker_app/screen/product_detail.dart';
import 'package:sneaker_app/widget/bottomsheet_remove_product.dart';

import '../bloc/cart/card_bloc.dart';
import 'custom_textbutton.dart';

class CartItem extends StatefulWidget {
  const CartItem({super.key, required this.product});
  final ProductCart product;
  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int quantity = 0;
  @override
  void initState() {
    quantity = widget.product.amount!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ProductDetail(product: widget.product.product!))),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        height: 160,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
          child: Row(children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: widget.product.product!.image![0]),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                      flex: 3,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              widget.product.product!.name!,
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
                                      showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          builder: ((context) =>
                                              BottomSheet_RemoveProduct(
                                                product: widget.product,
                                              )));
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
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  )),
                  Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${(widget.product.product!.price)?.toStringAsFixed(2)}',
                            style: TextStyle(
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          SizedBox(
                            width: 10,
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
                                  child: BlocBuilder<CartBloc, CartState>(
                                    builder: (context, state) {
                                      return IconButton(
                                        splashRadius: 17,
                                        icon: Icon(
                                          Icons.horizontal_rule,
                                          size: 18,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            if (quantity > 1) {
                                              quantity--;
                                              widget.product.amount = quantity;
                                              context.read<CartBloc>()
                                                ..add(CartProductUpdate(
                                                    product: widget.product));
                                            } else if (quantity > 0) {
                                              print(
                                                  'Are you want to delete item from cart');
                                            } else {}
                                          });
                                        },
                                      );
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
                                  child: BlocBuilder<CartBloc, CartState>(
                                    builder: (context, state) {
                                      return IconButton(
                                        splashRadius: 17,
                                        icon: Icon(
                                          Icons.add,
                                          size: 18,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            quantity++;
                                            widget.product.amount = quantity;
                                            context.read<CartBloc>()
                                              ..add(CartProductUpdate(
                                                  product: widget.product));
                                          });
                                        },
                                      );
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
      ),
    );
    ;
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.all(Radius.circular(30))),
        height: 160,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
          child: Row(children: [
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: widget.product.product!.image![0]),
              ),
            ),
            const SizedBox(
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
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                          Expanded(
                            child: Material(
                                color: Colors.transparent,
                                child: IconButton(
                                    splashRadius: 18,
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
                                    icon: const Icon(Icons.delete))),
                          )
                        ],
                      )),
                  Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          Text(
                            'Size = ' + '${widget.product.size}',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          )
                        ],
                      )),
                  Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            // flex: 2,
                            child: Text(
                              convertPrice(widget.product.product!.price!) +
                                  'đ',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ),
                          // const SizedBox(
                          //   width: 10,
                          // ),
                          Flexible(
                            // flex: 1,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Material(
                                color: Theme.of(context).backgroundColor,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                child: Container(
                                  decoration: const BoxDecoration(
                                      // color: Color(0xFFF3F3F3),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: SizedBox(
                                    height: 40,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: BlocBuilder<CartBloc,
                                                CartState>(
                                              builder: (context, state) {
                                                return InkWell(
                                                  // splashRadius: 17,
                                                  child: const Icon(
                                                    Icons.horizontal_rule,
                                                    size: 18,
                                                  ),
                                                  onTap: () {
                                                    setState(() {
                                                      if (quantity > 1) {
                                                        quantity--;
                                                        widget.product.amount =
                                                            quantity;
                                                        context.read<CartBloc>()
                                                          ..add(CartProductUpdate(
                                                              product: widget
                                                                  .product));
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
                                            child: Text(
                                              quantity.toString(),
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Expanded(
                                            child: BlocBuilder<CartBloc,
                                                CartState>(
                                              builder: (context, state) {
                                                return InkWell(
                                                  // splashRadius: 17,
                                                  child: const Icon(
                                                    Icons.add,
                                                    size: 18,
                                                  ),
                                                  onTap: () {
                                                    setState(() {
                                                      quantity++;
                                                      widget.product.amount =
                                                          quantity;
                                                      context.read<CartBloc>()
                                                        ..add(CartProductUpdate(
                                                            product: widget
                                                                .product));
                                                    });
                                                  },
                                                );
                                              },
                                            ),
                                          )
                                        ]),
                                  ),
                                ),
                              ),
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
  }

  String convertPrice(double price) {
    final format = NumberFormat("###,###.###", "tr_TR");

    return format.format(price);
  }
}

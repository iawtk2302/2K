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

class OrderItem extends StatefulWidget {
  const OrderItem({super.key, required this.product});
  final ProductCart product;
  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  int quantity = 0;
  @override
  void initState() {
    quantity = widget.product.amount!;
    super.initState();
  }

  String convertPrice(double price) {
    final format = NumberFormat("###,###.###", "tr_TR");

    return format.format(price) + 'đ';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.all(Radius.circular(30))),
        height: 160,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
          child: Row(children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
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
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.product.product!.name!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      )),
                  Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          Text(
                            'Size = ' + '${widget.product.size}',
                            style: TextStyle(
                                
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      )),
                  Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${convertPrice(widget.product.product!.price!)}',
                            style: TextStyle(
<<<<<<< HEAD
                                
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
=======
                                fontWeight: FontWeight.bold, fontSize: 16),
>>>>>>> 36fce546461b38355d14a4ff334ea33c1f9ad6db
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Material(
                            color: Theme.of(context).backgroundColor,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                  // color: Color(0xFFF3F3F3),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              child: Row(children: [
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
  }
}

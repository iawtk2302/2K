import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sneaker_app/model/detail_order.dart';
import 'package:sneaker_app/model/order.dart';
import 'package:sneaker_app/model/product.dart';
import 'package:sneaker_app/model/product_cart.dart';
import 'package:sneaker_app/widget/bottomsheet_review.dart';

import '../bloc/cart/card_bloc.dart';
import '../screen/track_order_screen.dart';
import 'bottomsheet_remove_product.dart';

class ItemOrder extends StatefulWidget {
  const ItemOrder({super.key, required this.order});
  final MyOrder order;
  @override
  State<ItemOrder> createState() => ItemOrderState();
}

class ItemOrderState extends State<ItemOrder> {
  late String imgLink;
  late String idProduct;
  @override
  void initState() {
    // FirebaseFirestore.instance
    //     .collection('DetailOrder')
    //     .where('idOrder', isEqualTo: widget.order.idOrder)
    //     .limit(1)
    //     .get()
    //     .then((value) {
    //   idProduct = value.docs[0].get('idProduct');
    // }).then((value) {

    // });
    FirebaseFirestore.instance
        .collection('Product')
        .where('idProduct', isEqualTo: '0C768m6WUdCZNfcARGRZ')
        .get()
        .then((value) {
      imgLink = value.docs[0].get('image')[0];
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      height: widget.order.state != 'completed' ? 170 : 190,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
        child: Row(children: [
          // Container(
          //   width: 130,
          //   height: 130,
          //   decoration: const BoxDecoration(
          //       borderRadius: BorderRadius.all(Radius.circular(30))),
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.circular(16.0),
          //     child: CachedNetworkImage(
          //         placeholder: (context, url) => CircularProgressIndicator(),
          //         errorWidget: (context, url, error) => Icon(Icons.read_more),
          //         fit: BoxFit.cover,
          //         imageUrl: imgLink ??
          //             'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
          //   ),
          // ),
          const SizedBox(
            width: 16,
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
                            '#' + widget.order.idOrder!,
                            maxLines: 2,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ],
                    )),
                Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        Text(
                          'Date Created: '.tr +
                              '${widget.order.dateCreated!.toDate().day}'
                                  '/ ${widget.order.dateCreated!.toDate().month}'
                                  '/ ${widget.order.dateCreated!.toDate().year}',
                          style: const TextStyle(
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    )),
                if (widget.order.state == 'completed')
                  Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          Text(
                            'Date Completed: '.tr +
                                '${widget.order.dateCompleted!.toDate().day}'
                                    '/${widget.order.dateCompleted!.toDate().month}'
                                    '/${widget.order.dateCompleted!.toDate().year}',
                            style: const TextStyle(
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      )),
                if (widget.order.state == 'canceled')
                  Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          Text(
                            'Date Canceled: '
                            '${widget.order.dateCanceled!.toDate().day}'
                            '/${widget.order.dateCanceled!.toDate().month}'
                            '/${widget.order.dateCanceled!.toDate().year}',
                            style: const TextStyle(
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      )),
                const SizedBox(
                  height: 2,
                ),
                Expanded(
                    flex: 4,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            color: Theme.of(context).backgroundColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        child: Text(
                          widget.order.state!.tr,
                          style: const TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    )),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  height: 0.5,
                  width: double.infinity,
                  color: Colors.grey,
                ),
                Expanded(
                    flex: 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${(widget.order.total)?.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        ElevatedButton(
                            style: ButtonStyle(
                                // backgroundColor: MaterialStateProperty.all(
                                //     Color(0xFFECECEC)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        side: const BorderSide(
                                            color: Colors.transparent)))),
                            onPressed: () {
                              // print(imgLink);
                              if (getText() == 'Re-Order') {
                                // showModalBottomSheet(
                                //     context: context,
                                //     builder: ((context) => BottomSheetReview(
                                //           order: widget.order,
                                //         )));
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TrackOrderScreen(
                                        order: widget.order,
                                      ),
                                    ));
                              }
                            },
                            child: Text(
                              getText().tr,
                              style: TextStyle(
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w600,
                                color:
                                    Theme.of(context).textTheme.button!.color,
                              ),
                            ))
                      ],
                    )),
              ],
            ),
          )
        ]),
      ),
    );
  }

  String getText() {
    return widget.order.state != 'completed' && widget.order.state != 'canceled'
        ? 'Track Order'
        : widget.order.dateCompleted!
                    .toDate()
                    .difference(widget.order.dateCreated!.toDate())
                    .inDays >
                4
            ? 'Re-Order'
            : 'View Detail';
  }
}

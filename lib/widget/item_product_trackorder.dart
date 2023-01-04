import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sneaker_app/model/order.dart';
import 'package:sneaker_app/model/product.dart';
import 'package:sneaker_app/model/product_cart.dart';
import 'package:sneaker_app/widget/bottomsheet_review.dart';

class Item_Product_TrackOrder extends StatelessWidget {
  const Item_Product_TrackOrder(
      {super.key,
      required this.product,
      required this.order,
      required this.isInModal});
  final ProductCart product;
  final MyOrder order;
  final bool isInModal;
  String convertPrice(double price) {
    final format = NumberFormat("###,###.###", "tr_TR");

    return format.format(price) + 'đ';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        height: 140,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
          child: Row(children: [
            Container(
              decoration: const BoxDecoration(
                  // borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: CachedNetworkImage(
                    fit: BoxFit.cover, imageUrl: product.product!.image![0]),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                      flex: 4,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          product.product!.name!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      )),
                  Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          Text(
                            'Size'.tr + ': ' + '${product.size}',
                            style: const TextStyle(
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            ' | Qty = '.tr + '${product.amount}',
                            style: const TextStyle(
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      )),
                  Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${product.product!.price} đ',
                            style: TextStyle(
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          if (!isInModal && order.state == 'completed')
                            ElevatedButton(
                                style: ButtonStyle(
                                    // backgroundColor:
                                    //     MaterialStateProperty.all(Colors.black),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: BorderSide(
                                                color: Colors.transparent)))),
                                onPressed: () {
                                  // print(imgLink);
                                  // if (getText() == 'Review') {
                                  //   showModalBottomSheet(
                                  //       context: context,
                                  //       builder: ((context) => BottomSheetReview(
                                  //             order: widget.order,
                                  //           )));
                                  // } else
                                  //   Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //         builder: (context) => TrackOrderScreen(
                                  //           order: widget.order,
                                  //         ),
                                  //       ));
                                  showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20))),
                                      builder: ((context) => BottomSheetReview(
                                            order: order,
                                            productCart: product,
                                          )));
                                },
                                child: Text(
                                  'Review'.tr,
                                  style: TextStyle(
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context)
                                        .textTheme
                                        .button!
                                        .color,
                                  ),
                                ))
                          // Material(
                          //   color: Color(0xFFF3F3F3),
                          //   borderRadius: BorderRadius.all(Radius.circular(20)),
                          //   child: Container(
                          //     width: 35,
                          //     height: 35,
                          //     decoration: BoxDecoration(
                          //         // color: Color(0xFFF3F3F3),
                          //         borderRadius:
                          //             BorderRadius.all(Radius.circular(50))),
                          //     child: Row(children: [
                          //       Expanded(
                          //         child: Center(
                          //             child: Text(
                          //           'quantity',
                          //           style: TextStyle(
                          //               fontSize: 16,
                          //               fontWeight: FontWeight.bold,
                          //               fontFamily: 'Urbanist'),
                          //         )),
                          //       ),
                          //     ]),
                          //   ),
                          // ),
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

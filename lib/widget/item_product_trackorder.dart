import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
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
  final Order order;
  final bool isInModal;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          // borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        height: 140,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
          child: Row(children: [
            Container(
              decoration: BoxDecoration(
                  // borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: CachedNetworkImage(
                    fit: BoxFit.cover, imageUrl: product.product!.image![0]),
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
                          product.product!.name!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
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
                            'Size = ' + '${product.size}',
                            style: TextStyle(
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            ' | Qty = ' + '${product.amount}',
                            style: TextStyle(
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
                            '\$${(product.product!.price)?.toStringAsFixed(2)}',
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
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.black),
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
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      builder: ((context) => BottomSheetReview(
                                            order: order,
                                            productCart: product,
                                          )));
                                },
                                child: Text(
                                  'Review',
                                  style: TextStyle(
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w600,
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

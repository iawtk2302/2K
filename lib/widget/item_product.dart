import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sneaker_app/model/product.dart';

import '../bloc/product/product_bloc.dart';
import '../screen/product_detail.dart';

class ItemProduct extends StatefulWidget {
  const ItemProduct(
      {super.key,
      required this.isLiked,
      this.callBack,
      this.animationController,
      this.animation,
      required this.product});
  final bool isLiked;
  final VoidCallback? callBack;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final Product product;
  @override
  State<ItemProduct> createState() => _ItemProductState();
}

class _ItemProductState extends State<ItemProduct> {
  bool isLike = false;
  void moveToDetailProduct(Product product) async {
    final information = await Navigator.push(
      context,
      MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => ProductDetail(
                product: product,
              )),
    );
    setState(() {
      isLike = information;
    });
  }

  @override
  void initState() {
    final docFavorite = FirebaseFirestore.instance.collection('Favorite');
    final doc = docFavorite
        .where('idProduct', isEqualTo: widget.product.idProduct)
        .get()
        .then((value) {
      if (value.docs.length != 0) {
        setState(() {
          isLike = true;
        });
      } else {
        isLike = false;
      }
    });
    // print(widget.animation!.value.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.animation!,
          child: Transform(
              transform: Matrix4.translationValues(
                  0.0, 50 * (1.0 - widget.animation!.value), 0.0),
              child: InkWell(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => ProductDetail(
                  //               product: widget.product,
                  //             )));
                  moveToDetailProduct(widget.product);
                },
                // width: MediaQuery.of(context).size.width / 2,
                // height: 275,
                child: Column(children: [
                  Expanded(
                    flex: 4,
                    child: Stack(children: [
                      Container(
                        // decoration: const BoxDecoration(color: Color(0xFFF3F3F3)),
                        height: 180,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Hero(
                            tag: widget.product.image![0],
                            child: Image(
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(Icons.label_important),
                                width: double.infinity,
                                fit: BoxFit.cover,
                                image: CachedNetworkImageProvider(
                                    widget.product.image![0])),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          height: 50,
                          width: 50,
                          child: IconButton(
                            splashRadius: 20,
                            icon: isLike
                                ? const Icon(
                                    Icons.favorite,
                                    color: Colors.black,
                                  )
                                : const Icon(
                                    Icons.favorite_border,
                                    color: Colors.black,
                                  ),
                            onPressed: () {
                              context.read<ProductBloc>().add(ReactProduct(
                                  idProduct: widget.product.idProduct!,
                                  idUser:
                                      FirebaseAuth.instance.currentUser!.uid));
                              setState(() {
                                isLike = !isLike;
                              });
                              if (isLike) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        duration: Duration(milliseconds: 400),
                                        content: Text("Added to favorites")));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        duration: Duration(milliseconds: 400),
                                        content:
                                            Text("Removed from favorites")));
                              }
                            },
                          ),
                        ),
                      )
                    ]),
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const Spacer(),
                        Expanded(
                          child: Text(
                            widget.product.name!.toUpperCase(),
                            maxLines: 1,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                            // textAlign: TextAlign.left,
                          ),
                        ),
                        // const Spacer(),
                        // Expanded(
                        //   child: Row(
                        //     children: [
                        //       const Icon(
                        //         Icons.star,
                        //         size: 20,
                        //       ),
                        //       const Spacer(),
                        //       const Text(
                        //         '4.5 |',
                        //         style: TextStyle(fontSize: 12),
                        //       ),
                        //       const Spacer(),
                        //       Container(
                        //         decoration: const BoxDecoration(
                        //             color: Color(0xFFECEDEC),
                        //             borderRadius:
                        //                 BorderRadius.all(Radius.circular(10))),
                        //         child: const Padding(
                        //           padding: EdgeInsets.all(6.0),
                        //           child: Text(
                        //             '7.483 sold',
                        //             style: TextStyle(fontSize: 12),
                        //           ),
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        // const Spacer(),
                        Expanded(
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              convertPrice(widget.product.price!),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                        ),
                        // const Spacer()
                      ],
                    ),
                  )
                ]),
              )),
        );
      },
    );
  }

  String convertPrice(double price) {
    final format = NumberFormat("###,###.###", "tr_TR");

    return format.format(price) + 'đ';
  }
}

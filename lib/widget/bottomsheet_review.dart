import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sneaker_app/model/order.dart';
import 'package:sneaker_app/model/product_cart.dart';
import 'package:sneaker_app/model/review.dart';
import 'package:sneaker_app/widget/cart_item.dart';
import 'package:sneaker_app/widget/item_product_trackorder.dart';
import 'package:sneaker_app/widget/order_item.dart';

import '../bloc/home/user_bloc.dart';
import 'custom_textbutton.dart';

class BottomSheetReview extends StatefulWidget {
  const BottomSheetReview(
      {super.key, required this.order, required this.productCart});
  final MyOrder order;
  final ProductCart productCart;
  @override
  State<BottomSheetReview> createState() => BottomSheetReviewState();
}

class BottomSheetReviewState extends State<BottomSheetReview> {
  int starNumber = 4;
  bool isFocus = false;
  late Review? review;
  late TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController();

    loadReview();
    super.initState();
  }

  loadReview() async {
    await FirebaseFirestore.instance
        .collection('Review')
        .where('idProduct', isEqualTo: widget.productCart.product!.idProduct)
        .where('idUser', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.length != 0) {
        review = Review.fromJson(value.docs[0].data());
        starNumber = review!.star!;
        _controller.text = review!.content!;
        setState(() {});
        // print(review!.star);

      } else
        review = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height:
            WidgetsBinding.instance.window.viewInsets.bottom <= 0.0 ? 550 : 500,
        decoration: const BoxDecoration(
            // color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Padding(
          padding:
              const EdgeInsets.only(bottom: 16.0, left: 16, right: 16, top: 8),
          child: Stack(children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.maximize,
                ),
                Text(
                  'Leave a review',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
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
                Item_Product_TrackOrder(
                    product: widget.productCart,
                    order: widget.order,
                    isInModal: true),
                // Container(
                //   height: 10,
                //   child: Divider(
                //     height: 1,
                //   ),
                // ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 1,
                  // color: Colors.grey,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'How is your order?',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                Text(
                  'Please give your rating & also your review...',
                  style: TextStyle(fontFamily: 'Urbanist'),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    5,
                    (index) => InkWell(
                        onTap: () {
                          setState(() {
                            starNumber = index;
                          });
                        },
                        child: Icon(
                          !(index <= starNumber)
                              ? Icons.star_border
                              : Icons.star,
                          size: 30,
                        )),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _controller,
                  onTap: () {
                    setState(() {
                      isFocus = true;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter your review',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                ),
              ],
            ),
            // if (WidgetsBinding.instance.window.viewInsets.bottom <= 0.0)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                // height: 70,
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
                        child: BlocBuilder<UserBloc, UserState>(
                          builder: (context, state) {
                            if (state is UserLoading) {
                              return Container();
                            } else if (state is UserExist) {
                              return CustomTextButton(
                                onPressed: () async {
                                  if (review == null) {
                                    final docReview = FirebaseFirestore.instance
                                        .collection('Review');
                                    docReview.add({
                                      'idProduct':
                                          widget.productCart.product!.idProduct,
                                      'star': starNumber,
                                      'content': _controller.text,
                                      'idUser': FirebaseAuth
                                          .instance.currentUser!.uid,
                                      'fullName':
                                          state.user.firstName.toString() +
                                              ' ' +
                                              state.user.lastName.toString(),
                                      'image': state.user.image,
                                      'dateCreated': DateTime.now(),
                                    }).then((value) => docReview
                                        .doc(value.id)
                                        .update({'idReview': value.id}));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Review successful')));
                                    Navigator.pop(context);
                                  } else {
                                    final docReview = FirebaseFirestore.instance
                                        .collection('Review');
                                    docReview.doc(review!.idReview).update({
                                      'star': starNumber,
                                      'content': _controller.text,
                                    });
                                  }
                                },
                                text: 'Submit',
                                hasLeftIcon: false,
                                isDark: true,
                                hasRightIcon: false,
                              );
                            } else
                              return Container();
                          },
                        )),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product/product_bloc.dart';
import '../model/product.dart';
import '../model/review.dart';
import '../router/routes.dart';

class ProductDetailHeader extends StatefulWidget {
  const ProductDetailHeader({
    Key? key,
    required this.product,
    required this.isLiked,
    required this.onPressed,
  }) : super(key: key);
  final Product product;
  final bool isLiked;
  final Function onPressed;

  @override
  State<ProductDetailHeader> createState() => _ProductDetailHeaderState();
}

class _ProductDetailHeaderState extends State<ProductDetailHeader> {
  final review = FirebaseFirestore.instance.collection('Review');
  final detailOrder = FirebaseFirestore.instance.collection('DetailOrder');
  int totalRate = 0;
  double rate = 0;
  int totalSold = 0;
  @override
  void initState() {
    getReview();
    getSold();
    super.initState();
  }

  getReview() async {
    double total = 0;
    late double length;
    await review
        .where('idProduct', isEqualTo: widget.product.idProduct)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        total += element.get('star') + 1;
      });
      if (value.docs.length != 0) {
        totalRate = value.docs.length;
        rate = total / totalRate;
      }
    });
    setState(() {});
  }

  getSold() async {
    await detailOrder
        .where('idProduct', isEqualTo: widget.product.idProduct)
        .get()
        .then((value) {
      totalSold = value.docs.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                widget.product.name!.toUpperCase(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    fontFamily: 'Urbanist'),
                maxLines: 2,
              ),
            ),
            IconButton(
                onPressed: () {
                  context.read<ProductBloc>().add(ReactProduct(
                        idProduct: widget.product.idProduct!,
                        idUser: FirebaseAuth.instance.currentUser!.uid,
                      ));
                  widget.onPressed();
                },
                icon: Icon(
                    !widget.isLiked ? Icons.favorite_border : Icons.favorite))
          ],
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, Routes.review,
                arguments: widget.product);
          },
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Text(
                    totalSold.toString() + ' sold',
                    style: TextStyle(fontSize: 12, fontFamily: 'Urbanist'),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              const Icon(
                Icons.star,
                size: 20,
              ),
              Text(
                rate.toString(),
                style: TextStyle(fontSize: 16, fontFamily: 'Urbanist'),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                '(${totalRate.toString()} reviews)',
                style: TextStyle(fontSize: 15, fontFamily: 'Urbanist'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

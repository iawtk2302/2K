import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product/product_bloc.dart';
import '../modal/product.dart';

class ProductDetailHeader extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                product.name!,
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
                        idProduct: product.idProduct!,
                        idUser: FirebaseAuth.instance.currentUser!.uid,
                      ));
                  onPressed();
                },
                icon: Icon(!isLiked ? Icons.favorite_border : Icons.favorite))
          ],
        ),
        Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: Color(0xFFECEDEC),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: const Padding(
                padding: EdgeInsets.all(6.0),
                child: Text(
                  '7.483 sold',
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
            const Text(
              '4.5',
              style: TextStyle(fontSize: 16, fontFamily: 'Urbanist'),
            ),
            SizedBox(
              width: 10,
            ),
            const Text(
              '(6,573 reviews)',
              style: TextStyle(fontSize: 15, fontFamily: 'Urbanist'),
            ),
          ],
        ),
      ],
    );
  }
}

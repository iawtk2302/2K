import 'package:flutter/material.dart';

class ProductDetailHeader extends StatelessWidget {
  const ProductDetailHeader({
    Key? key,
    required this.name,
  }) : super(key: key);
  final String name;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    fontFamily: 'Urbanist'),
                maxLines: 2,
              ),
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border))
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

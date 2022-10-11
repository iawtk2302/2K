import 'package:flutter/material.dart';

class ProductDescription extends StatefulWidget {
  const ProductDescription({super.key, required this.description});
  final String description;
  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  bool isExpand = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            'Description',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Urbanist'),
            // textAlign: TextAlign.left,
          ),
        ),
        Column(
          children: [
            Text(
              widget.description,
              maxLines: isExpand ? 10 : 2,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontFamily: 'Urbanist'),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: () {
                  setState(() {
                    isExpand = !isExpand;
                  });
                },
                child: Text(
                  !isExpand ? "See more..." : "See less...",
                  style: TextStyle(color: Colors.blue, fontFamily: 'Urbanist'),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}

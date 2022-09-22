import 'package:flutter/material.dart';
import 'package:sneaker_app/screen/product_screen.dart';

class BrandCatagory extends StatelessWidget {
  const BrandCatagory({
    Key? key,
    required this.imgUri,
    required this.name,
  }) : super(key: key);
  final String imgUri;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RawMaterialButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => ProductScreen())));
          },
          elevation: 2.0,
          fillColor: Color(0xFFECECEC),
          child: Image(
            height: 30,
            width: 30,
            fit: BoxFit.scaleDown,
            image: NetworkImage(imgUri),
          ),
          padding: EdgeInsets.all(12.0),
          shape: CircleBorder(),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          name,
          softWrap: false,
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
          overflow: TextOverflow.fade,
          maxLines: 1,
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sneaker_app/modal/brand.dart';
import 'package:sneaker_app/screen/product_screen.dart';

class BrandCatagory extends StatelessWidget {
  const BrandCatagory({
    Key? key,
    required this.brand,
  }) : super(key: key);
  final Brand brand;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RawMaterialButton(
          onPressed: () {
            if (brand.name != 'More')
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => ProductScreen(
                            brand: brand,
                          ))));
          },
          elevation: 2.0,
          fillColor: Color(0xFFECECEC),
          child: Image(
            height: 30,
            width: 30,
            fit: BoxFit.scaleDown,
            image: NetworkImage(brand.imageUrl),
          ),
          padding: EdgeInsets.all(12.0),
          shape: CircleBorder(),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          brand.name,
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

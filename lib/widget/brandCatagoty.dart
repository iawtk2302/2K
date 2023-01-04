import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sneaker_app/model/brand.dart';
import 'package:sneaker_app/screen/brand_screen.dart';
import 'package:sneaker_app/screen/product_screen.dart';

import '../bloc/product/product_bloc.dart';

class BrandCategory extends StatelessWidget {
  const BrandCategory({
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
            if (brand.name != 'More') {
              context.read<ProductBloc>().add(LoadProduct(
                  idBrand: brand.id!,
                  context: context,
                  gender: ["Women", "Men"],
                  sortBy: SortBy.none));
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => ProductScreen(
                            brand: brand,
                          ))));
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const BrandScreen())));
            }
          },
          elevation: 2.0,
          fillColor: Theme.of(context).backgroundColor,
          child: Image(
            height: 30,
            width: 30,
            fit: BoxFit.scaleDown,
            image: NetworkImage(brand.imageUrl.toString()),
          ),
          padding: EdgeInsets.all(12.0),
          shape: CircleBorder(),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          brand.name.toString(),
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

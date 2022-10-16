// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:sneaker_app/model/product_cart.dart';
import 'package:sneaker_app/screen/product_detail.dart';

import '../modal/product.dart';

class Cart extends Equatable {
  final List<ProductCart> products;
  const Cart({required this.products});

  int calculatePrice() {
    int totalPrice = 0;
    products.forEach((element) {
      totalPrice += element.product!.price! * element.amount!;
    });
    print(totalPrice);

    return totalPrice;
  }

  @override
  List<Object?> get props => [products];
}

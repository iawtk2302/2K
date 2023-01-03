// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:sneaker_app/model/product_cart.dart';
import 'package:sneaker_app/screen/product_detail.dart';

class Cart extends Equatable {
  final List<ProductCart> products;
  const Cart({required this.products});

  String calculatePrice() {
    final format = NumberFormat("###,###.###", "tr_TR");
    double totalPrice = 0;
    products.forEach((element) {
      totalPrice += element.product!.price! * (element.amount)!;
    });
    print(totalPrice);

    return format.format(totalPrice);
  }

  @override
  List<Object?> get props => [products];
}

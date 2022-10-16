// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:sneaker_app/modal/product.dart';

class ProductCart extends Equatable {
  Product? product;
  int? amount;
  ProductCart({
    required this.product,
    required this.amount,
  });

  ProductCart.fromJson(Map<String, dynamic> json) {
    product = Product.fromJson(json['product']);
    amount = json['amount'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product'] = this.product;
    data['amount'] = this.amount;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [product];
}

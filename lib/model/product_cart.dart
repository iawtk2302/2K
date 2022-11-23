import 'package:equatable/equatable.dart';
import 'package:sneaker_app/model/product.dart';

class ProductCart extends Equatable {
  Product? product;
  int? amount;
  double? size;
  ProductCart({
    required this.product,
    required this.amount,
    required this.size,
  });

  ProductCart.fromJson(Map<String, dynamic> json) {
    product = Product.fromJson(json['product']);
    amount = json['amount'];
    size = json['size'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product'] = this.product;
    data['amount'] = this.amount;
    data['size'] = this.size;
    return data;
  }

  @override
  List<Object?> get props => [product, size];
}
